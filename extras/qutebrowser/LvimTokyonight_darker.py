palette = {
    "background": "#181b22",
    "background-alt": "#1a1d24",
    "background-attention": "#14171e",
    "border": "#161920",
    "current-line": "#1a1d24",
    "selection": "#1c1f26",
    "foreground": "#b2b6c7",
    "foreground-alt": "#b5b9ca",
    "foreground-attention": "#a8adc0",
    "comment": "#616784",
    "cyan": "#648299",
    "green": "#788a67",
    "orange": "#bb866d",
    "pink": "#907bba",
    "purple": "#73638e",
    "red": "#bb6171",
    "yellow": "#b79d7b",
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
# "none" is not a colour: it tells qutebrowser to take the system colour
# system rather than interpret the value as one.
c.colors.downloads.system.bg = "none"
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
c.colors.tabs.indicator.system = "none"
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
