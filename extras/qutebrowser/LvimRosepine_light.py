palette = {
    "background": "#E4E4E4",
    "background-alt": "#e9e9e9",
    "background-attention": "#dadada",
    "border": "#dfdfdf",
    "current-line": "#e9e9e9",
    "selection": "#eeeeee",
    "foreground": "#5e8888",
    "foreground-alt": "#55a6ab",
    "foreground-attention": "#4c969a",
    "comment": "#95718d",
    "cyan": "#606d6d",
    "green": "#5d6c60",
    "orange": "#a58382",
    "pink": "#6d5f81",
    "purple": "#7f7c88",
    "red": "#8e656e",
    "yellow": "#8c7b6a",

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
    "ui-foreground": "#4c6262",
    "ui-comment": "#6e5869",
    "text-red": "#805d64",
    "text-green": "#5b695e",
    "text-yellow": "#6e6358",
    "text-orange": "#77605f",
    "text-cyan": "#5c6868",
    "text-purple": "#66636e",
    "selected-green": "#556258",

    # --- text ON an accent, and the accent under it ------------------------------------------
    # Here the background is the palette's and the text is derived: whichever of the theme's own
    # background and a plain white reads better on that accent. **Choosing the better of two is not
    # always enough** — the accent caps what any text on it can reach, and on solarized_soft the
    # best available text on `red` still read at 2.88:1 — so where it falls short the strip gives a
    # step of hsluv lightness as well. The hue is held, so a red strip stays red and `"red"` itself
    # is untouched for everything that paints with it.
    "on-red": "#ffffff",
    "on-orange": "#ffffff",
    "on-yellow": "#ffffff",
    "on-green": "#ffffff",
    "on-cyan": "#ffffff",
    "on-purple": "#ffffff",
    "on-pink": "#ffffff",
    "strip-red": "#8e656e",
    "strip-orange": "#8e6f6f",
    "strip-yellow": "#837465",
    "strip-green": "#5d6c60",
    "strip-cyan": "#606d6d",
    "strip-purple": "#777480",
    "strip-pink": "#6d5f81",
    "hint-match": "#ffffff",
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
