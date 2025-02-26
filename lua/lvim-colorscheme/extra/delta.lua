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
    local delta = util.template([[
[delta]
    syntax-theme = ]] .. bat_theme .. [[

    side-by-side = false
    navigate = true
    hyperlinks = true
    keep-plus-minus-markers = false
    zero-style = syntax
    file-added-label = [+]
    file-copied-label = [==]
    file-modified-label = [*]
    file-removed-label = [-]
    file-renamed-label = [->]
    line-numbers = true
    line-numbers-left-format = "{nm:>1} "
    line-numbers-right-format = "{np:>1} "
    blame-code-style = syntax 
    blame-format = "{author:<18} ({commit:>7}) {timestamp:^16} "
    merge-conflict-begin-symbol = ⌃
    merge-conflict-end-symbol = ⌄
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
        bold yellow => syntax "${bg_light}"
    zero-style = syntax]], colors)
    return delta
end

return M
