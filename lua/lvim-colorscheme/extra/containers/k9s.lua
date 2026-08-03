-- lvim-colorscheme.extra.k9s: generate a k9s skin from the palette.
--
--     mkdir -p ~/.config/k9s/skins
--     ln -sf .../extras/k9s/LvimNord_dark.yaml ~/.config/k9s/skins/
--     # then: k9s.ui.skin: LvimNord_dark   (or K9S_SKIN=LvimNord_dark)
--
-- The skin is selected BY FILE NAME without the extension, which is why the
-- generated names double as the value of `ui.skin`.
--
---@module "lvim-colorscheme.extra.containers.k9s"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
# ${_style_name}
k9s:
  body:
    fgColor: "${fg}"
    bgColor: "${bg_dark}"
    logoColor: "${purple}"
  prompt:
    fgColor: "${fg_light}"
    bgColor: "${bg}"
    suggestColor: "${comment}"
  info:
    fgColor: "${comment}"
    sectionColor: "${fg}"
  dialog:
    fgColor: "${fg}"
    bgColor: "${bg}"
    buttonFgColor: "${fg_light}"
    buttonBgColor: "${bg_highlight}"
    buttonFocusFgColor: "${bg_dark}"
    buttonFocusBgColor: "${blue}"
    labelFgColor: "${orange}"
    fieldFgColor: "${fg}"
  frame:
    border:
      fgColor: "${bg_light}"
      focusColor: "${blue}"
    menu:
      fgColor: "${fg}"
      keyColor: "${magenta}"
      numKeyColor: "${orange}"
    crumbs:
      fgColor: "${bg_dark}"
      bgColor: "${bg_highlight}"
      activeColor: "${blue}"
    status:
      newColor: "${teal}"
      modifyColor: "${blue}"
      addColor: "${green}"
      errorColor: "${red}"
      highlightColor: "${orange}"
      killColor: "${comment}"
      completedColor: "${comment}"
    title:
      fgColor: "${fg}"
      bgColor: "${bg}"
      highlightColor: "${orange}"
      counterColor: "${purple}"
      filterColor: "${magenta}"
  views:
    charts:
      bgColor: "${bg_dark}"
      defaultDialColors:
        - "${green}"
        - "${red}"
      defaultChartColors:
        - "${green}"
        - "${red}"
    table:
      fgColor: "${fg}"
      bgColor: "${bg_dark}"
      cursorFgColor: "${bg_dark}"
      cursorBgColor: "${bg_highlight}"
      header:
        fgColor: "${fg_light}"
        bgColor: "${bg_dark}"
        sorterColor: "${cyan}"
    yaml:
      keyColor: "${blue}"
      colonColor: "${comment}"
      valueColor: "${fg}"
    logs:
      fgColor: "${fg}"
      bgColor: "${bg_dark}"
      indicator:
        fgColor: "${purple}"
        bgColor: "${bg_dark}"
]],
        colors
    )
end

return M
