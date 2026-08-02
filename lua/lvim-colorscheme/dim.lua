-- lvim-colorscheme.dim: focus-follow manager for the `dim_inactive` and `dark_active` options. The
-- "active" window is always the last-focused REAL editor window (a normal-buffer, non-floating window) —
-- floats and panels (pickers, the diagnostics peek, neo-tree, quickfix, …) never become the active
-- window, are never dimmed, and never darkened. So opening or focusing one of them leaves the editor
-- exactly as it was (its dim/dark state only changes when focus moves to ANOTHER real buffer).
--
--   • dim_inactive — mutes the FOREGROUND of every non-active real window via a window-local highlight
--     namespace (|nvim_win_set_hl_ns|), leaving backgrounds untouched (so it coexists with `transparent`
--     and never reads as see-through). Dimming a `winhighlight`-themed window would strip its bg (Neovim
--     bypasses winhighlight under a custom namespace), so those are excluded.
--   • dark_active — base.lua makes the focused window's `Normal` bg darker (`NormalNC` stays normal).
--     That native current-window mechanism breaks the moment a float steals focus (the editor falls to
--     `NormalNC` and lightens), so here the active real window is pinned dark with a `NormalNC:Normal`
--     winhighlight while it is not current.
--
---@module "lvim-colorscheme.dim"

local api = vim.api
local dim = require("lvim-utils.dim")

local M = {}

---@type integer? the highlight namespace holding the dimmed (fg-muted) copies (built on first use)
M.ns = nil
---@type boolean the namespace's contents no longer match the live palette/amount — rebuild before next use.
--- Starts true so the first window that needs dimming builds it.
local stale = true
---@type integer? augroup id for the focus-follow autocmds
local aug = nil
---@type integer? the last-focused REAL editor window (the active window)
M.active = nil

-- Effective options, set by enable().
M.opts = { dim = false, dim_amount = 0.4, dark = false, bg = "#000000" }

-- The winhighlight that keeps a window's bg "active" (dark) even when it is NOT the current window.
local DARK_HL = "NormalNC:Normal"

---@type table<integer, true> windows switched to the dim namespace (only ever reset our own).
local dimmed = {}
---@type table<integer, true> windows given the DARK_HL winhighlight override.
local dark_marked = {}

---A REAL editor window: non-floating, a normal (`buftype == ""`) buffer, and not self-themed via
---`winhighlight` (only OUR own dark override is allowed). Floats and panels (nofile / quickfix / help /
---terminal / neo-tree …) are therefore never active, never dimmed, never darkened.
---@param win integer
---@return boolean
local function is_real(win)
    if not api.nvim_win_is_valid(win) then
        return false
    end
    if api.nvim_win_get_config(win).relative ~= "" then
        return false
    end
    if vim.bo[api.nvim_win_get_buf(win)].buftype ~= "" then
        return false
    end
    local wh = vim.wo[win].winhighlight or ""
    return wh == "" or dark_marked[win] == true
end

