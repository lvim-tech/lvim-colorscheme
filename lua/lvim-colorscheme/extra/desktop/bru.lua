-- lvim-colorscheme.extra.bru: generate a Bru theme (CSS custom properties) from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.bru"

local util = require("lvim-colorscheme.util")

local M = {}

--- The readable text colour for one accent *background*, of the two the theme actually has.
---
--- `ensure_contrast` is the wrong tool here and the reason is which colour is free to move. On a
--- message strip the background is the palette's accent and must not move — an error strip that is
--- no longer red has stopped being an error strip — so the *text* is what is chosen, and it has
--- only two candidates: the theme's own background, or white. Whichever of the two reads better on
--- that accent wins, which is `bru_pill_fg`'s rule applied per accent instead of once for all ten
--- mode pills.
---
--- Local to this target rather than added to `util`, because ten other desktop targets read that
--- file and none of them asked for this.
---@param accent string  the background, which does not move
---@param dark string  the theme's own background, the dark candidate
---@return string
local function readable_on(accent, dark)
    if util.contrast("#ffffff", accent) > util.contrast(dark, accent) then
        return "#ffffff"
    end
    return dark
end

--- The surface a text colour has the hardest time on, of the three bru paints text over.
---
--- `--bg` is the strip and the page, `--bg-soft-light` is an odd tab row, `--bg-light` is the
--- selected row. On a dark palette the last is the lightest and clearing it clears the others; on a
--- light palette that is exactly backwards. Nearest in luminance is the honest test either way, and
--- a colour floored against it clears all three.
---@param colors ColorScheme
---@param text string
---@return string
local function hardest(colors, text)
    local lum = util.luminance(text)
    local worst, gap = colors.bg, math.huge
    for _, surface in ipairs({ colors.bg, colors.bg_soft_light, colors.bg_light }) do
        local d = math.abs(util.luminance(surface) - lum)
        if d < gap then
            gap, worst = d, surface
        end
    end
    return worst
