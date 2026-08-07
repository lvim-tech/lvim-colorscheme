-- lvim-colorscheme.groups.base: core editor + UI highlight groups (Normal, statusline, floats, diagnostics, …).
--
---@module "lvim-colorscheme.groups.base"

local util = require("lvim-colorscheme.util")

local M = {}

--- Floor one **interface text** colour at 4.5:1 against whichever of the surfaces it is drawn over
--- gives it the hardest time.
---
--- **This is not applied to everything, and must not be.** A colourscheme's syntax groups are a
--- deliberate hierarchy — `Comment` recedes because that is its job — and measured against 4.5, 599
--- of this scheme's 675 syntax pairs "fail", as they do in every colourscheme in the world. So does
--- every group whose invisibility is the point: `EndOfBuffer` hides the `~` after the last line at
--- 1.00:1, `VertSplit` and `WinSeparator` hide the split at 1.00:1, `SpecialKey`, `NonText`,
--- `Whitespace` and `Conceal` mark characters that are not really there and are meant to be noticed
--- only when looked for. Flooring any of those puts tildes and split lines back on the screen.
---
--- What is floored is the chrome that is read as *words*: line numbers, the status line, tab
--- labels, messages, prompts, float and popup body text, diagnostics. Measured before this existed,
--- `LineNr` sat at **1.98:1** on everforest_dark and at **1.42:1** on base_soft — a line number is
--- read, and 1.42:1 is not a design choice.
---
--- Two details cost measurements. `opts.transparent` collapses `bg_statusline` and friends to
--- `c.none` (the string "NONE"), which is not a colour and cannot be measured, so non-hex surfaces
--- are dropped and the opaque value is what gets floored — a transparent statusline shows the
--- terminal's background, which this file cannot know. And a group usually has more than one
--- surface: `LineNr` is drawn on `bg` in an unfocused window and on `bg_active` in the focused one,
--- `Pmenu`'s foreground is drawn on `bg_popup` and again on `PmenuSel`'s wash. `util.hardest` picks
--- the nearest in luminance, which is the one that has to be cleared, and clearing it clears the
--- rest — naming a surface instead of choosing one is the bug that gave 4.47:1 on everforest_light.
---@param fg string
---@param ... string  the surfaces it may be painted on
---@return string
local function ui(fg, ...)
    local surfaces = {}
    for _, s in ipairs({ ... }) do
        if type(s) == "string" and s:match("^#%x%x%x%x%x%x$") then
            surfaces[#surfaces + 1] = s
        end
    end
    if #surfaces == 0 or type(fg) ~= "string" or not fg:match("^#%x%x%x%x%x%x$") then
        return fg
    end
    return util.ensure_contrast(fg, util.hardest(fg, unpack(surfaces)), 4.5)
end

---@type lvim-colorscheme.HighlightsFn
function M.get(c, opts)
    local blend = c.blend
    -- The surfaces each piece of chrome is painted on, named once. `bg_soft_dark` rather than
    -- `bg_statusline` and `bg_popup` because those two are the same colour and either may have been
    -- turned into "NONE" by `transparent`; the floor is against what is painted when it is not.
    local page = { c.bg, c.bg_active }
    local strip = { c.bg_soft_dark }
    -- `PmenuSel` sets only a background, so `Pmenu`'s foreground is what neovim draws on the
    -- selected row too — both surfaces have to clear.
    local popup = { c.bg_popup, blend.blueHigh }
    -- The active tab label paints an accent and puts text on it. The background is the one that
    -- must not move far — a tab strip that is no longer green has stopped matching the theme — so
    -- the text is chosen from the two the theme has, and only if that still cannot reach 4.5:1 does
    -- the accent give a step of lightness. hsluv holds the hue, so it stays green.
    local tabsel_fg = util.readable_on(c.green_dark, c.black)
    local tabsel_bg = util.ensure_contrast(c.green_dark, tabsel_fg, 4.5)
    return {
        Comment = {
            fg = c.comment,
            style = opts.styles.comments,
        }, -- any comment
        ColorColumn = {
            bg = c.black,
        }, -- used for the columns set with 'colorcolumn'
        Conceal = {
            fg = c.bg_light,
        }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor = {
            bg = c.cursor_block,
            fg = c.bg,
        }, -- character under the cursor
        lCursor = {
            bg = c.cursor_block,
            fg = c.bg,
        }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM = {
            bg = c.fg,
            fg = c.bg,
        }, -- like Cursor, but used when in IME mode |CursorIM|
        CursorColumn = {
            bg = c.bg_highlight,
        }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine = {
            bg = c.bg_cursorline,
        }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory = {
            fg = ui(c.green_dark, unpack(page)),
        }, -- directory names (and other special names in listings)
        DiffAdd = {
            bg = c.diff.add,
        }, -- diff mode: Added line |diff.txt|
        DiffChange = {
            bg = c.diff.change,
        }, -- diff mode: Changed line |diff.txt|
        DiffDelete = {
            bg = c.diff.delete,
        }, -- diff mode: Deleted line |diff.txt|
        DiffText = {
            bg = c.diff.text,
        }, -- diff mode: Changed text within a changed line |diff.txt|
        EndOfBuffer = {
            fg = c.bg,
        }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        ErrorMsg = {
            fg = ui(c.error, unpack(page)),
        }, -- error messages on the command line
        VertSplit = {
            fg = c.border,
            bg = c.border,
        }, -- the column separating vertically split windows (solid: fg=bg hides the glyph's thin line)
        WinSeparator = {
            fg = c.border,
            bg = c.border,
        }, -- the column/row separating split windows (solid: fg=bg hides the glyph's thin line)
        Folded = {
            bg = c.bg,
            fg = ui(c.fg, c.bg),
        }, -- line used for closed folds
        FoldColumn = {
            bg = opts.transparent and c.none or c.bg,
            fg = ui(c.comment, unpack(page)),
        }, -- 'foldcolumn'
        SignColumn = {
            bg = opts.transparent and c.none or c.bg,
            fg = ui(c.fg_dark, unpack(page)),
        }, -- column where |signs| are displayed
        SignColumnSB = {
            bg = c.bg_sidebar,
            fg = ui(c.fg_dark, c.bg_sidebar),
        }, -- column where |signs| are displayed
        Substitute = {
            bg = c.red,
            fg = c.black,
        }, -- |:substitute| replacement text highlighting
        LineNr = {
            fg = ui(c.fg_dark, unpack(page)),
        }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr = {
            fg = ui(c.yellow_dark, c.bg_cursorline, unpack(page)),
            bold = true,
        }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        LineNrAbove = {
            fg = ui(c.fg_dark, unpack(page)),
        },
        SCVLine = {
            fg = util.blend_bg(c.fg_dark, 0.2),
        },
        LineNrBelow = {
            fg = ui(c.fg_dark, unpack(page)),
        },
        MatchParen = {
            bg = blend.blueHigh,
            fg = c.blue,
            bold = true,
        }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg = {
            fg = ui(c.fg_soft_dark, unpack(page)),
            bold = true,
        }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea = {
            fg = ui(c.fg_soft_dark, unpack(page)),
        }, -- Area for messages and cmdline
        MoreMsg = {
            fg = ui(c.green_dark, unpack(page)),
        }, -- |more-prompt|
        NonText = {
            fg = c.comment,
        }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal = {
            -- `dark_active` darkens the FOCUSED window's bg toward black by `dark_active_amount`
            -- (precomputed as c.bg_active). Independent of `dim_inactive` (dim.lua; non-focused fg).
            bg = opts.transparent and c.none or c.bg_active,
            fg = c.fg,
        }, -- normal text
        NormalNC = {
            bg = opts.transparent and c.none or c.bg,
            fg = c.fg,
        }, -- normal text in non-current windows
        NormalSB = {
            bg = c.bg_sidebar,
            fg = c.fg_sidebar,
        }, -- normal text in sidebar
        NormalFloat = {
            bg = c.bg_float,
            fg = ui(c.fg_float, c.bg_float),
        }, -- Normal text in floating windows.
        FloatBorder = {
            bg = c.bg_float,
            fg = c.bg_float,
        },
        FloatTitle = {
            bg = c.bg_float,
            fg = ui(c.border_highlight, c.bg_float),
        },
        Pmenu = {
            bg = c.bg_popup,
            fg = ui(c.fg, unpack(popup)),
        }, -- Popup menu: normal item.
        PmenuMatch = {
            bg = blend.blueHigh,
            fg = ui(c.blue, blend.blueHigh),
            bold = true,
        }, -- Popup menu: Matched text in normal item.
        PmenuSel = {
            bg = blend.blueHigh,
        }, -- Popup menu: selected item.
        PmenuMatchSel = {
            bg = blend.blueHigh,
            fg = ui(c.blue, blend.blueHigh),
            bold = true,
        }, -- Popup menu: Matched text in selected item.
        PmenuSbar = {
            bg = c.bg_float,
        }, -- Popup menu: scrollbar.
        PmenuThumb = {
            bg = c.green_dark,
        }, -- Popup menu: Thumb of the scrollbar.
        Question = {
            fg = ui(c.green_dark, unpack(page)),
        }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine = {
            bg = c.bg_visual,
            bold = true,
        }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search = {
            bg = c.bg_search,
            fg = c.orange,
            bold = true,
        }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        IncSearch = {
            bg = c.bg_highlight,
            fg = c.orange,
            bold = true,
        }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        CurSearch = "IncSearch",
        SpecialKey = {
            fg = c.bg_soft_light,
        }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad = {
            sp = c.error,
            undercurl = true,
        }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap = {
            sp = c.warning,
            undercurl = true,
        }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal = {
            sp = c.info,
            undercurl = true,
        }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare = {
            sp = c.hint,
            undercurl = true,
        }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        StatusLine = {
            bg = c.bg_statusline,
            fg = ui(c.fg_sidebar, unpack(strip)),
        }, -- status line of current window
        StatusLineNC = {
            bg = c.bg_statusline,
            fg = ui(c.fg_dark, unpack(strip)),
        }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine = {
            bg = c.bg_statusline,
            fg = ui(c.fg_dark, unpack(strip)),
        }, -- tab pages line, not active tab page label
        TabLineFill = {
            bg = c.black,
        }, -- tab pages line, where there are no labels
        TabLineSel = {
            bg = tabsel_bg,
            fg = tabsel_fg,
        }, -- tab pages line, active tab page label
        Title = {
            fg = ui(c.green_dark, unpack(page)),
            bold = true,
        }, -- titles for output from ":set all", ":autocmd" etc.
        Visual = {
            bg = c.bg_visual,
        }, -- Visual mode selection
        VisualNOS = {
            bg = c.bg_visual,
        }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg = {
            fg = ui(c.warning, unpack(page)),
        }, -- warning messages
        Whitespace = {
            fg = c.fg_dark,
        }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        WildMenu = {
            bg = c.bg_visual,
        }, -- current match in 'wildmenu' completion
        WinBar = "StatusLine", -- window bar
        WinBarNC = "StatusLineNC", -- window bar in inactive windows

        Bold = {
            bold = true,
            fg = c.fg,
        }, -- (preferred) any bold text
        Character = {
            fg = c.green,
        }, --  a character constant: 'c', '\n'
        Constant = {
            fg = c.orange,
        }, -- (preferred) any constant
        Debug = {
            fg = c.orange,
        }, --    debugging statements
        Delimiter = "Special", --  character that needs attention
        Error = {
            fg = c.error,
        }, -- (preferred) any erroneous construct
        Function = {
            fg = c.blue_dark,
            style = opts.styles.functions,
        }, -- function name (also: methods for classes)
        Identifier = {
            fg = c.magenta,
            style = opts.styles.variables,
        }, -- (preferred) any variable name
        Italic = {
            italic = true,
            fg = c.fg,
        }, -- (preferred) any italic text
        Keyword = {
            fg = c.cyan,
            style = opts.styles.keywords,
        }, --  any other keyword
        Operator = {
            fg = c.cyan_dark,
        }, -- "sizeof", "+", "*", etc.
        PreProc = {
            fg = c.cyan,
        }, -- (preferred) generic Preprocessor
        Special = {
            fg = c.red_dark,
        }, -- (preferred) any special symbol
        Statement = {
            fg = c.magenta,
        }, -- (preferred) any statement
        String = {
            fg = c.green,
        }, --   a string constant: "this is a string"
        Todo = {
            bg = c.yellow,
            fg = c.bg,
        }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Type = {
            fg = c.yellow,
        }, -- (preferred) int, long, char, etc.
        Underlined = {
            underline = true,
        }, -- (preferred) text that stands out, HTML links
        debugBreakpoint = {
            bg = util.blend_bg(c.info, 0.1),
            fg = c.info,
        }, -- used for breakpoint colors in terminal-debug
        debugPC = {
            bg = c.bg_sidebar,
        }, -- used for highlighting the current line in terminal-debug
        dosIniLabel = "@property",
        helpCommand = {
            bg = c.terminal_bg,
            fg = c.green_dark,
        },
        htmlH1 = {
            fg = c.magenta,
            bold = true,
        },
        htmlH2 = {
            fg = c.green_dark,
            bold = true,
        },
        qfFileName = {
            fg = ui(c.green_dark, unpack(page)),
        },
        -- A quickfix line number is a line number: it is read, and it was `bg_light` — a
        -- *background* key used as text, which is near-invisible by construction.
        qfLineNr = {
            fg = ui(c.bg_light, unpack(page)),
        },

        -- These groups are for the native LSP client. Some other LSP clients may
        -- use these groups, or use their own.
        LspReferenceText = {
            bg = c.bg_search,
        }, -- used for highlighting "text" references
        LspReferenceRead = {
            bg = c.bg_search,
        }, -- used for highlighting "read" references
        LspReferenceWrite = {
            bg = c.bg_search,
        }, -- used for highlighting "write" references
        LspSignatureActiveParameter = {
            bg = util.blend_bg(c.bg_visual, 0.4),
            bold = true,
        },
        LspCodeLens = {
            bg = util.blend(c.teal, 0.2, c.bg),
            fg = c.teal,
            style = opts.styles.comments,
        },
        LspCodeLensSeparator = {
            fg = c.red_dark,
        },
        LspInlayHint = {
            fg = c.fg_soft_light,
            style = opts.styles.comments,
        },
        LspInfoBorder = {
            bg = c.bg_float,
            fg = c.border_highlight,
        },

        -- diagnostics
        DiagnosticSourceInfo = {
            fg = ui(c.fg_soft_dark, c.bg, c.bg_active, c.bg_float),
            style = opts.styles.comments,
        }, -- Diagnostic source information
        DiagnosticOk = {
            fg = ui(c.blue, unpack(page)),
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticError = {
            fg = ui(c.error, unpack(page)),
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticWarn = {
            fg = ui(c.warning, unpack(page)),
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticInfo = {
            fg = ui(c.info, unpack(page)),
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticHint = {
            fg = ui(c.hint, unpack(page)),
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticUnnecessary = {
            fg = c.comment,
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticVirtualLinesError = {
            bg = util.blend_bg(c.error, 0.1),
            fg = ui(c.error, util.blend_bg(c.error, 0.1)),
        }, -- Used for "Error" diagnostic virtual lines
        DiagnosticVirtualLinesWarn = {
            bg = util.blend_bg(c.warning, 0.1),
            fg = ui(c.warning, util.blend_bg(c.warning, 0.1)),
        }, -- Used for "Warning" diagnostic virtual lines
        DiagnosticVirtualLinesInfo = {
            bg = util.blend_bg(c.info, 0.1),
            fg = ui(c.info, util.blend_bg(c.info, 0.1)),
        }, -- Used for "Information" diagnostic virtual lines
        DiagnosticVirtualLinesHint = {
            bg = util.blend_bg(c.hint, 0.1),
            fg = ui(c.hint, util.blend_bg(c.hint, 0.1)),
        }, -- Used for "Hint" diagnostic virtual lines
        DiagnosticVirtualTextError = {
            bg = util.blend_bg(c.error, 0.1),
            fg = ui(c.error, util.blend_bg(c.error, 0.1)),
        }, -- Used for "Error" diagnostic virtual text
        DiagnosticVirtualTextWarn = {
            bg = util.blend_bg(c.warning, 0.1),
            fg = ui(c.warning, util.blend_bg(c.warning, 0.1)),
        }, -- Used for "Warning" diagnostic virtual text
        DiagnosticVirtualTextInfo = {
            bg = util.blend_bg(c.info, 0.1),
            fg = ui(c.info, util.blend_bg(c.info, 0.1)),
        }, -- Used for "Information" diagnostic virtual text
        DiagnosticVirtualTextHint = {
            bg = util.blend_bg(c.hint, 0.1),
            fg = ui(c.hint, util.blend_bg(c.hint, 0.1)),
        }, -- Used for "Hint" diagnostic virtual text
        DiagnosticUnderlineError = {
            undercurl = true,
            sp = c.error,
        }, -- Used to underline "Error" diagnostics
        DiagnosticUnderlineWarn = {
            undercurl = true,
            sp = c.warning,
        }, -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineInfo = {
            undercurl = true,
            sp = c.info,
        }, -- Used to underline "Information" diagnostics
        DiagnosticUnderlineHint = {
            undercurl = true,
            sp = c.hint,
        }, -- Used to underline "Hint" diagnostics

        -- Health
        healthError = {
            fg = ui(c.error, unpack(page)),
        },
        healthSuccess = {
            fg = ui(c.teal_dark, unpack(page)),
        },
        healthWarning = {
            fg = ui(c.warning, unpack(page)),
        },

        -- diff (not needed anymore?)
        diffAdded = {
            bg = c.diff.add,
            fg = c.git.add,
        },
        diffRemoved = {
            bg = c.diff.delete,
            fg = c.git.delete,
        },
        diffChanged = {
            bg = c.diff.change,
            fg = c.git.change,
        },
        diffOldFile = {
            fg = c.red,
            bg = c.diff.delete,
        },
        diffNewFile = {
            fg = c.green,
            bg = c.diff.add,
        },
        diffFile = {
            fg = c.green_dark,
        },
        diffLine = {
            fg = c.comment,
        },
        diffIndexLine = {
            fg = c.magenta,
        },
        helpExample = {
            fg = c.comment,
        },
    }
end

return M
