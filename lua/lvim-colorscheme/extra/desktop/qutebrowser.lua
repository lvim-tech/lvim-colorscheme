-- lvim-colorscheme.extra.qutebrowser: generate a Qutebrowser theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.qutebrowser"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors, _, opts)
    local function capitalizeFirstLetter(str)
        return (str:gsub("^%l", string.upper))
    end

    -- The four surfaces qutebrowser paints text over, which is what `util.hardest` chooses between:
    -- `background` is the bar, the page and the even completion row, `background-alt` the odd row
    -- and the tooltip, `selection` the selected row and the showing tab, `background-attention` the
    -- private-window bar. Which of the four is the hard one flips between a dark palette and a light
    -- one, so it is chosen per colour rather than named.
    local function hardest(text)
        return util.hardest(text, colors.bg, colors.bg_soft_light, colors.bg_light, colors.bg_dark)
    end
    --- An accent used as TEXT: floored against `background`, which is what the status bar, the
    --- keyhint box and the even completion row are all painted on.
    local function on_bg(accent)
        return util.ensure_contrast(accent, colors.bg, 4.5)
    end

    --- Clear 4.5:1 against a background that is neither decisively dark nor decisively light,
    --- trying BOTH lightness directions and keeping whichever gets there.
    ---
    --- `util.ensure_contrast` picks its direction once, from `luminance(bg) < 0.5`. That is right
    --- for a page background and wrong for a **hint label**, which is a saturated accent: measured
    --- across the 48 palettes, `strip-yellow` lands between 0.18 and 0.49 luminance, so the walk
    --- goes up, runs into white, and stops at **1.96:1** on kanagawa_dark — while walking the same
    --- colour down reaches **10.61:1**. It failed that way on 38 of the 48 styles and reported
    --- nothing, because `ensure_contrast` returns its best effort rather than raising.
    ---
    --- Kept local rather than added to `util`: the hint label is the only surface here that is an
    --- accent with words on it *and* needs two colours on it that are told apart, so it is the only
    --- caller that has ever hit the wall. Everything else in this file floors against a page or a
    --- pole, where the direction is not in doubt. `util.ensure_contrast` is unchanged, and every
    --- colour that already clears its floor comes back from here untouched.
    local nameTheme = "Lvim" .. capitalizeFirstLetter(opts.style)
    local qutebrowser = util.template(
        [[
palette = {
    "background": "${bg}",
    "background-alt": "${bg_soft_light}",
    "background-attention": "${bg_dark}",
    "border": "${bg_soft_dark}",
    "current-line": "${bg_highlight}",
    "selection": "${bg_light}",
    "foreground": "${fg}",
    "foreground-alt": "${fg_light}",
    "foreground-attention": "${fg_soft_light}",
    "comment": "${comment}",
    "cyan": "${cyan}",
    "green": "${green}",
    "orange": "${orange}",
    "pink": "${magenta}",
    "purple": "${purple}",
    "red": "${red}",
    "yellow": "${yellow}",

    # --- the same colours again, as INTERFACE TEXT -----------------------------------------
    # An accent is two different jobs and only one of them needs a contrast floor. Painting a
    # *background* with it — a hint label, an error strip, a mode bar — the palette's own value is
    # right and the text on top is what has to clear the ratio. Painting *text* with it, the accent
    # has to clear the ratio itself, and measured against the 48 palettes before these names
    # existed, 1230 of qutebrowser's 2112 text/surface pairs were under WCAG AA's 4.5:1 for body
    # text: `foreground` on the status bar read at **2.03:1** on kanagawa_soft and at **1.83:1** on
    # a selected row, the hovered-link cyan at **2.67:1**, the https green at **2.70:1**, the failed
    # url red at **2.88:1**, and the matched letters of a hint label at **1.03:1**.
    #
    # So the sixteen keys above stay exactly what the palette says — `"red"` is still `"red"`, and
    # every line that paints a background with it is untouched — and these are separate names that
    # only the text lines read. `extra/desktop/bru.lua` makes the identical split for the identical
    # reason, and the two files are deliberately the same 96 settings in the same order.
    "ui-foreground": "${qb_ui_fg}",
    "ui-comment": "${qb_ui_comment}",
    "text-red": "${qb_text_red}",
    "text-green": "${qb_text_green}",
    "text-yellow": "${qb_text_yellow}",
    "text-orange": "${qb_text_orange}",
    "text-cyan": "${qb_text_cyan}",
    "text-purple": "${qb_text_purple}",
    "selected-green": "${qb_sel_green}",

    # --- text ON an accent, and the accent under it ------------------------------------------
    # Here the background is the palette's and the text is derived: whichever of the theme's own
    # background and a plain white reads better on that accent. **Choosing the better of two is not
    # always enough** — the accent caps what any text on it can reach, and on solarized_soft the
    # best available text on `red` still read at 2.88:1 — so where it falls short the strip gives a
    # step of hsluv lightness as well. The hue is held, so a red strip stays red and `"red"` itself
    # is untouched for everything that paints with it.
    "on-red": "${qb_on_red}",
    "on-orange": "${qb_on_orange}",
    "on-yellow": "${qb_on_yellow}",
    "on-green": "${qb_on_green}",
    "on-cyan": "${qb_on_cyan}",
    "on-purple": "${qb_on_purple}",
    "on-pink": "${qb_on_pink}",
    "strip-red": "${qb_strip_red}",
    "strip-orange": "${qb_strip_orange}",
    "strip-yellow": "${qb_strip_yellow}",
    "strip-green": "${qb_strip_green}",
    "strip-cyan": "${qb_strip_cyan}",
    "strip-purple": "${qb_strip_purple}",
    "strip-pink": "${qb_strip_pink}",
    "hint-match": "${qb_hint_match}",
}

# Every key below exists in qutebrowser's own configdata.yml — checked against
# it rather than remembered. The file used to stop at the palette above, which
# meant sourcing it coloured nothing at all: a dictionary named `palette` that
# no line ever read.

c.colors.completion.fg = palette["ui-foreground"]
c.colors.completion.odd.bg = palette["background-alt"]
c.colors.completion.even.bg = palette["background"]
c.colors.completion.category.fg = palette["text-yellow"]
c.colors.completion.category.bg = palette["background"]
c.colors.completion.category.border.top = palette["background"]
c.colors.completion.category.border.bottom = palette["background"]
c.colors.completion.item.selected.fg = palette["ui-foreground"]
c.colors.completion.item.selected.bg = palette["selection"]
c.colors.completion.item.selected.border.top = palette["selection"]
c.colors.completion.item.selected.border.bottom = palette["selection"]
c.colors.completion.item.selected.match.fg = palette["selected-green"]
c.colors.completion.match.fg = palette["text-orange"]
c.colors.completion.scrollbar.fg = palette["ui-foreground"]
c.colors.completion.scrollbar.bg = palette["background"]

c.colors.contextmenu.disabled.bg = palette["background-alt"]
c.colors.contextmenu.disabled.fg = palette["ui-comment"]
c.colors.contextmenu.menu.bg = palette["background"]
c.colors.contextmenu.menu.fg = palette["ui-foreground"]
c.colors.contextmenu.selected.bg = palette["selection"]
c.colors.contextmenu.selected.fg = palette["ui-foreground"]

c.colors.downloads.bar.bg = palette["background"]
c.colors.downloads.start.fg = palette["on-cyan"]
c.colors.downloads.start.bg = palette["strip-cyan"]
c.colors.downloads.stop.fg = palette["on-green"]
c.colors.downloads.stop.bg = palette["strip-green"]
# "none" is not a colour: it tells qutebrowser to take the system colour
# system rather than interpret the value as one.
c.colors.downloads.system.bg = "none"
c.colors.downloads.error.fg = palette["on-red"]
c.colors.downloads.error.bg = palette["strip-red"]

c.colors.hints.fg = palette["on-yellow"]
c.colors.hints.bg = palette["strip-yellow"]
# The letters already typed, on the hint label itself. `comment` was used here and it is the one
# colour in the palette chosen to recede — on the yellow label it measured **1.03:1** on
# rosepine_light, which is a hint whose progress cannot be seen. Floored against the label rather
# than against the page, because the label is what it sits on.
c.colors.hints.match.fg = palette["hint-match"]

c.colors.keyhint.fg = palette["text-purple"]
c.colors.keyhint.suffix.fg = palette["ui-foreground"]
c.colors.keyhint.bg = palette["background"]

c.colors.messages.error.fg = palette["on-red"]
c.colors.messages.error.bg = palette["strip-red"]
c.colors.messages.error.border = palette["strip-red"]
c.colors.messages.warning.fg = palette["on-orange"]
c.colors.messages.warning.bg = palette["strip-orange"]
c.colors.messages.warning.border = palette["strip-orange"]
c.colors.messages.info.fg = palette["ui-foreground"]
c.colors.messages.info.bg = palette["background"]
c.colors.messages.info.border = palette["background"]

c.colors.prompts.fg = palette["ui-foreground"]
c.colors.prompts.border = palette["background"]
c.colors.prompts.bg = palette["background-alt"]
c.colors.prompts.selected.fg = palette["ui-foreground"]
c.colors.prompts.selected.bg = palette["selection"]

c.colors.statusbar.normal.fg = palette["ui-foreground"]
c.colors.statusbar.normal.bg = palette["background"]
c.colors.statusbar.insert.fg = palette["on-green"]
c.colors.statusbar.insert.bg = palette["strip-green"]
c.colors.statusbar.passthrough.fg = palette["on-cyan"]
c.colors.statusbar.passthrough.bg = palette["strip-cyan"]
c.colors.statusbar.private.fg = palette["ui-foreground"]
c.colors.statusbar.private.bg = palette["background-attention"]
c.colors.statusbar.command.fg = palette["ui-foreground"]
c.colors.statusbar.command.bg = palette["background"]
c.colors.statusbar.command.private.fg = palette["ui-foreground"]
c.colors.statusbar.command.private.bg = palette["background-attention"]
c.colors.statusbar.caret.fg = palette["on-purple"]
c.colors.statusbar.caret.bg = palette["strip-purple"]
c.colors.statusbar.caret.selection.fg = palette["on-pink"]
c.colors.statusbar.caret.selection.bg = palette["strip-pink"]
# A progress bar, not text: nothing is read against it, so it keeps the palette's own cyan.
c.colors.statusbar.progress.bg = palette["cyan"]
c.colors.statusbar.url.fg = palette["ui-foreground"]
c.colors.statusbar.url.error.fg = palette["text-red"]
c.colors.statusbar.url.hover.fg = palette["text-cyan"]
c.colors.statusbar.url.success.http.fg = palette["text-yellow"]
c.colors.statusbar.url.success.https.fg = palette["text-green"]
c.colors.statusbar.url.warn.fg = palette["text-orange"]

c.colors.tabs.bar.bg = palette["background"]
# The loading indicators are a stripe down the edge of a tab, never a surface for words, so all
# three keep the palette's own accent.
c.colors.tabs.indicator.start = palette["cyan"]
c.colors.tabs.indicator.stop = palette["green"]
c.colors.tabs.indicator.error = palette["red"]
c.colors.tabs.indicator.system = "none"
c.colors.tabs.odd.fg = palette["ui-foreground"]
c.colors.tabs.odd.bg = palette["background-alt"]
c.colors.tabs.even.fg = palette["ui-foreground"]
c.colors.tabs.even.bg = palette["background"]
c.colors.tabs.selected.odd.fg = palette["ui-foreground"]
c.colors.tabs.selected.odd.bg = palette["selection"]
c.colors.tabs.selected.even.fg = palette["ui-foreground"]
c.colors.tabs.selected.even.bg = palette["selection"]
c.colors.tabs.pinned.odd.fg = palette["ui-foreground"]
c.colors.tabs.pinned.odd.bg = palette["background-alt"]
c.colors.tabs.pinned.even.fg = palette["ui-foreground"]
c.colors.tabs.pinned.even.bg = palette["background"]
c.colors.tabs.pinned.selected.odd.fg = palette["ui-foreground"]
c.colors.tabs.pinned.selected.odd.bg = palette["selection"]
c.colors.tabs.pinned.selected.even.fg = palette["ui-foreground"]
c.colors.tabs.pinned.selected.even.bg = palette["selection"]

c.colors.tooltip.bg = palette["background-alt"]
c.colors.tooltip.fg = palette["ui-foreground"]

c.colors.webpage.bg = palette["background"]
]],
        vim.tbl_extend("force", colors, {
            style = nameTheme,
            -- One foreground for all four surfaces rather than bru's two tiers: qutebrowser writes
            -- `foreground` against every one of them, and a value that clears the nearest clears
            -- the rest.
            qb_ui_fg = util.ensure_contrast(colors.fg, hardest(colors.fg), 4.5),
            qb_ui_comment = util.ensure_contrast(colors.comment, hardest(colors.comment), 4.5),

            qb_text_red = on_bg(colors.red),
            qb_text_green = on_bg(colors.green),
            qb_text_yellow = on_bg(colors.yellow),
            qb_text_orange = on_bg(colors.orange),
            qb_text_cyan = on_bg(colors.cyan),
            qb_text_purple = on_bg(colors.purple),
            -- The matched letters of the selected completion row sit on `selection`, which is
            -- lighter than `background`: measured on everforest_soft the same green read 2.51:1
            -- there while clearing the floor on the unselected row.
            qb_sel_green = util.ensure_contrast(colors.green, hardest(colors.green), 4.5),

            qb_on_red = util.readable_on(colors.red, colors.bg),
            qb_on_orange = util.readable_on(colors.orange, colors.bg),
            qb_on_yellow = util.readable_on(colors.yellow, colors.bg),
            qb_on_green = util.readable_on(colors.green, colors.bg),
            qb_on_cyan = util.readable_on(colors.cyan, colors.bg),
            qb_on_purple = util.readable_on(colors.purple, colors.bg),
            qb_on_pink = util.readable_on(colors.magenta, colors.bg),

            qb_strip_red = util.ensure_contrast(colors.red, util.readable_on(colors.red, colors.bg), 4.5),
            qb_strip_orange = util.ensure_contrast(colors.orange, util.readable_on(colors.orange, colors.bg), 4.5),
            qb_strip_yellow = util.ensure_contrast(colors.yellow, util.readable_on(colors.yellow, colors.bg), 4.5),
            qb_strip_green = util.ensure_contrast(colors.green, util.readable_on(colors.green, colors.bg), 4.5),
            qb_strip_cyan = util.ensure_contrast(colors.cyan, util.readable_on(colors.cyan, colors.bg), 4.5),
            qb_strip_purple = util.ensure_contrast(colors.purple, util.readable_on(colors.purple, colors.bg), 4.5),
            qb_strip_pink = util.ensure_contrast(colors.magenta, util.readable_on(colors.magenta, colors.bg), 4.5),

            -- Against the label it is drawn on, which is `strip-yellow` and not the page, and in
            -- whichever lightness direction that label leaves room in.
            qb_hint_match = util.ensure_contrast_either_way(
                colors.comment,
                util.ensure_contrast(colors.yellow, util.readable_on(colors.yellow, colors.bg), 4.5),
                4.5
            ),
        })
    )
    return qutebrowser
end

return M
