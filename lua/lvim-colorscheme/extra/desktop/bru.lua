-- lvim-colorscheme.extra.bru: generate a Bru theme (CSS custom properties) from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.bru"

local util = require("lvim-colorscheme.util")

local M = {}

--- The three surfaces bru paints text over, in the order `util.hardest` wants them: `--bg` is the
--- strip and the page, `--bg-soft-light` is an odd tab row, `--bg-light` is the selected row.
---
--- `util.readable_on` and `util.hardest` used to be locals here, and the comment on them said they
--- were local "because ten other desktop targets read that file and none of them asked for this".
--- They are asking now — every target with interface text needs the same two answers — so both live
--- in `util` and `hardest` takes its surfaces variadically instead of naming bru's three.
---@param colors ColorScheme
---@param text string
---@return string
local function hardest(colors, text)
    return util.hardest(text, colors.bg, colors.bg_soft_light, colors.bg_light)
end

local readable_on = util.readable_on

--- The lightest **neutral** that still clears `min` on a chip: the typed part of a hint label.
---
--- The typed characters have to read as spent, and the two obvious ways to say so both failed on
--- this chip. `--comment` floored against it landed at `#333631` beside a `#1f2529` ink — 1.26:1,
--- two dark neutrals nobody could tell apart. Seeding from `red` instead put a hue between them and
--- measured no better, 1.27:1, because the geometry is what caps it: the chip reaches 6.85:1 with
--- the theme's own background as ink, and the typed part must itself stay at 4.5 to be legible, so
--- 6.85/4.5 is every bit of lightness there is to divide.
---
--- So it is lightness alone, spent to the last unit, and **no hue at all** — saturation to 0 and
--- then a walk toward the chip while the floor still holds. `#404040` on everforest: a grey that is
--- visibly not the ink, on a chip that is visibly yellow. A colour there competes with the chip; a
--- grey withdraws, which is what a character already typed should do.
---@param ink string  the label's own foreground, whose lightness is the starting point
---@param chip string  the label's background
---@param min number  the contrast the result must keep against `chip`
---@return string
local function faded(ink, chip, min)
    local hsluv = require("lvim-colorscheme.hsluv")
    local hsl = hsluv.hex_to_hsluv(ink)
    local towards = hsluv.hex_to_hsluv(chip)[3] > hsl[3] and 1 or -1
    local best = hsluv.hsluv_to_hex({ hsl[1], 0, hsl[3] })
    for _ = 1, 100 do
        hsl[3] = hsl[3] + towards
        if hsl[3] < 0 or hsl[3] > 100 then
            break
        end
        local try = hsluv.hsluv_to_hex({ hsl[1], 0, hsl[3] })
        if util.contrast(try, chip) < min then
            break
        end
        best = try
    end
    return best
end

--- Of a theme's own accents, the one whose hue is **nearest** a target — used where a colour has to
--- mean something rather than merely belong to the palette.
---
--- A tab's loading stripe is the case that needed it. bru draws it in the theme's `--green` when a
--- page is done and the theme's yellow while it fetches, and on everforest and gruvbox those two
--- are 19° apart in hsluv: `green_bright` is `#82861f`, hue 89, an olive, beside a yellow at hue 70.
--- Two states, one colour, and the stripe stops saying anything. Those palettes do have a green —
--- `cyan_bright` is `#488b52`, hue 132, which is green by any eye — and on kanagawa, nord,
--- tokyonight and solarized `green` is already the nearer of the two and stays chosen.
---
--- Hue distance the short way round the circle, so 350 and 10 are 20 apart and not 340.
---@param target number  the hue being looked for, hsluv degrees
---@param ... string  the candidates, all of them the theme's own
---@return string
local function nearest_hue(target, ...)
    local hsluv = require("lvim-colorscheme.hsluv")
    local best, gap = nil, math.huge
    for _, candidate in ipairs({ ... }) do
        local hue = hsluv.hex_to_hsluv(candidate)[1]
        local away = math.abs(hue - target) % 360
        away = math.min(away, 360 - away)
        if away < gap then
            best, gap = candidate, away
        end
    end
    return best
