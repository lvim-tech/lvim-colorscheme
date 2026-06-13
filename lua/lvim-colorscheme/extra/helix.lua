local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
# Lvim Colorscheme for Helix

"ui.background" = { bg = "bg_dark" }
"ui.text" = "fg"
"ui.text.focus" = "fg_light"
"ui.cursor" = { fg = "bg_dark", bg = "green" }
"ui.cursor.primary" = { fg = "bg_dark", bg = "green" }
"ui.cursorline.primary" = { bg = "bg" }
"ui.selection" = { bg = "bg_visual" }
"ui.linenr" = "fg_dark"
"ui.linenr.selected" = "fg_light"
"ui.statusline" = { fg = "fg", bg = "bg" }
"ui.statusline.inactive" = { fg = "fg_dark", bg = "bg" }
"ui.popup" = { fg = "fg", bg = "bg_float" }
"ui.window" = { fg = "bg_highlight" }
"ui.help" = { fg = "fg", bg = "bg_float" }
"ui.menu" = { fg = "fg", bg = "bg_float" }
"ui.menu.selected" = { fg = "bg_dark", bg = "blue" }
"ui.virtual.whitespace" = "bg_highlight"
"ui.virtual.ruler" = { bg = "bg" }
"ui.virtual.inlay-hint" = "comment"

"comment" = { fg = "comment", modifiers = ["italic"] }
"variable" = "fg"
"variable.builtin" = "red"
"variable.parameter" = "fg_light"
"constant" = "orange"
"constant.builtin" = "orange"
"constant.numeric" = "orange"
"string" = "green"
"string.regexp" = "cyan"
"keyword" = "purple"
"keyword.control" = "purple"
"function" = "blue"
"function.builtin" = "blue"
"function.macro" = "cyan"
"type" = "yellow"
"type.builtin" = "yellow"
"constructor" = "yellow"
"operator" = "cyan"
"punctuation" = "fg_dark"
"label" = "red"
"tag" = "red"
"namespace" = "yellow"
"attribute" = "cyan"

"markup.heading" = { fg = "blue", modifiers = ["bold"] }
"markup.bold" = { modifiers = ["bold"] }
"markup.italic" = { modifiers = ["italic"] }
"markup.link.url" = { fg = "cyan", modifiers = ["underlined"] }
"markup.link.text" = "red"
"markup.raw" = "green"

"diff.plus" = "git.add"
"diff.delta" = "git.change"
"diff.minus" = "git.delete"

"diagnostic.error" = { underline = { color = "red", style = "curl" } }
"diagnostic.warning" = { underline = { color = "yellow", style = "curl" } }
"diagnostic.info" = { underline = { color = "blue", style = "curl" } }
"diagnostic.hint" = { underline = { color = "cyan", style = "curl" } }
"error" = "red"
"warning" = "yellow"
"info" = "blue"
"hint" = "cyan"

[palette]
bg_dark = "${bg_dark}"
bg = "${bg}"
bg_float = "${bg_float}"
bg_highlight = "${bg_highlight}"
bg_visual = "${bg_visual}"
fg = "${fg}"
fg_light = "${fg_light}"
fg_dark = "${fg_dark}"
comment = "${comment}"
blue = "${blue}"
cyan = "${cyan}"
green = "${green}"
orange = "${orange}"
purple = "${purple}"
red = "${red}"
yellow = "${yellow}"
"git.add" = "${git.add}"
"git.change" = "${git.change}"
"git.delete" = "${git.delete}"]],
        colors
    )
end

return M
