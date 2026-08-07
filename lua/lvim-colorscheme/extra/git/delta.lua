-- lvim-colorscheme.extra.delta: generate a Delta (git pager) theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.delta"

---@class DeltaColors
---@field add string
---@field delete string

---@class DiffColors
---@field add string
---@field delete string

---@class GitColors
---@field add string
---@field delete string
---@field change string

---@class ColorScheme
---@field diff DiffColors
---@field delta DeltaColors
---@field git GitColors
---@field fg string
---@field _style string

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    colors.delta = {
        add = util.brighten(colors.diff.add, 0.01, 0.5),
        delete = util.brighten(colors.diff.delete, 0.01, 0.5),
    }
    local bat_theme = "Lvim" .. (colors._style:gsub("^%l", string.upper))
    -- Styles and the matching bat syntax-theme only. The behaviour keys this
    -- used to carry (side-by-side, navigate, line-numbers, labels, symbols,
    -- blame-format) are the user's [delta] section in ~/.gitconfig — they were
    -- identical in all 48 files and duplicated on every regeneration.
    -- Text here lands on the TERMINAL's background, which this project themes from the same
    -- palette -- so `terminal.background` is the honest surface rather than a guess. The palette's
    -- own `terminal.*` entries are never re-floored: ANSI 0-15 is a measured hierarchy of its own
    -- in `colors/init.lua` and a second floor on top would undo it.
    --
    -- Only what delta writes as a WORD on the terminal is floored: the hunk header's file name and
    -- line number, the blame separator, the whitespace-error marker, the merge-conflict headers and
    -- the line numbers either side of a diff.
    --
    -- The diff washes are NOT floored and must not be. `minus-style`, `plus-style` and their
    -- `-non-emph`/`-emph`/`-empty-line-marker` siblings paint a BACKGROUND behind syntax-highlighted
    -- code -- the `syntax` keyword in each of them means the foreground stays bat's, which this
    -- palette already generates -- so lifting them would wash out the code they sit behind. The
    -- four `map-styles` entries are backgrounds for the same reason, and
    -- `commit-decoration-style` is an overline rule.
    local function text(hex)
        return util.ensure_contrast(hex, colors.terminal.background, 4.5)
    end
    colors.d_magenta = text(colors.magenta)
    colors.d_comment = text(colors.comment)
    colors.d_orange = text(colors.orange)
    colors.d_green = text(colors.green)
    colors.d_green_dark = text(colors.green_dark)
    colors.d_git_delete = text(colors.git.delete)
    colors.d_git_add = text(colors.git.add)
    colors.d_fg = text(colors.fg)
    colors.d_purple = text(colors.purple)
    colors.d_yellow = text(colors.yellow)
    colors.d_yellow_dark = text(colors.yellow_dark)
    local delta = util.template([[
[delta]
    syntax-theme = ]] .. bat_theme .. [[

    zero-style = syntax
    blame-code-style = syntax
    merge-conflict-ours-diff-header-decoration-style = ''
    merge-conflict-theirs-diff-header-decoration-style = ''

    file-style = omit "${d_magenta}"
    commit-decoration-style = "${magenta_dark}" ol
    commit-style = raw
    blame-separator-style = "${d_comment}"
    hunk-header-decoration-style = "${d_orange}" ul
    hunk-header-file-style = "${d_green}"
    hunk-header-line-number-style = "${d_green_dark}"
    hunk-header-style = file line-number syntax bold italic
    minus-style = syntax "${diff.delete}"
    minus-non-emph-style = syntax "${diff.delete}"
    minus-emph-style = syntax "${delta.delete}"
    minus-empty-line-marker-style = syntax "${diff.delete}"
    line-numbers-minus-style = "${d_git_delete}"
    plus-style = syntax "${diff.add}"
    plus-non-emph-style = syntax "${diff.add}"
    plus-emph-style = syntax "${delta.add}"
    plus-empty-line-marker-style = syntax "${diff.add}"
    line-numbers-plus-style = "${d_git_add}"
    line-numbers-zero-style = "${d_fg}"
    whitespace-error-style = "${d_purple}"
    merge-conflict-ours-diff-header-style = "${d_yellow}" bold
    merge-conflict-theirs-diff-header-style = "${d_yellow_dark}" bold overline
    map-styles = \
        bold purple => syntax "${bg_soft_dark}", \
        bold blue => syntax "${bg_dark}", \
        bold cyan => syntax "${bg_soft_light}", \
        bold yellow => syntax "${bg_light}"]], colors)
    return delta
end

return M