---Build the dim namespace, or rebuild it when it no longer matches the live palette. Called from the ONE
---place that reads it — the moment a window is actually switched onto it.
---
---DEFERRED ON PURPOSE. The namespace is a full muted copy of EVERY highlight group (measured at 8.3 ms on a
---433-group theme, a third of this plugin's whole load cost), and nothing reads it until some window is not
---the active one. A single-window session — every startup, the dashboard included — never dims anything, so
---building it in `enable()` charged that 8.3 ms to every start for a namespace no window ever looked at.
---@return integer? ns
local function ensure_ns()
    if M.ns and not stale then
        return M.ns
    end
    M.ns = dim.build(M.opts.bg, M.opts.dim_amount)
    stale = false
    return M.ns
end

---Switch a window between the dim namespace and namespace 0 (full colour). Only resets a window we
---previously dimmed, so windows on someone else's namespace are left untouched.
---@param win integer
---@param on boolean
local function set_dim(win, on)
    if not api.nvim_win_is_valid(win) then
        return
    end
    if on then
        pcall(api.nvim_win_set_hl_ns, win, ensure_ns())
        dimmed[win] = true
    elseif dimmed[win] then
        pcall(api.nvim_win_set_hl_ns, win, 0)
        dimmed[win] = nil
    end
end

---Add / remove the `NormalNC:Normal` winhighlight that pins a window's bg dark while it is not current
---(preserving any existing winhighlight entries).
---@param win integer
---@param on boolean
local function set_dark(win, on)
    if not api.nvim_win_is_valid(win) then
        return
    end
    -- Enforce the desired state (not just our own tracking): a freshly opened float/split INHERITS the
    -- current window's `winhighlight`, so the active window's override leaks onto it — strip it back off
    -- any window that should NOT be dark, even one we never marked.
    --
    -- Treat `winhighlight` as a LIST of `group:target` entries and match DARK_HL as a WHOLE entry. A plain
    -- find/gsub matches it as a SUBSTRING too — e.g. `NormalNC:NormalSB` (a dark-marked sidebar) contains
    -- `NormalNC:Normal`, so stripping it left a bare `SB`, an invalid winhighlight (E474 / E5248).
    local kept, has = {}, false
    for entry in (vim.wo[win].winhighlight or ""):gmatch("[^,]+") do
        if entry == DARK_HL then
            has = true
        else
            kept[#kept + 1] = entry
        end
    end
    if on and not has then
        table.insert(kept, 1, DARK_HL)
        vim.wo[win].winhighlight = table.concat(kept, ",")
        dark_marked[win] = true
    elseif not on and has then
        vim.wo[win].winhighlight = table.concat(kept, ",")
        dark_marked[win] = nil
    end
end

---Reconcile every window in one pass against the ACTIVE real window (not the raw current window — so a
---float/panel holding focus keeps the editor active). Run on focus/layout changes.
local function reconcile()
    -- Stand down while an lvim-ui surface owns a namespace backdrop (it dims/darkens EVERY window uniformly);
    -- otherwise the two managers fight over the same windows and the backdrop covers only some of them.
    if dim.suspended then
        return
    end
    local cur = api.nvim_get_current_win()
    if is_real(cur) then
        M.active = cur
    end
    local active = (M.active and api.nvim_win_is_valid(M.active)) and M.active or cur
    for _, win in ipairs(api.nvim_list_wins()) do
        local real = is_real(win)
        set_dim(win, M.opts.dim and real and win ~= active)
        set_dark(win, M.opts.dark and real and win == active)
    end
end

---@type boolean one reconcile is already queued for this tick (coalesces bursts of focus/layout events).
local pending = false

---Queue a single reconcile for the next tick. A layout change fires several events at once
---(WinEnter + WinNew + BufWinEnter …); collapsing them into one scheduled pass avoids re-walking
---every window several times per change.
local function schedule_reconcile()
    if pending then
        return
    end
    pending = true
    vim.schedule(function()
        pending = false
        reconcile()
    end)
end

---Point the dim namespace at a new palette. Call after every theme apply so the dimmed copies track it.
---
---The rebuild itself is DEFERRED to the next window that is actually dimmed (see `ensure_ns`) — except when
---a window is wearing the namespace right now, in which case it is showing the OLD palette on screen and the
---rebuild cannot wait. That is the theme picker's live preview with a split open.
---@param bg_hex string  editor background colour the foregrounds are muted toward (colors.bg)
---@param amount number   fraction the foreground is blended toward bg (0..1)
function M.build(bg_hex, amount)
    M.opts.bg = bg_hex or M.opts.bg
    M.opts.dim_amount = amount or M.opts.dim_amount
    stale = true
    if M.ns and next(dimmed) then
        ensure_ns()
    end
end

---Enable the focus-follow manager: reconcile once, then install the focus/layout autocmds that keep the
---active real window full-colour + dark. The dim namespace is NOT built here — `reconcile` builds it through
---`ensure_ns` the first time a window actually has to be dimmed (see `ensure_ns` for why).
---@param opts { dim?: boolean, dim_amount?: number, dark?: boolean, bg?: string }
function M.enable(opts)
    M.opts = {
        dim = opts.dim or false,
        dim_amount = math.max(0, math.min(1, opts.dim_amount or 0.4)),
        dark = opts.dark or false,
        bg = opts.bg or "#000000",
    }
    -- The options (palette, amount) just changed, so whatever the namespace holds is from the previous theme.
    stale = true
    aug = api.nvim_create_augroup("LvimColorschemeDim", { clear = true })
    reconcile()
    -- Reconcile on any focus/layout change. `BufWinEnter`/`WinNew` catch panels that open without taking
    -- focus; `TabEnter` re-applies after a tab switch; `WinClosed` re-picks the active window if it closes.
    -- Coalesced (schedule_reconcile) so a burst of these events costs one window walk, not several.
    api.nvim_create_autocmd({ "WinEnter", "WinNew", "BufWinEnter", "TabEnter", "WinClosed" }, {
        group = aug,
        callback = function(ev)
            -- Prune our per-window tracking for a window that just closed, so the tables don't grow
            -- unbounded across a long session (reconcile only ever visits still-open windows).
            if ev.event == "WinClosed" then
                local win = tonumber(ev.match)
                if win then
                    dimmed[win] = nil
                    dark_marked[win] = nil
                end
            end
            schedule_reconcile()
        end,
    })
end

---Disable: drop the autocmds, reset every window WE dimmed back to namespace 0, and remove every dark
---override we added (windows on another plugin's namespace / winhighlight are left alone).
function M.disable()
    if aug then
        pcall(api.nvim_del_augroup_by_id, aug)
        aug = nil
    end
    for win in pairs(dimmed) do
        if api.nvim_win_is_valid(win) then
            pcall(api.nvim_win_set_hl_ns, win, 0)
        end
    end
    dimmed = {}
    for win in pairs(dark_marked) do
        set_dark(win, false)
    end
    dark_marked = {}
    M.active = nil
end

-- When an lvim-ui surface takes over dimming (its namespace backdrop), RELEASE every window we hold so the
-- backdrop paints them all uniformly; when it lets go, re-reconcile (only if this manager is actually enabled).
dim.on_suspend(function(suspended)
    if suspended then
        for win in pairs(dimmed) do
            set_dim(win, false)
        end
        for win in pairs(dark_marked) do
            set_dark(win, false)
        end
    elseif aug then
        reconcile()
    end
end)

return M
