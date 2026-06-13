-- lvim-colorscheme.dim: foreground-only dimming of non-focused windows (the `dim_inactive`
-- option). Independent of `dark_active`, which darkens the FOCUSED window's bg in base.lua.
--
-- Dimming a window by its BACKGROUND fails under a translucent terminal: a darker bg just
-- lets more of the wallpaper bleed through, so the window reads see-through rather than
-- dimmed. So this mutes the FOREGROUND of every non-current window via a window-local
-- highlight namespace (|nvim_win_set_hl_ns|), leaving each window's background identical — so
-- it coexists with `transparent` and never reads as transparency.
--
-- The namespace holds a dimmed copy of every currently-defined highlight group (fg/sp
-- blended toward the editor background); the current window keeps namespace 0 (full colour),
-- the rest are switched to the dim namespace by the focus/layout autocmds. Windows that theme
-- themselves via `winhighlight` (neo-tree, …) are excluded — Neovim bypasses `winhighlight`
-- under a custom namespace, which would strip their background.
--
---@module "lvim-colorscheme.dim"

local api = vim.api

local M = {}

---@type integer? the highlight namespace holding the dimmed copies (lazily created)
M.ns = nil
---@type integer? augroup id for the focus-follow autocmds
local aug = nil

---Numeric (0xRRGGBB) blend of `fg` toward `bg` by fraction `t` (0 = fg, 1 = bg).
---@param fg integer
---@param bg integer
---@param t number
---@return integer
local function blend(fg, bg, t)
    local fr, fgc, fb = math.floor(fg / 65536) % 256, math.floor(fg / 256) % 256, fg % 256
    local br, bgc, bb = math.floor(bg / 65536) % 256, math.floor(bg / 256) % 256, bg % 256
    local r = math.floor(fr * (1 - t) + br * t + 0.5)
    local g = math.floor(fgc * (1 - t) + bgc * t + 0.5)
    local b = math.floor(fb * (1 - t) + bb * t + 0.5)
    return r * 65536 + g * 256 + b
end

---@type table<integer, true> windows we have switched to the dim namespace (so we only ever
--- reset windows we ourselves dimmed — never clobber a namespace another plugin owns).
local dimmed = {}

---A window is dimmable only if it is normal (non-floating) AND does not theme itself through
---`winhighlight`. Neovim bypasses a window's `winhighlight` remaps while the window is on a
---custom highlight namespace (|nvim_win_set_hl_ns|), so dimming such a window would strip its
---themed background — e.g. neo-tree's dark sidebar would fall back to the editor's Normal bg.
---Those self-themed panels are therefore left at full colour (and keep their own background).
---@param win integer
---@return boolean
local function is_dimmable(win)
    if not api.nvim_win_is_valid(win) then
        return false
    end
    if api.nvim_win_get_config(win).relative ~= "" then
        return false
    end
    return (vim.wo[win].winhighlight or "") == ""
end

---Switch a window between the dim namespace and namespace 0 (full colour). Only resets a
---window we previously dimmed, so windows on someone else's namespace are left untouched.
---@param win integer
---@param dim boolean
local function set_dim(win, dim)
    if not api.nvim_win_is_valid(win) then
        return
    end
    if dim then
        pcall(api.nvim_win_set_hl_ns, win, M.ns)
        dimmed[win] = true
    elseif dimmed[win] then
        pcall(api.nvim_win_set_hl_ns, win, 0)
        dimmed[win] = nil
    end
end

---Reconcile every window in one pass: the current window gets full colour, all other
---DIMMABLE windows get the dim namespace, and self-themed/floating windows are un-dimmed.
---Run on focus/layout changes so panels that open WITHOUT taking focus (neo-tree, outline, …)
---are handled too — a WinLeave-only approach misses any window that is never explicitly left.
local function reconcile()
    local cur = api.nvim_get_current_win()
    for _, win in ipairs(api.nvim_list_wins()) do
        if is_dimmable(win) then
            set_dim(win, win ~= cur)
        else
            set_dim(win, false)
        end
    end
end

---(Re)build the dim namespace from the current global highlights. Call after every theme
---apply so the dimmed copies track the active palette.
---@param bg_hex string  editor background colour the foregrounds are muted toward (colors.bg)
---@param amount number   fraction the foreground is blended toward bg (0..1)
function M.build(bg_hex, amount)
    M.ns = M.ns or api.nvim_create_namespace("lvim_colorscheme_dim")
    local bg = tonumber((bg_hex or "#000000"):gsub("#", ""), 16) or 0
    for name, def in pairs(api.nvim_get_hl(0, {})) do
        if def.link then
            -- Keep the link; the target is dimmed in this same namespace, so it resolves dim.
            api.nvim_set_hl(M.ns, name, { link = def.link })
        else
            local d = vim.deepcopy(def)
            if d.fg then
                d.fg = blend(d.fg, bg, amount)
            end
            if d.sp then
                d.sp = blend(d.sp, bg, amount)
            end
            -- bg/ctermbg left untouched so the window background (incl. NONE) is unchanged.
            api.nvim_set_hl(M.ns, name, d)
        end
    end
end

---Enable fg-dimming: build the namespace, dim every non-current dimmable window, and install
---the focus/layout autocmds that keep the focused window at full colour.
---@param bg_hex string
---@param amount? number  foreground blend, default 0.4
function M.enable(bg_hex, amount)
    M.build(bg_hex, amount or 0.4)
    aug = api.nvim_create_augroup("LvimColorschemeDim", { clear = true })
    reconcile()
    -- Reconcile on any focus/layout change. `BufWinEnter`/`WinNew` catch panels that open
    -- without taking focus; `TabEnter` re-dims after a tab switch. Scheduled so the current
    -- window is settled (e.g. during startup `BufWinEnter`) before we read it.
    api.nvim_create_autocmd({ "WinEnter", "WinNew", "BufWinEnter", "TabEnter" }, {
        group = aug,
        callback = function()
            vim.schedule(reconcile)
        end,
    })
end

---Disable fg-dimming: drop the autocmds and reset every window WE dimmed back to namespace 0
---(windows on another plugin's namespace are left alone).
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
end

return M
