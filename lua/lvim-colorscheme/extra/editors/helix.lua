-- lvim-colorscheme.extra.helix: generate a Helix theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.helix"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    -- helix is an EDITOR, so most of what this file emits is syntax — a deliberate hierarchy in
    -- which a comment recedes because that is its job, and measured against 4.5 every
    -- colourscheme in the world "fails". What is floored here is the CHROME that is read as
    -- words: the statusline, the gutter, the popup, the menu, the picker and the diagnostics.
    --
    -- `ui.text` is left with them rather than floored. It is helix's `Normal` — the buffer's own
    -- body text and the base the syntax hierarchy is built on — and `groups/base.lua` leaves
    -- neovim's `Normal` at the palette's muted `fg` (2.03:1 on kanagawa_soft) while flooring every
    -- float and popup around it. The popup, the menu, the help box and the statusline each
    -- declare their own foreground below, so leaving `ui.text` costs none of them.
    -- `ui.virtual.inlay-hint` is left for the matching reason: neovim's `LspInlayHint` is virtual
    -- text the editor invents, not text the file contains.
    --
    -- Measured across the 48 styles before this existed, 469 of helix's 720 chrome pairs were
    -- under WCAG AA's 4.5:1 — the inactive statusline at **1.42:1** and the gutter's line numbers
    -- at **1.49:1** on base_soft, which is a line number that cannot be read.
    --
    -- The split is the one `extra/desktop/qutebrowser.lua` makes: the sixteen palette names below
    -- stay exactly what the palette says, so every syntax line and every line that paints a
    -- BACKGROUND with an accent is untouched, and the floored values are separate names that only
    -- the chrome lines read.
    local surfaces = { colors.bg_dark, colors.bg, colors.bg_float, colors.bg_visual }
    local function ui(hex)
        return util.ensure_contrast(hex, util.hardest(hex, unpack(surfaces)), 4.5)
    end

    -- Two accents are used as SURFACES: the selected menu row and the cursor block, which has a
    -- character under it. The accent must not move far — a cursor that is no longer green has
    -- stopped matching the theme — so the text is chosen from the two the theme has and the
    -- accent gives a step of hsluv lightness only where that is not enough.
    local menu_fg = util.readable_on(colors.blue, colors.bg_dark)
    local menu_bg = util.ensure_contrast(colors.blue, menu_fg, 4.5)
    local cursor_fg = util.readable_on(colors.green, colors.bg_dark)
    local cursor_bg = util.ensure_contrast(colors.green, cursor_fg, 4.5)

    local t = vim.tbl_extend("force", colors, {
        ui_fg = ui(colors.fg),
        ui_fg_light = ui(colors.fg_light),
        ui_fg_dark = ui(colors.fg_dark),
        text_red = ui(colors.red),
        text_yellow = ui(colors.yellow),
        text_blue = ui(colors.blue),
        text_cyan = ui(colors.cyan),
        on_blue = menu_fg,
        strip_blue = menu_bg,
        on_green = cursor_fg,
        strip_green = cursor_bg,
    })

    return util.template(
        [[
# Lvim Colorscheme for Helix

"ui.background" = { bg = "bg_dark" }
"ui.text" = "fg"
"ui.text.focus" = "ui_fg_light"
"ui.cursor" = { fg = "on_green", bg = "strip_green" }
"ui.cursor.primary" = { fg = "on_green", bg = "strip_green" }
"ui.cursorline.primary" = { bg = "bg" }
"ui.selection" = { bg = "bg_visual" }
"ui.linenr" = "ui_fg_dark"
"ui.linenr.selected" = "ui_fg_light"
"ui.statusline" = { fg = "ui_fg", bg = "bg" }
"ui.statusline.inactive" = { fg = "ui_fg_dark", bg = "bg" }
"ui.popup" = { fg = "ui_fg", bg = "bg_float" }
"ui.window" = { fg = "bg_highlight" }
"ui.help" = { fg = "ui_fg", bg = "bg_float" }
"ui.menu" = { fg = "ui_fg", bg = "bg_float" }
"ui.menu.selected" = { fg = "on_blue", bg = "strip_blue" }
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
"error" = "text_red"
"warning" = "text_yellow"
"info" = "text_blue"
"hint" = "text_cyan"

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
"git.delete" = "${git.delete}"
ui_fg = "${ui_fg}"
ui_fg_light = "${ui_fg_light}"
ui_fg_dark = "${ui_fg_dark}"
text_red = "${text_red}"
text_yellow = "${text_yellow}"
text_blue = "${text_blue}"
text_cyan = "${text_cyan}"
on_blue = "${on_blue}"
strip_blue = "${strip_blue}"
on_green = "${on_green}"
strip_green = "${strip_green}"]],
        t
    )
end

return M
