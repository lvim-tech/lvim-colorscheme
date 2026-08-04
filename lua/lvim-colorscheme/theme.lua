-- lvim-colorscheme.theme: the apply step — turn a resolved palette + groups into live nvim
-- highlights. Sets `colors_name`, applies every highlight group, seeds the terminal ANSI
-- colours, drives the dim/dark focus manager, publishes to `state`, and fires the
-- `User LvimColorscheme` autocmd. The picker's live preview (`opts._preview`) reuses this with
-- a lighter path (no `hi clear`) — see the note at the top of setup().
--
---@module "lvim-colorscheme.theme"

local config = require("lvim-colorscheme.config")
local colors_mod = require("lvim-colorscheme.colors")
local groups_mod = require("lvim-colorscheme.groups")
local state = require("lvim-colorscheme.state")

local M = {}

--- Resolve `opts` against the live config, build + apply the palette and highlight groups,
--- publish to `state`, and fire the `User LvimColorscheme` autocmd.
---@param opts? lvim-colorscheme.Config
---@return ColorScheme colors, lvim-colorscheme.Highlights groups, lvim-colorscheme.Config opts
function M.setup(opts)
    opts = config.extend(opts)

    local colors = colors_mod.setup(opts)
    local groups = groups_mod.setup(colors, opts)

    -- Preview (`opts._preview`, set by the picker's live preview) skips only `hi clear`:
    -- it is unnecessary between lvim variants (the group set is identical, so nvim_set_hl
    -- overwrites cleanly) and clearing flickers the picker's stacked-float borders. The
    -- User autocmd IS still fired so self-theming plugins (lvim-utils etc.) re-sync their
    -- palette and recolour live — that is the whole point of preview.
    local preview = opts._preview == true

    -- only needed to clear when not the default colorscheme
    if vim.g.colors_name and not preview then
        vim.cmd("hi clear")
    end

    vim.o.termguicolors = true
    vim.g.colors_name = "lvim-" .. opts.style

    for group, hl in pairs(groups) do
        -- A group is either a definition table or a bare string naming the group it links to.
        if type(hl) == "string" then
            vim.api.nvim_set_hl(0, group, { link = hl })
        else
            vim.api.nvim_set_hl(0, group, hl)
        end
    end

    if opts.terminal_colors then
        M.terminal(colors)
    end

    -- Publish to state and notify listeners
    state.colors = colors
    state.opts = opts
    for _, fn in ipairs(state.listeners) do
        pcall(fn, colors, opts)
    end
    -- `data` lets listeners persist only COMMITTED changes: the picker's live preview sets
    -- preview = true, so a config can save the theme to its store on a real change while
    -- ignoring the preview keystrokes. `style` is the applied style (e.g. "everforest_dark").
    vim.api.nvim_exec_autocmds("User", {
        pattern = "LvimColorscheme",
        modeline = false,
        data = { style = opts.style, preview = preview },
    })

    -- If an lvim-ui surface backdrop is open (e.g. THIS theme picker, previewing under a dim/darken veil),
    -- rebuild its namespace from the freshly-applied highlights so the veiled editor tracks the new theme
    -- instead of freezing on the palette captured when the picker opened. No-op when no backdrop is up.
    --
    -- AFTER the User autocmd, and that ordering is the whole point. A namespace is a SNAPSHOT: whatever a
    -- group looks like the moment the veil is built is what the veiled windows keep showing. Only the groups
    -- SET above (lines 41-44) are lvim-colorscheme's own; every self-themed group in the set —
    -- `LvimUi*`, the chrome bars, the panels — recolours from `lvim-utils.colors`, which re-syncs on that
    -- autocmd (synchronously, `sync_from_lcs` → the on_change listeners). Rebuilding BEFORE it therefore
    -- captured those groups still in the OLD palette and froze them there: previewing a dark variant from a
    -- light theme left the statusline, the winbar chip and the tree's cursor row as LIGHT strips on a now-dark
    -- screen, while groups the stale veil did not define at all fell back to ns 0 and came back at full,
    -- undimmed colour. Half the screen in the new theme, half in the old one.
    pcall(function()
        require("lvim-ui.surface").refresh_backdrop()
    end)

    -- `dim_inactive`: point the manager at the new palette AFTER listeners/User autocmds, so the self-themed
    -- dependent groups it copies are already synced. `dim.build` only re-walks the highlight table when a
    -- window is wearing the dim namespace right now — otherwise it just marks it stale and the next dimmed
    -- window builds it (which is why the `dim.ns` guard that used to sit here is gone: build self-guards).
    local ok_dim, dim = pcall(require, "lvim-colorscheme.dim")
    if ok_dim then
        if preview then
            if opts.dim_inactive then
                dim.build(colors.bg, opts.dim_inactive_amount)
            end
        elseif opts.dim_inactive or opts.dark_active then
            dim.enable({
                dim = opts.dim_inactive,
                dim_amount = opts.dim_inactive_amount,
                dark = opts.dark_active,
                bg = colors.bg,
            })
        else
            dim.disable()
        end
    end

    return colors, groups, opts
end

---@param colors ColorScheme
function M.terminal(colors)
    -- stylua: ignore
    local map = {
        { 0, "black" }, { 8,  "black_bright"   },
        { 7, "white" }, { 15, "white_bright"   },
        { 1, "red"   }, { 9,  "red_bright"     },
        { 2, "green" }, { 10, "green_bright"   },
        { 3, "yellow"}, { 11, "yellow_bright"  },
        { 4, "blue"  }, { 12, "blue_bright"    },
        { 5, "magenta"},{ 13, "magenta_bright" },
        { 6, "cyan"  }, { 14, "cyan_bright"    },
    }
    for _, pair in ipairs(map) do
        vim.g["terminal_color_" .. pair[1]] = colors.terminal[pair[2]]
    end
end

return M