end

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
    /* The text on a mode pill: whichever of the theme's own dark and a plain
       white reads better on the pills themselves. `lvim-hud`'s `pill_on`
       (chrome/init.lua:73) makes exactly this choice for the statusline, and
       the two must not disagree — they are the same word on the same screen. */
    --pill-fg: ${bru_pill_fg};
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
    --completion-category-fg: ${bru_text_yellow};
    --completion-category-bg: var(--bg);
    --completion-category-border-top: var(--bg);
    --completion-category-border-bottom: var(--bg);
    --completion-item-selected-fg: ${bru_sel_fg};
    --completion-item-selected-bg: var(--bg-light);
    --completion-item-selected-border-top: var(--bg-light);
    --completion-item-selected-border-bottom: var(--bg-light);
    --completion-item-selected-match-fg: ${bru_sel_green};
    --completion-match-fg: ${bru_text_orange};
    --completion-scrollbar-fg: var(--ui-fg);
    --completion-scrollbar-bg: var(--bg);

    /* c.colors.contextmenu.* */
    --contextmenu-disabled-bg: var(--bg-soft-light);
    --contextmenu-disabled-fg: var(--comment);
    --contextmenu-menu-bg: var(--bg);
    --contextmenu-menu-fg: var(--ui-fg);
    --contextmenu-selected-bg: var(--bg-light);
    --contextmenu-selected-fg: ${bru_sel_fg};

    /* c.colors.downloads.* */
    --downloads-bar-bg: var(--bg);
    --downloads-start-fg: ${bru_on_cyan};
    --downloads-start-bg: ${bru_strip_cyan};
    --downloads-stop-fg: ${bru_on_green};
    --downloads-stop-bg: ${bru_strip_green};
    /* qutebrowser's "none" means "take the system colour"; in CSS the honest
       equivalent is to paint nothing and let what is behind show through. */
    --downloads-system-bg: transparent;
    --downloads-error-fg: ${bru_on_red};
    --downloads-error-bg: ${bru_strip_red};

    /* c.colors.hints.* */
    --hints-fg: ${bru_on_yellow};
    --hints-bg: ${bru_strip_yellow};
    --hints-match-fg: var(--comment);

    /* c.colors.keyhint.* */
    --keyhint-fg: ${bru_text_purple};
    --keyhint-suffix-fg: var(--ui-fg);
    --keyhint-bg: var(--bg);

    /* c.colors.messages.* */
    --messages-error-fg: ${bru_on_red};
    --messages-error-bg: ${bru_strip_red};
    --messages-error-border: ${bru_strip_red};
    --messages-warning-fg: ${bru_on_orange};
    --messages-warning-bg: ${bru_strip_orange};
    --messages-warning-border: ${bru_strip_orange};
    --messages-info-fg: var(--ui-fg);
    --messages-info-bg: var(--bg);
    --messages-info-border: var(--bg);

    /* c.colors.prompts.* */
    --prompts-fg: ${bru_sel_fg};
    --prompts-border: var(--bg);
    --prompts-bg: var(--bg-soft-light);
    --prompts-selected-fg: ${bru_sel_fg};
    --prompts-selected-bg: var(--bg-light);

    /* c.colors.statusbar.* */
    /* The bar itself. Its own pair, because the mode pairs below are the
       *pill's* and normal's is no longer the bar's: aligning the pills with the
       statusline made `--statusbar-normal-bg` green, and anything still drawing
       the bar with it turned the whole strip green. A variable that two things
       read is a variable one of them will one day repaint by accident. */
    --statusbar-bg: var(--bg);
    --statusbar-fg: var(--ui-fg);

    /* The status bar's own widgets, with the meanings they have always had:
       `command` is the command *line*, `insert`/`caret`/`passthrough` are what
       qutebrowser recolours the whole bar with. bru no longer recolours the bar
       — that is `--statusbar-bg` above — but these keep their names and their
       jobs, because two of them are read by real inputs and a variable that
       changes meaning repaints something nobody was looking at. It has happened
       twice here: once the whole strip went green, once the command line did. */
    --statusbar-normal-fg: var(--ui-fg);
    --statusbar-normal-bg: var(--bg);
    --statusbar-command-fg: var(--ui-fg);
    --statusbar-command-bg: var(--bg);
    --statusbar-command-private-fg: var(--ui-fg);
    --statusbar-command-private-bg: var(--bg-dark);
    --statusbar-private-fg: var(--ui-fg);
    --statusbar-private-bg: var(--bg-dark);
    --statusbar-insert-fg: var(--bg);
    --statusbar-insert-bg: var(--green);
    --statusbar-passthrough-fg: var(--bg);
    --statusbar-passthrough-bg: var(--cyan);
    --statusbar-caret-fg: var(--bg);
    --statusbar-caret-bg: var(--purple);
    --statusbar-caret-selection-fg: var(--bg);
    --statusbar-caret-selection-bg: var(--magenta);

    /* **The mode pills, and nothing else reads these.** Their own namespace
       because the first attempt spent `--statusbar-normal-bg` and
       `--statusbar-command-bg` on them, and both were already the background of
       something — the whole bar, and the command line.

       The colours are this user's neovim statusline, `lvim-hud`'s
       `chrome/init.lua:98-103`: normal green, insert red, visual orange,
       command purple, replace cyan, terminal blue. bru's bar sits under the
       same eyes on the same screen, so the modes they share are the same
       colour. Passthrough takes the terminal blue because that is what it is —
       the keys stop being the browser's. The five modes neovim has no
       counterpart for take what is left. */
    --mode-fg: var(--pill-fg);
    --mode-normal-bg: var(--green);
    --mode-insert-bg: var(--red);
    --mode-caret-bg: var(--orange);
    --mode-command-bg: var(--purple);
    --mode-passthrough-bg: var(--blue);
    --mode-hint-bg: var(--yellow);
    --mode-set-mark-bg: var(--cyan);
    --mode-jump-mark-bg: var(--cyan);
    --mode-record-macro-bg: var(--magenta);
    --mode-run-macro-bg: var(--teal);
    /* The two prompt modes — bru is asking and the browser is waiting.
       Every one of the palette's nine hues was already spent by the ten modes
       above, and a tenth *palette* key cannot be added here: not every colours/
       file defines the `*_dark` siblings, so a theme picked at random would get
       an empty variable and an unpainted pill. So this one is derived, from the
       colour whose job is closest — command purple, because a prompt is the
       other half of "the bar is talking to you" — brightened until it is
       plainly a different pill beside it rather than a shade of it.
       Both modes share it, exactly as set_mark and jump_mark share cyan: they
       are one situation with two shapes, and the word in the pill says which. */
    --mode-prompt-bg: ${bru_prompt_pill};
    --mode-yesno-bg: ${bru_prompt_pill};
    --statusbar-progress-bg: var(--cyan);
    --statusbar-url-fg: var(--ui-fg);
    --statusbar-url-error-fg: ${bru_text_red};
    --statusbar-url-hover-fg: ${bru_text_cyan};
    --statusbar-url-success-http-fg: ${bru_text_yellow};
    --statusbar-url-success-https-fg: ${bru_text_green};
    --statusbar-url-warn-fg: ${bru_text_orange};

    /* c.colors.tabs.* */
    --tabs-bar-bg: var(--bg);
    --tabs-indicator-start: var(--cyan);
    --tabs-indicator-stop: var(--green);
    --tabs-indicator-error: var(--red);
    --tabs-indicator-system: transparent;
    --tabs-odd-fg: ${bru_sel_fg};
    --tabs-odd-bg: var(--bg-soft-light);
    --tabs-even-fg: var(--ui-fg);
    --tabs-even-bg: var(--bg);
    --tabs-selected-odd-fg: ${bru_sel_fg};
    --tabs-selected-odd-bg: var(--bg-light);
    --tabs-selected-even-fg: var(--ui-fg);
    --tabs-selected-even-bg: var(--bg-light);
    --tabs-pinned-odd-fg: ${bru_sel_fg};
    --tabs-pinned-odd-bg: var(--bg-soft-light);
    --tabs-pinned-even-fg: var(--ui-fg);
    --tabs-pinned-even-bg: var(--bg);
    --tabs-pinned-selected-odd-fg: ${bru_sel_fg};
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
    --statusbar-keystring-fg: ${bru_text_purple};
    --statusbar-percentage-fg: var(--ui-fg-dim);
    --statusbar-tabindex-fg: var(--ui-fg-dim);
}
]],
        vim.tbl_extend("force", colors, {
            -- Floored against --bg, which is what the tab strip, the status bar and the
            -- completion rows are all painted on.
            bru_ui_fg = util.ensure_contrast(colors.fg, colors.bg, 4.5),
            -- The pill text, decided once against the *brightest* pill: whatever reads on the
            -- lightest background reads on the darker ones too, so one value serves all ten
            -- modes and the CSS needs no rule per mode for the foreground.
            bru_pill_fg = (function()
                local brightest, best = colors.bg, -1
                for _, pill in ipairs({
                    colors.green, colors.red, colors.orange, colors.purple,
                    colors.blue, colors.yellow, colors.cyan, colors.magenta, colors.teal,
                }) do
                    local lum = util.luminance(pill)
                    if lum > best then
                        best, brightest = lum, pill
                    end
                end
                if util.contrast(brightest, "#ffffff") > util.contrast(brightest, colors.bg) then
                    return "#ffffff"
                end
                return colors.bg
            end)(),
            -- The prompt and yesno pills. Derived rather than picked, because the palette's
            -- nine hues are all spoken for and the `*_dark` siblings do not exist in every
            -- colours/ file. Brightened from purple far enough to read as its own pill next to
            -- command's, and floored against the same `--bg` every pill sits on so a light
            -- palette does not produce one that disappears.
            bru_prompt_pill = util.ensure_contrast(
                util.brighten(colors.purple, 0.22, 0.35),
                colors.bg,
                3.0
            ),
            -- The quieter tier — a scroll percentage, a tab index — floored at 3:1 so it stays
            -- legible while still reading as secondary. `ensure_contrast` is a floor and cannot
            -- bring a bright colour down, so this starts from the palette's dimmest foreground
            -- rather than from --fg.
            bru_ui_fg_dim = util.ensure_contrast(colors.comment, colors.bg, 3.0),

            -- --- accents used as TEXT ------------------------------------------------------
            -- An accent is two different jobs and only one of them needs a floor. As a
            -- *background* — a mode pill, a message strip — the palette's own value is right and
            -- `bru_pill_fg` is what has to clear the ratio against it. As *text* on `--bg` it has
            -- to clear the ratio itself, and several of these did not: measured against everforest
            -- dark before this block existed, `--purple` behind the pending-key string read at
            -- **2.35:1**, `--cyan` behind a hovered link at 3.01:1, `--green` behind an https url
            -- at 3.17:1 and `--red` behind a failed one at 3.36:1. WCAG AA for body text is 4.5:1.
            --
            -- So the palette keys stay exactly what the palette says — `--red` is still `--red`,
            -- and anything painting a background with it is untouched — and these are separate
            -- names that only the text rules use. That is the same split `bru_ui_fg` already makes
            -- against `--fg`, for the same reason: an editor foreground is tuned against one
            -- background under syntax highlighting, and interface text is doing a different job.
            bru_text_red = util.ensure_contrast(colors.red, colors.bg, 4.5),
            bru_text_green = util.ensure_contrast(colors.green, colors.bg, 4.5),
            bru_text_yellow = util.ensure_contrast(colors.yellow, colors.bg, 4.5),
            bru_text_orange = util.ensure_contrast(colors.orange, colors.bg, 4.5),
            bru_text_cyan = util.ensure_contrast(colors.cyan, colors.bg, 4.5),
            bru_text_purple = util.ensure_contrast(colors.purple, colors.bg, 4.5),
            bru_text_blue = util.ensure_contrast(colors.blue, colors.bg, 4.5),

            -- The same seven again, against the *selected* row rather than against `--bg`.
            -- `--bg-light` is lighter, so a colour that clears 4.5:1 on `--bg` can fall under it
            -- here — measured: the matched letters of the selected completion row read at
            -- **2.97:1** while the identical colour on an unselected row read at 3.17:1. One
            -- floor for both surfaces would have to be the stricter one everywhere, which pushes
            -- every accent lighter than the palette needs.
            --
            -- **Which of the three surfaces is the hard one depends on the palette**, and assuming
            -- `bg_light` cost a measurement: on everforest *dark* it is the lightest of the three
            -- and flooring against it covers the other two, but on everforest *light* the tab rows
            -- are `--bg-soft-light` at `#e9e9e9` and the same floor came out at **4.47:1** there.
            -- So the surface is chosen rather than named: whichever of the three is nearest the
            -- text in luminance is the one that has to be cleared, and clearing it clears the rest.
            bru_sel_red = util.ensure_contrast(colors.red, hardest(colors, colors.red), 4.5),
            bru_sel_green = util.ensure_contrast(colors.green, hardest(colors, colors.green), 4.5),
            bru_sel_orange = util.ensure_contrast(colors.orange, hardest(colors, colors.orange), 4.5),
            bru_sel_fg = util.ensure_contrast(colors.fg, hardest(colors, colors.fg), 4.5),

            -- Text on an accent *background* — the info, warning and error strips, and the
            -- download rows. Here the background is the palette's and the text is derived, which
            -- is `bru_pill_fg`'s rule applied per strip rather than once: `--bg` on `--red` read
            -- at 3.36:1 and `--bg` on `--orange` at 4.49:1, and each strip's own accent is what
            -- decides whether the dark or the light answer wins.
            bru_on_red = readable_on(colors.red, colors.bg),
            bru_on_orange = readable_on(colors.orange, colors.bg),
            bru_on_cyan = readable_on(colors.cyan, colors.bg),
            bru_on_green = readable_on(colors.green, colors.bg),

            -- **Choosing the better of two texts is not always enough**, and this is the one place
            -- it was not: on everforest's `--orange` the darker candidate reached **4.49:1** and on
            -- its `--red` the white one reached **4.40:1**. Both are the best answer available and
            -- both are under 4.5, because the accent caps what any text on it can reach.
            --
            -- So the accent moves too — `ensure_contrast` walked the other way, with the *strip*
            -- as the colour and the text it just got as the background. hsluv keeps the hue, so a
            -- red strip stays red and an orange one stays orange; only the lightness gives. That is
            -- the whole difference between this and repainting the palette: the strip is still the
            -- palette's colour, one or two steps of L away from it, and `--red` itself is untouched
            -- for everything that paints with it.
            bru_strip_red = util.ensure_contrast(colors.red, readable_on(colors.red, colors.bg), 4.5),
            bru_strip_orange = util.ensure_contrast(
                colors.orange, readable_on(colors.orange, colors.bg), 4.5
            ),
            bru_on_yellow = readable_on(colors.yellow, colors.bg),
            bru_strip_yellow = util.ensure_contrast(
                colors.yellow, readable_on(colors.yellow, colors.bg), 4.5
            ),
            bru_strip_cyan = util.ensure_contrast(
                colors.cyan, readable_on(colors.cyan, colors.bg), 4.5
            ),
            bru_strip_green = util.ensure_contrast(
                colors.green, readable_on(colors.green, colors.bg), 4.5
            ),
            -- --- end accents used as TEXT --------------------------------------------------
        })
    )
    return bru
end

return M
