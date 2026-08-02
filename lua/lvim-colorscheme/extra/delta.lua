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
    local delta = util.template([[
[delta]
    syntax-theme = ]] .. bat_theme .. [[

    zero-style = syntax
    blame-code-style = syntax
    merge-conflict-ours-diff-header-decoration-style = ''
    merge-conflict-theirs-diff-header-decoration-style = ''

    file-style = omit "${magenta}"
    commit-decoration-style = "${magenta_dark}" ol
    commit-style = raw
    blame-separator-style = "${comment}"
    hunk-header-decoration-style = "${orange}" ul
    hunk-header-file-style = "${green}"
    hunk-header-line-number-style = "${green_dark}"
    hunk-header-style = file line-number syntax bold italic
    minus-style = syntax "${diff.delete}"
    minus-non-emph-style = syntax "${diff.delete}"
    minus-emph-style = syntax "${delta.delete}"
    minus-empty-line-marker-style = syntax "${diff.delete}"
    line-numbers-minus-style = "${git.delete}"
    plus-style = syntax "${diff.add}"
    plus-non-emph-style = syntax "${diff.add}"
    plus-emph-style = syntax "${delta.add}"
    plus-empty-line-marker-style = syntax "${diff.add}"
    line-numbers-plus-style = "${git.add}"
    line-numbers-zero-style = "${fg}"
    whitespace-error-style = "${purple}"
    merge-conflict-ours-diff-header-style = "${yellow}" bold
    merge-conflict-theirs-diff-header-style = "${yellow_dark}" bold overline
    map-styles = \
        bold purple => syntax "${bg_soft_dark}", \
        bold blue => syntax "${bg_dark}", \
        bold cyan => syntax "${bg_soft_light}", \
        bold yellow => syntax "${bg_light}"]], colors)
    return delta
end

return M