end

--- The two **visible** surface steps a page needs, off `bg`, as `{raised, raised_more}`.
---
--- **The palette's surfaces are too close together to read as a step on a page.** Measured on
--- everforest dark 2026-08-07: `--bg` is `#232929` and `--bg-soft-light`, the next tier up, is
--- `#252c2c` — two and three units per channel, **1.06:1**. That is right for an editor, where the
--- chrome must not shout at the code, and wrong for a web page, where a card has to look like a
--- card. A scan across a raised search field and the page either side came back `rgb(37,44,44)`
--- against `rgb(35,41,41)`: a difference a screenshot can find and an eye cannot. `1.22:1` is what
--- read as a surface on the same screen, and `1.45:1` is the second step, for the thing under the
--- pointer.
---
--- **Direction from the palette — unless the palette's direction has no room.** `util.to_contrast`
--- is the obvious tool and it is the wrong one: it picks its direction from `luminance(bg) < 0.5`,
--- so on a light theme it walks a raised surface *darker* without asking. Which way "up" is on a
--- surface tier is what the palette means by `bg_light`, so that chooses the sign first.
---
--- But it cannot choose alone, and the sweep is what said so. On all **12 light styles** `--bg` is
--- `#E4E4E4`, and walking up runs into white: `raised` landed at `#fbfbfb` and `raised_more` at
--- `#fefefe`, **1.026:1 apart** — two names for one colour, and the second tier silently gone.
--- So the direction is chosen once, by which side has room for the LARGER step, and both tiers take
--- it. Both on the same side matters: "more raised" that crosses to the other side of the page is
--- not a further step, it is a different idea.
---
--- The hue and the L:S ratio are `bg`'s own, `ensure_contrast`'s rule, so a step stays this
--- palette's colour rather than drifting toward grey. A tier that cannot be reached in either
--- direction comes back as far as the walk got, which is a flat page rather than a wrong one.
---@param bg string
---@param bg_light string  the palette's own next surface up — read for its DIRECTION only
---@param near number  contrast ratio against `bg` for the first step
---@param far number  and for the second
---@return string, string
local function surfaces(bg, bg_light, near, far)
    local hsluv = require("lvim-colorscheme.hsluv")
    local base = hsluv.hex_to_hsluv(bg)
    local l0, s0 = base[3], base[2]

    -- Walk `dir` until the ratio is met; answer how far it actually got as well, so the caller can
    -- tell "reached" from "ran out".
    local function walk(dir, target)
        local hsl = { base[1], base[2], base[3] }
        local out = bg
        for _ = 1, 100 do
            hsl[3] = hsl[3] + dir
            if hsl[3] > 100 or hsl[3] < 0 then
                return out, false
            end
            if l0 > 0 then
                hsl[2] = math.min(s0 * (hsl[3] / l0), 100)
            end
            out = hsluv.hsluv_to_hex(hsl)
            if util.contrast(out, bg) >= target then
                return out, true
            end
        end
        return out, false
    end

    local up = hsluv.hex_to_hsluv(bg_light)[3] >= base[3] and 1 or -1
    local _, room = walk(up, far)
    local dir = room and up or -up
    return (walk(dir, near)), (walk(dir, far))
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

    /* Derived, not palette: **a surface that reads as one step above the page.**
       The palette's own tiers sit 1.06:1 apart, which an editor wants and a web
       page cannot use — see `surfaces` in extra/desktop/bru.lua for the two
       measurements, and for why on a light palette the step goes DOWN.
       These are what a per-site stylesheet names for a card, a search bar or a
       popup, so that "raised" means the same thing on all 49 palettes and nothing
       has to guess a percentage against one of them. */
    --raised: ${bru_raised};
    --raised-more: ${bru_raised_more};

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
    --hints-fg: ${bru_hint_fg};
    --hints-bg: ${bru_hint_bg};
    --hints-match-fg: ${bru_hint_match};

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
    /* The stripe down a tab's leading edge, which is the only thing on the strip
       that reports a state rather than a name: the theme's yellow while the page
       fetches, its green once it is done, its red if it failed. The ANSI brights,
       not the plain keys — a 2px line has no room to be a muted accent, and
       everforest's `--green` at that width is indistinguishable from its own
       `--yellow`. See `nearest_hue` for which of the theme's colours counts as
       green on a palette whose green is an olive. */
    --tabs-indicator-start: ${bru_tab_loading};
    --tabs-indicator-stop: ${bru_tab_loaded};
    --tabs-indicator-error: ${bru_tab_failed};
    --tabs-indicator-system: transparent;
    --tabs-odd-fg: ${bru_sel_fg};
    --tabs-odd-bg: var(--bg-soft-light);
    --tabs-even-fg: var(--ui-fg);
    --tabs-even-bg: var(--bg);
    /* **The active tab, and the two rules that make it one.** `--bg-light` was
       every one of these, and measured against the rows either side it is 1.14:1
       on `--bg` and 1.07:1 on `--bg-soft-light` — a difference a screenshot can
       find and an eye cannot, which is what was reported. The surface is a
       measured step now, and the text on it is floored higher than the text on a
       tab that is merely open, so the active tab is brighter in both. */
    --tabs-selected-odd-fg: ${bru_tab_active_fg};
    --tabs-selected-odd-bg: ${bru_tab_active_bg};
    --tabs-selected-even-fg: ${bru_tab_active_fg};
    --tabs-selected-even-bg: ${bru_tab_active_bg};
    --tabs-pinned-odd-fg: ${bru_sel_fg};
    --tabs-pinned-odd-bg: var(--bg-soft-light);
    --tabs-pinned-even-fg: var(--ui-fg);
    --tabs-pinned-even-bg: var(--bg);
    --tabs-pinned-selected-odd-fg: ${bru_tab_active_fg};
    --tabs-pinned-selected-odd-bg: ${bru_tab_active_bg};
    --tabs-pinned-selected-even-fg: ${bru_tab_active_fg};
    --tabs-pinned-selected-even-bg: ${bru_tab_active_bg};

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
                    colors.green,
                    colors.red,
                    colors.orange,
                    colors.purple,
                    colors.blue,
                    colors.yellow,
                    colors.cyan,
                    colors.magenta,
                    colors.teal,
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
            bru_prompt_pill = util.ensure_contrast(util.brighten(colors.purple, 0.22, 0.35), colors.bg, 3.0),
            -- The quieter tier — a scroll percentage, a tab index, a timestamp. **Floored at 4.5,
            -- not at 3.0.** It sat at 3.0 so that it would still read as secondary, and 3:1 is
            -- WCAG AA for *large* text; bru's chrome is 13px monospace, which is not large, so the
            -- tier was the one thing on screen that failed the standard the rest was held to.
            --
            -- What keeps it a tier at 4.5 is that it starts from a **different colour**:
            -- `--comment` is its own hue in every palette here, and `ensure_contrast` walks
            -- lightness in hsluv without touching hue, so the two arrive at the same ratio by
            -- different routes and stay visibly different. Measured across all 48 generated
            -- themes — see the numbers in bru's commit. Where a palette's comment and foreground
            -- are the same hue, the tier is thinner than it was, and that is the price of the
            -- floor rather than a defect.
            bru_ui_fg_dim = util.ensure_contrast(colors.comment, hardest(colors, colors.comment), 4.5),

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
            bru_strip_orange = util.ensure_contrast(colors.orange, readable_on(colors.orange, colors.bg), 4.5),
            -- The hint label. **These three are hint-only** — no other rule in this file reads
            -- them — which is why they are named for the label rather than for the accent, unlike
            -- the `on_`/`strip_` pairs above that each serve a strip and a download row.
            --
            -- **`terminal.yellow_bright`, not `yellow`.** Both are the theme's; the difference is
            -- which question each was answering. `--yellow` is tuned to sit behind code in an
            -- editor for hours, and on everforest that is `#af9e6b`, hsluv S54 — a khaki, and it
            -- reads as dirt on a chip four characters wide. The ANSI bright is the same hue at
            -- S73: `#c3ab58`, still the theme's yellow and no longer muddy. The relation holds on
            -- all 48 styles, because every palette derives its bright from its own.
            --
            -- **Not a yellow of this file's own.** hsluv S100 was tried — `#f7d200`, a marker — on
            -- the argument that a label is drawn over somebody else's page and has to be found by
            -- eye. Rejected on sight: over a dark theme a pure yellow chip is a lamp, and the point
            -- of reading the theme at all is that bru looks like the rest of the desktop.
            bru_hint_bg = util.ensure_contrast(
                colors.terminal.yellow_bright,
                readable_on(colors.terminal.yellow_bright, colors.bg),
                4.5
            ),
            bru_hint_fg = readable_on(colors.terminal.yellow_bright, colors.bg),

            -- The already-typed part of a label — see `faded` for why it is a grey and not a colour,
            -- and for the two derivations that were measured and thrown away first.
            --
            -- **The rest of the signal is bru's, not the theme's.** `chrome/hints.js` also strikes
            -- the typed characters through and drops them to 0.55 opacity. On a chip with this
            -- little lightness to spare that is what carries the difference; the grey is the part
            -- that survives a screenshot.
            bru_hint_match = faded(
                readable_on(colors.terminal.yellow_bright, colors.bg),
                util.ensure_contrast(
                    colors.terminal.yellow_bright,
                    readable_on(colors.terminal.yellow_bright, colors.bg),
                    4.5
                ),
                4.5
            ),
            -- --- the tab strip's active row and its loading stripe ------------------------
            -- **A measured step, not the palette's next tier.** `--bg-light` is what the strip used
            -- for its active tab and it is 1.14:1 above `--bg`: right for an editor, where the
            -- current line must not shout over the code, and not a mark on a row of tabs. 1.45 is
            -- the second of the two steps `surfaces` measured as *visible on a page*, and the tab
            -- strip is a page — it is drawn in `bru://chrome/top.html` like everything else here.
            bru_tab_active_bg = select(2, surfaces(colors.bg, colors.bg_light, 1.22, 1.45)),

            -- **7:1 where an open tab's title gets 4.5.** Both floors are against the surface each
            -- title is actually drawn on, so the difference between them is the whole signal: the
            -- active tab is the brighter text as well as the lighter row, and neither alone had to
            -- carry it.
            bru_tab_active_fg = util.ensure_contrast(
                colors.fg,
                select(2, surfaces(colors.bg, colors.bg_light, 1.22, 1.45)),
                7
            ),

            -- The stripe: fetching, done, failed. The ANSI brights, because a 2px line is too
            -- narrow to read a muted accent, and `nearest_hue` for the one that has to mean *green*
            -- rather than merely be the key called green — see its comment for the two palettes
            -- whose green is an olive 19° from their own yellow.
            bru_tab_loading = colors.terminal.yellow_bright,
            bru_tab_loaded = nearest_hue(130, colors.terminal.green_bright, colors.terminal.cyan_bright),
            bru_tab_failed = colors.terminal.red_bright,

            bru_strip_cyan = util.ensure_contrast(colors.cyan, readable_on(colors.cyan, colors.bg), 4.5),
            bru_strip_green = util.ensure_contrast(colors.green, readable_on(colors.green, colors.bg), 4.5),
            -- --- end accents used as TEXT --------------------------------------------------

            -- The two surface steps a page needs — see `surfaces` for the two measurements the
            -- numbers come from, and for why the direction is not simply "lighter".
            bru_raised = select(1, surfaces(colors.bg, colors.bg_light, 1.22, 1.45)),
            bru_raised_more = select(2, surfaces(colors.bg, colors.bg_light, 1.22, 1.45)),
        })
    )
    return bru
end

return M
