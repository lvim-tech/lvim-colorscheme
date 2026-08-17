-- lvim-colorscheme.extra.firefox: generate a Firefox static theme (a
-- WebExtension manifest.json) from the lvim-colorscheme palette.
--
-- Firefox does not read a colour file the way kitty or zed do; a browser theme
-- is an add-on whose whole content is a manifest.json under a `theme` key, so
-- one of these IS the installable theme. `scripts/build-firefox-xpi.sh` zips
-- each into an .xpi; on release Firefox the .xpi must then be signed through
-- addons.mozilla.org before it installs permanently.
--
-- Only the CHROME is dressed here — the toolbar, tabs, address bar, menus and
-- sidebar. Web content stays with `color_scheme`, which Firefox already answers
-- from xdg-desktop-portal; it is set again in `properties` so the theme is
-- self-consistent when the portal is absent.
--
-- Text is floored against the surface it actually sits on (WCAG AA 4.5:1 for
-- body, 3:1 for the dimmer inactive-tab label): a palette's foreground is tuned
-- for the editor's background, not for a toolbar a shade lighter, and the two
-- Firefox stacks vertically — toolbar over the darker address bar — so each
-- needs its own answer rather than one colour reused.

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
--- @return string
function M.generate(colors)
    local scheme = tostring(colors._style):match("_light$") and "light" or "dark"

    local t = {
        name   = colors._style_name,
        id     = (tostring(colors._name):gsub("_", "-")) .. "@lvim-tech",
        scheme = scheme,

        -- Surfaces, darkest to lightest: the window frame, the toolbar, the
        -- address bar (a step down from the toolbar, like the editor's float),
        -- the selected tab, and a hover wash.
        frame        = colors.bg_dark,
        frame_i      = colors.bg_soft_dark,
        toolbar      = colors.bg,
        field        = colors.bg_dark,
        field_focus  = colors.bg_soft_dark,
        popup        = colors.bg_dark,
        selected     = colors.bg_light,
        hover        = colors.bg_soft_light,
        border       = colors.bg_soft_dark,
        ntp          = colors.bg,
        sidebar      = colors.bg_dark,

        -- Text, floored on its own surface.
        toolbar_text = util.ensure_contrast(colors.fg_light, colors.bg, 4.5),
        field_text   = util.ensure_contrast(colors.fg_light, colors.bg_dark, 4.5),
        inactive_tab = util.ensure_contrast(colors.comment, colors.bg_dark, 3.0),

        -- Accents: the selected-tab line and focus ring, and the attention dot.
        accent       = colors.blue,
        attention    = colors.green,
    }

    return util.template(
        [[{
  "manifest_version": 2,
  "name": "${name}",
  "version": "1.0.0",
  "author": "lvim-tech",
  "browser_specific_settings": { "gecko": { "id": "${id}" } },
  "theme": {
    "colors": {
      "frame": "${frame}",
      "frame_inactive": "${frame_i}",
      "tab_background_text": "${inactive_tab}",
      "tab_selected": "${selected}",
      "tab_text": "${toolbar_text}",
      "tab_background_separator": "${border}",
      "tab_line": "${accent}",
      "tab_loading": "${accent}",
      "toolbar": "${toolbar}",
      "toolbar_text": "${toolbar_text}",
      "bookmark_text": "${toolbar_text}",
      "toolbar_field": "${field}",
      "toolbar_field_text": "${field_text}",
      "toolbar_field_border": "${border}",
      "toolbar_field_focus": "${field_focus}",
      "toolbar_field_text_focus": "${toolbar_text}",
      "toolbar_field_border_focus": "${accent}",
      "toolbar_field_highlight": "${accent}",
      "toolbar_top_separator": "${frame}",
      "toolbar_bottom_separator": "${border}",
      "toolbar_vertical_separator": "${border}",
      "button_background_hover": "${hover}",
      "button_background_active": "${selected}",
      "popup": "${popup}",
      "popup_text": "${toolbar_text}",
      "popup_border": "${border}",
      "popup_highlight": "${selected}",
      "popup_highlight_text": "${toolbar_text}",
      "ntp_background": "${ntp}",
      "ntp_text": "${toolbar_text}",
      "sidebar": "${sidebar}",
      "sidebar_text": "${toolbar_text}",
      "sidebar_border": "${border}",
      "sidebar_highlight": "${accent}",
      "sidebar_highlight_text": "${frame}",
      "icons": "${toolbar_text}",
      "icons_attention": "${attention}"
    },
    "properties": {
      "color_scheme": "${scheme}",
      "content_color_scheme": "${scheme}"
    }
  }
}
]],
        t
    )
end

return M
