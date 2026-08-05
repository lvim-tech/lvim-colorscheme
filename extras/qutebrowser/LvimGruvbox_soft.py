palette = {
    "background": "#282726",
    "background-alt": "#2a2928",
    "background-attention": "#242322",
    "border": "#262524",
    "current-line": "#2a2928",
    "selection": "#2c2b2a",
    "foreground": "#645c54",
    "foreground-alt": "#746c63",
    "foreground-attention": "#6c645c",
    "comment": "#64584e",
    "cyan": "#527a57",
    "green": "#757845",
    "orange": "#c47d54",
    "pink": "#bb755e",
    "purple": "#635d71",
    "red": "#ca4f4f",
    "yellow": "#af9e6b",
}

# Every key below exists in qutebrowser's own configdata.yml — checked against
# it rather than remembered. The file used to stop at the palette above, which
# meant sourcing it coloured nothing at all: a dictionary named `palette` that
# no line ever read.

c.colors.completion.fg = palette["foreground"]
c.colors.completion.odd.bg = palette["background-alt"]
c.colors.completion.even.bg = palette["background"]
c.colors.completion.category.fg = palette["yellow"]
c.colors.completion.category.bg = palette["background"]
c.colors.completion.category.border.top = palette["background"]
c.colors.completion.category.border.bottom = palette["background"]
c.colors.completion.item.selected.fg = palette["foreground"]
c.colors.completion.item.selected.bg = palette["selection"]
c.colors.completion.item.selected.border.top = palette["selection"]
c.colors.completion.item.selected.border.bottom = palette["selection"]
c.colors.completion.item.selected.match.fg = palette["green"]
c.colors.completion.match.fg = palette["orange"]
c.colors.completion.scrollbar.fg = palette["foreground"]
c.colors.completion.scrollbar.bg = palette["background"]

c.colors.contextmenu.disabled.bg = palette["background-alt"]
c.colors.contextmenu.disabled.fg = palette["comment"]
c.colors.contextmenu.menu.bg = palette["background"]
c.colors.contextmenu.menu.fg = palette["foreground"]
c.colors.contextmenu.selected.bg = palette["selection"]
c.colors.contextmenu.selected.fg = palette["foreground"]

c.colors.downloads.bar.bg = palette["background"]
c.colors.downloads.start.fg = palette["background"]
c.colors.downloads.start.bg = palette["cyan"]
c.colors.downloads.stop.fg = palette["background"]
c.colors.downloads.stop.bg = palette["green"]
c.colors.downloads.error.fg = palette["background"]
c.colors.downloads.error.bg = palette["red"]

c.colors.hints.fg = palette["background"]
c.colors.hints.bg = palette["yellow"]
c.colors.hints.match.fg = palette["comment"]

c.colors.keyhint.fg = palette["purple"]
c.colors.keyhint.suffix.fg = palette["foreground"]
c.colors.keyhint.bg = palette["background"]

c.colors.messages.error.fg = palette["background"]
c.colors.messages.error.bg = palette["red"]
c.colors.messages.error.border = palette["red"]
c.colors.messages.warning.fg = palette["background"]
c.colors.messages.warning.bg = palette["orange"]
c.colors.messages.warning.border = palette["orange"]
c.colors.messages.info.fg = palette["foreground"]
c.colors.messages.info.bg = palette["background"]
c.colors.messages.info.border = palette["background"]

c.colors.prompts.fg = palette["foreground"]
c.colors.prompts.border = palette["background"]
c.colors.prompts.bg = palette["background-alt"]
c.colors.prompts.selected.fg = palette["foreground"]
c.colors.prompts.selected.bg = palette["selection"]

c.colors.statusbar.normal.fg = palette["foreground"]
c.colors.statusbar.normal.bg = palette["background"]
c.colors.statusbar.insert.fg = palette["background"]
c.colors.statusbar.insert.bg = palette["green"]
c.colors.statusbar.passthrough.fg = palette["background"]
c.colors.statusbar.passthrough.bg = palette["cyan"]
c.colors.statusbar.private.fg = palette["foreground"]
c.colors.statusbar.private.bg = palette["background-attention"]
c.colors.statusbar.command.fg = palette["foreground"]
c.colors.statusbar.command.bg = palette["background"]
c.colors.statusbar.command.private.fg = palette["foreground"]
c.colors.statusbar.command.private.bg = palette["background-attention"]
c.colors.statusbar.caret.fg = palette["background"]
c.colors.statusbar.caret.bg = palette["purple"]
c.colors.statusbar.caret.selection.fg = palette["background"]
c.colors.statusbar.caret.selection.bg = palette["pink"]
c.colors.statusbar.progress.bg = palette["cyan"]
c.colors.statusbar.url.fg = palette["foreground"]
c.colors.statusbar.url.error.fg = palette["red"]
c.colors.statusbar.url.hover.fg = palette["cyan"]
c.colors.statusbar.url.success.http.fg = palette["yellow"]
c.colors.statusbar.url.success.https.fg = palette["green"]
c.colors.statusbar.url.warn.fg = palette["orange"]

c.colors.tabs.bar.bg = palette["background"]
c.colors.tabs.indicator.start = palette["cyan"]
c.colors.tabs.indicator.stop = palette["green"]
c.colors.tabs.indicator.error = palette["red"]
c.colors.tabs.odd.fg = palette["foreground"]
c.colors.tabs.odd.bg = palette["background-alt"]
c.colors.tabs.even.fg = palette["foreground"]
c.colors.tabs.even.bg = palette["background"]
c.colors.tabs.selected.odd.fg = palette["foreground"]
c.colors.tabs.selected.odd.bg = palette["selection"]
c.colors.tabs.selected.even.fg = palette["foreground"]
c.colors.tabs.selected.even.bg = palette["selection"]
c.colors.tabs.pinned.odd.fg = palette["foreground"]
c.colors.tabs.pinned.odd.bg = palette["background-alt"]
c.colors.tabs.pinned.even.fg = palette["foreground"]
c.colors.tabs.pinned.even.bg = palette["background"]
c.colors.tabs.pinned.selected.odd.fg = palette["foreground"]
c.colors.tabs.pinned.selected.odd.bg = palette["selection"]
c.colors.tabs.pinned.selected.even.fg = palette["foreground"]
c.colors.tabs.pinned.selected.even.bg = palette["selection"]

c.colors.tooltip.bg = palette["background-alt"]
c.colors.tooltip.fg = palette["foreground"]

c.colors.webpage.bg = palette["background"]
