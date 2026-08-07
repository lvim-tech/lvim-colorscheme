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
    -- k9s paints its text on three surfaces and only three: `bg_dark` (the body, the table, the
    -- logs), `bg` (the prompt, a dialog, the title bar) and `bg_highlight` (a button, the cursor
    -- row, an inactive crumb). They sit within a few points of luminance of each other, so one
    -- floor against whichever is NEAREST clears all three — which is what `util.hardest` picks,
    -- and picking it rather than naming one is the difference between 4.5:1 and the 4.47:1 that
    -- naming one gave elsewhere in this repo.
    --
    -- Measured across the 48 styles before this existed, 1056 of k9s's 1584 text pairs were under
    -- WCAG AA's 4.5:1.
    --
    -- Anything whose name starts with `bg` is a SURFACE and never moves: flooring a background
    -- would move the very thing the text is being measured against.
    local surfaces = { colors.bg_dark, colors.bg, colors.bg_highlight }
    local function ui(hex)
        return util.ensure_contrast(hex, util.hardest(hex, unpack(surfaces)), 4.5)
    end

    -- Two colours are drawn as text ON a surface that is itself a background key, so neither the
    -- `hardest` walk above nor the palette helps: `bg_dark` written on `bg_highlight` measured
    -- **1.05:1** on rosepine_darker, for the breadcrumb trail and for the row under the cursor —
    -- text the same colour as the box it is in.
    --
    -- The breadcrumb has a second surface: k9s paints the CURRENT crumb with `activeColor` and
    -- writes the same `fgColor` on it. **That reading of `activeColor` is an assumption** — it is
    -- how k9s's skin schema documents it, but no k9s was run here to confirm it — so the pair is
    -- declared and floored both ways round: the text clears the inactive crumb, and then the
    -- active accent gives a step of hsluv lightness to clear the text. If the assumption is wrong
    -- and `activeColor` is a foreground, it is a floored accent on the body background, which is
    -- what every other accent in this file already is.
    local crumb_fg = util.ensure_contrast_either_way(colors.bg_dark, colors.bg_highlight, 4.5)
    local crumb_active = util.ensure_contrast_either_way(colors.blue, crumb_fg, 4.5)
    local cursor_fg = util.ensure_contrast_either_way(colors.bg_dark, colors.bg_highlight, 4.5)

    -- The focused dialog button is an accent used as a surface: the blue must stay blue, so the
    -- text is chosen from the two the theme has and the accent gives a step where that is still
    -- not enough — the pattern `extra/desktop/qutebrowser.lua` uses for its message strips.
    local button_fg = util.readable_on(colors.blue, colors.bg_dark)
    local button_bg = util.ensure_contrast(colors.blue, button_fg, 4.5)

    local t = setmetatable({
        -- Deliberately NOT floored, one line of reason each:
        -- the logo is a picture drawn in ASCII, not words — `extra/system/fastfetch.lua` leaves
        -- its logo for the same reason;
        k9s_logo = colors.purple,
        -- the suggestion after `:` is ghost text, which has to stay tellable apart from what has
        -- actually been typed;
        k9s_suggest = colors.comment,
        -- and the focus ring is a border, which is a line and not a word.
        k9s_border_focus = colors.blue,
        -- Chart and dial colours: nothing is read against them, exactly as `btop`'s meter
        -- gradients and `bottom`'s graphs were left.
        k9s_chart_green = colors.green,
        k9s_chart_red = colors.red,

        k9s_crumb_fg = crumb_fg,
        k9s_crumb_active = crumb_active,
        k9s_cursor_fg = cursor_fg,
        k9s_button_fg = button_fg,
        k9s_button_bg = button_bg,
    }, {
        __index = function(_, k)
            local v = colors[k]
            if type(v) == "string" and v:match("^#%x%x%x%x%x%x$") and not k:match("^bg") then
                return ui(v)
            end
            return v
        end,
    })

    return util.template(
        [[
# ${_style_name}
k9s:
  body:
    fgColor: "${fg}"
    bgColor: "${bg_dark}"
    logoColor: "${k9s_logo}"
  prompt:
    fgColor: "${fg_light}"
    bgColor: "${bg}"
    suggestColor: "${k9s_suggest}"
  info:
    fgColor: "${comment}"
    sectionColor: "${fg}"
  dialog:
    fgColor: "${fg}"
    bgColor: "${bg}"
    buttonFgColor: "${fg_light}"
    buttonBgColor: "${bg_highlight}"
    buttonFocusFgColor: "${k9s_button_fg}"
    buttonFocusBgColor: "${k9s_button_bg}"
    labelFgColor: "${orange}"
    fieldFgColor: "${fg}"
  frame:
    border:
      fgColor: "${bg_light}"
      focusColor: "${k9s_border_focus}"
    menu:
      fgColor: "${fg}"
      keyColor: "${magenta}"
      numKeyColor: "${orange}"
    crumbs:
      fgColor: "${k9s_crumb_fg}"
      bgColor: "${bg_highlight}"
      activeColor: "${k9s_crumb_active}"
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
        - "${k9s_chart_green}"
        - "${k9s_chart_red}"
      defaultChartColors:
        - "${k9s_chart_green}"
        - "${k9s_chart_red}"
    table:
      fgColor: "${fg}"
      bgColor: "${bg_dark}"
      cursorFgColor: "${k9s_cursor_fg}"
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
        t
    )
end

return M
