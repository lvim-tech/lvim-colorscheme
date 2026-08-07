-- lvim-colorscheme.extra.bru: generate a Bru theme (CSS custom properties) from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.bru"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors, _, _)
    -- Bru's chrome is an HTML page, so its theme is a stylesheet: one `:root`
    -- block of custom properties that chrome.css reads and never a hex value of
    -- its own. Two sections, and the split matters.
    --
    -- The first is the palette, verbatim under the lvim-colorscheme key names.
    -- The second is the vocabulary, and it is not invented here: it is
    -- qutebrowser's own `c.colors.*` tree with the dots turned into dashes, the
    -- same 96 names extra/desktop/qutebrowser.lua assigns, mapped to the same
    -- palette colours. Bru copies qutebrowser's behaviour 1:1, so a theme that
    -- names its colours differently would make every comparison a translation.
    --
    -- The vocabulary refers to the palette through var() rather than repeating
    -- the hex. Overriding one palette line by hand then re-colours everything
    -- derived from it, which is the only edit a person is likely to want.
    local bru = util.template(
        [[
/* ${_style_name} — GENERATED for bru. Loaded as bru://chrome/theme.css. */

:root {
    /* Palette — the lvim-colorscheme keys, unchanged. */
    --bg-light: ${bg_light};
    --bg-soft-light: ${bg_soft_light};
    --bg: ${bg};
    --bg-soft-dark: ${bg_soft_dark};
    --bg-dark: ${bg_dark};
    --bg-highlight: ${bg_highlight};

    /* The palette's own foreground is made for reading code in an editor for
       hours; against a chrome strip it measures around 2.3:1, and a reader
       needs 4.5:1. `ensure_contrast` walks LIGHTNESS up in hsluv until it
       clears that floor and stops there, so the hue and saturation the palette
       chose survive — the same call, and the same 4.5, that extra/desktop/rofi.lua
       makes for exactly this reason. Every interface text colour below points
       here rather than at --fg; --fg itself stays verbatim, because a page or a
       hand-written override still wants the palette's own answer. */
    --ui-fg: ${bru_ui_fg};
    --ui-fg-dim: ${bru_ui_fg_dim};

    --fg-light: ${fg_light};
    --fg-soft-light: ${fg_soft_light};
    --fg: ${fg};
    --fg-soft-dark: ${fg_soft_dark};
    --fg-dark: ${fg_dark};

    --comment: ${comment};

    --blue: ${blue};
    --cyan: ${cyan};
    --green: ${green};
    --magenta: ${magenta};
    --orange: ${orange};
    --purple: ${purple};
    --red: ${red};
    --teal: ${teal};
    --yellow: ${yellow};

    /* c.colors.completion.* */
    --completion-fg: var(--ui-fg);
    --completion-odd-bg: var(--bg-soft-light);
    --completion-even-bg: var(--bg);
    --completion-category-fg: var(--yellow);
    --completion-category-bg: var(--bg);
    --completion-category-border-top: var(--bg);
    --completion-category-border-bottom: var(--bg);
    --completion-item-selected-fg: var(--ui-fg);
    --completion-item-selected-bg: var(--bg-light);
    --completion-item-selected-border-top: var(--bg-light);
    --completion-item-selected-border-bottom: var(--bg-light);
    --completion-item-selected-match-fg: var(--green);
    --completion-match-fg: var(--orange);
    --completion-scrollbar-fg: var(--ui-fg);
    --completion-scrollbar-bg: var(--bg);

    /* c.colors.contextmenu.* */
    --contextmenu-disabled-bg: var(--bg-soft-light);
    --contextmenu-disabled-fg: var(--comment);
    --contextmenu-menu-bg: var(--bg);
    --contextmenu-menu-fg: var(--ui-fg);
    --contextmenu-selected-bg: var(--bg-light);
    --contextmenu-selected-fg: var(--ui-fg);

    /* c.colors.downloads.* */
    --downloads-bar-bg: var(--bg);
    --downloads-start-fg: var(--bg);
    --downloads-start-bg: var(--cyan);
    --downloads-stop-fg: var(--bg);
    --downloads-stop-bg: var(--green);
    /* qutebrowser's "none" means "take the system colour"; in CSS the honest
       equivalent is to paint nothing and let what is behind show through. */
    --downloads-system-bg: transparent;
    --downloads-error-fg: var(--bg);
    --downloads-error-bg: var(--red);

    /* c.colors.hints.* */
    --hints-fg: var(--bg);
    --hints-bg: var(--yellow);
    --hints-match-fg: var(--comment);

    /* c.colors.keyhint.* */
    --keyhint-fg: var(--purple);
    --keyhint-suffix-fg: var(--ui-fg);
    --keyhint-bg: var(--bg);

    /* c.colors.messages.* */
    --messages-error-fg: var(--bg);
    --messages-error-bg: var(--red);
    --messages-error-border: var(--red);
    --messages-warning-fg: var(--bg);
    --messages-warning-bg: var(--orange);
    --messages-warning-border: var(--orange);
    --messages-info-fg: var(--ui-fg);
    --messages-info-bg: var(--bg);
    --messages-info-border: var(--bg);

    /* c.colors.prompts.* */
    --prompts-fg: var(--ui-fg);
    --prompts-border: var(--bg);
    --prompts-bg: var(--bg-soft-light);
    --prompts-selected-fg: var(--ui-fg);
    --prompts-selected-bg: var(--bg-light);

    /* c.colors.statusbar.* */
    --statusbar-normal-fg: var(--ui-fg);
    --statusbar-normal-bg: var(--bg);
    --statusbar-insert-fg: var(--bg);
    --statusbar-insert-bg: var(--green);
    --statusbar-passthrough-fg: var(--bg);
    --statusbar-passthrough-bg: var(--cyan);
    --statusbar-private-fg: var(--ui-fg);
    --statusbar-private-bg: var(--bg-dark);
    --statusbar-command-fg: var(--ui-fg);
    --statusbar-command-bg: var(--bg);
    --statusbar-command-private-fg: var(--ui-fg);
    --statusbar-command-private-bg: var(--bg-dark);
    --statusbar-caret-fg: var(--bg);
    --statusbar-caret-bg: var(--purple);
    --statusbar-caret-selection-fg: var(--bg);
    --statusbar-caret-selection-bg: var(--magenta);
    /* bru's own modes, which qutebrowser has no colours for: it names only the
       modes above and says the rest with nothing. bru draws a mode indicator at
       the front of its bar and every mode it can be in needs a background, or
       the ones without one are indistinguishable from normal. Each is the
       palette colour whose job already matches: hint and its two register modes
       are asking for a key, macros are recording or replaying. */
    --statusbar-hint-fg: var(--bg);
    --statusbar-hint-bg: var(--yellow);
    --statusbar-set-mark-fg: var(--bg);
    --statusbar-set-mark-bg: var(--orange);
    --statusbar-jump-mark-fg: var(--bg);
    --statusbar-jump-mark-bg: var(--orange);
    --statusbar-record-macro-fg: var(--bg);
    --statusbar-record-macro-bg: var(--red);
    --statusbar-run-macro-fg: var(--bg);
    --statusbar-run-macro-bg: var(--blue);
    --statusbar-progress-bg: var(--cyan);
    --statusbar-url-fg: var(--ui-fg);
    --statusbar-url-error-fg: var(--red);
    --statusbar-url-hover-fg: var(--cyan);
    --statusbar-url-success-http-fg: var(--yellow);
    --statusbar-url-success-https-fg: var(--green);
    --statusbar-url-warn-fg: var(--orange);

    /* c.colors.tabs.* */
    --tabs-bar-bg: var(--bg);
    --tabs-indicator-start: var(--cyan);
    --tabs-indicator-stop: var(--green);
    --tabs-indicator-error: var(--red);
    --tabs-indicator-system: transparent;
    --tabs-odd-fg: var(--ui-fg);
    --tabs-odd-bg: var(--bg-soft-light);
    --tabs-even-fg: var(--ui-fg);
    --tabs-even-bg: var(--bg);
    --tabs-selected-odd-fg: var(--ui-fg);
    --tabs-selected-odd-bg: var(--bg-light);
    --tabs-selected-even-fg: var(--ui-fg);
    --tabs-selected-even-bg: var(--bg-light);
    --tabs-pinned-odd-fg: var(--ui-fg);
    --tabs-pinned-odd-bg: var(--bg-soft-light);
    --tabs-pinned-even-fg: var(--ui-fg);
    --tabs-pinned-even-bg: var(--bg);
    --tabs-pinned-selected-odd-fg: var(--ui-fg);
    --tabs-pinned-selected-odd-bg: var(--bg-light);
    --tabs-pinned-selected-even-fg: var(--ui-fg);
    --tabs-pinned-selected-even-bg: var(--bg-light);

    /* c.colors.tooltip.* */
    --tooltip-bg: var(--bg-soft-light);
    --tooltip-fg: var(--ui-fg);

    /* c.colors.webpage.bg */
    --webpage-bg: var(--bg);

    /* Bru's own, where a page needs a colour a Qt widget got for free. */
    --tabs-bar-border: var(--bg-soft-dark);
    --statusbar-border: var(--bg-soft-dark);
    --completion-border: var(--bg-soft-dark);
    --statusbar-keystring-fg: var(--purple);
    --statusbar-percentage-fg: var(--ui-fg-dim);
    --statusbar-tabindex-fg: var(--ui-fg-dim);
}
]],
        vim.tbl_extend("force", colors, {
            -- Floored against --bg, which is what the tab strip, the status bar and the
            -- completion rows are all painted on.
            bru_ui_fg = util.ensure_contrast(colors.fg, colors.bg, 4.5),
            -- The quieter tier — a scroll percentage, a tab index — floored at 3:1 so it stays
            -- legible while still reading as secondary. `ensure_contrast` is a floor and cannot
            -- bring a bright colour down, so this starts from the palette's dimmest foreground
            -- rather than from --fg.
            bru_ui_fg_dim = util.ensure_contrast(colors.comment, colors.bg, 3.0),
        })
    )
    return bru
end

return M
