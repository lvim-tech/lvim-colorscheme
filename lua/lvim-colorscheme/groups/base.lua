local util = require("lvim-colorscheme.util")

local M = {}

---@type lvim-colorscheme.HighlightsFn
function M.get(c, opts)
    local blend = c.blend
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
            bg = c.fg,
            fg = c.bg,
        }, -- character under the cursor
        lCursor = {
            bg = c.fg,
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
            bg = util.blend_bg(c.bg_highlight, 0.1),
        }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory = {
            fg = c.green_dark,
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
            fg = c.error,
        }, -- error messages on the command line
        VertSplit = {
            fg = c.border,
        }, -- the column separating vertically split windows
        WinSeparator = {
            fg = c.border,
            bold = true,
        }, -- the column separating vertically split windows
        Folded = {
            bg = c.bg,
            fg = c.fg,
        }, -- line used for closed folds
        FoldColumn = {
            bg = opts.transparent and c.none or c.bg,
            fg = c.comment,
        }, -- 'foldcolumn'
        SignColumn = {
            bg = opts.transparent and c.none or c.bg,
            fg = c.fg_dark,
        }, -- column where |signs| are displayed
        SignColumnSB = {
            bg = c.bg_sidebar,
            fg = c.fg_dark,
        }, -- column where |signs| are displayed
        Substitute = {
            bg = c.red,
            fg = c.black,
        }, -- |:substitute| replacement text highlighting
        LineNr = {
            fg = c.fg_dark,
        }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr = {
            fg = c.yellow_dark,
            bold = true,
        }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        LineNrAbove = {
            fg = c.fg_dark,
        },
        SCVLine = {
          fg = util.blend_bg(c.fg_dark, 0.2),
        },
        LinrgfloweNrBelow = {
            fg = c.fg_dark,
        },
        MatchParen = {
            bg = blend.blueHigh,
            fg = c.blue,
            bold = true,
        }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg = {
            fg = c.fg_soft_dark,
            bold = true,
        }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea = {
            fg = c.fg_soft_dark,
        }, -- Area for messages and cmdline
        MoreMsg = {
            fg = c.green_dark,
        }, -- |more-prompt|
        NonText = {
            fg = c.comment,
        }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal = {
            bg = opts.transparent and c.none or opts.dim_active and c.bg_soft_dark or c.bg,
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
            fg = c.fg_float,
        }, -- Normal text in floating windows.
        FloatBorder = {
            bg = c.bg_float,
            fg = c.bg_float,
        },
        FloatTitle = {
            bg = c.bg_float,
            fg = c.border_highlight,
        },
        Pmenu = {
            bg = c.bg_popup,
            fg = c.fg,
        }, -- Popup menu: normal item.
        PmenuMatch = {
            bg = blend.blueHigh,
            fg = c.blue,
            bold = true,
        }, -- Popup menu: Matched text in normal item.
        PmenuSel = {
            bg = blend.blueHigh,
        }, -- Popup menu: selected item.
        PmenuMatchSel = {
            bg = blend.blueHigh,
            fg = c.blue,
            bold = true,
        }, -- Popup menu: Matched text in selected item.
        PmenuSbar = {
            bg = c.bg_float,
        }, -- Popup menu: scrollbar.
        PmenuThumb = {
            bg = c.green_dark,
        }, -- Popup menu: Thumb of the scrollbar.
        Question = {
            fg = c.green_dark,
        }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine = {
            bg = c.bg_visual,
            bold = true,
        }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search = {
            bg = c.bg_search,
        }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        IncSearch = {
            bg = c.bg_highlight,
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
            fg = c.fg_sidebar,
        }, -- status line of current window
        StatusLineNC = {
            bg = c.bg_statusline,
            fg = c.fg_dark,
        }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine = {
            bg = c.bg_statusline,
            fg = c.fg_dark,
        }, -- tab pages line, not active tab page label
        TabLineFill = {
            bg = c.black,
        }, -- tab pages line, where there are no labels
        TabLineSel = {
            bg = c.green_dark,
            fg = c.black,
        }, -- tab pages line, active tab page label
        Title = {
            fg = c.green_dark,
            bold = true,
        }, -- titles for output from ":set all", ":autocmd" etc.
        Visual = {
            bg = c.bg_visual,
        }, -- Visual mode selection
        VisualNOS = {
            bg = c.bg_visual,
        }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg = {
            fg = c.warning,
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
            fg = c.green_dark,
        },
        qfLineNr = {
            fg = c.bg_light,
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
            fg = c.fg_soft_dark,
            style = opts.styles.comments,
        }, -- Diagnostic source information
        DiagnosticOk = {
            fg = c.blue,
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticError = {
            fg = c.error,
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticWarn = {
            fg = c.warning,
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticInfo = {
            fg = c.info,
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticHint = {
            fg = c.hint,
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticUnnecessary = {
            fg = c.comment,
        }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticVirtualLinesError = {
            bg = util.blend_bg(c.error, 0.1),
            fg = c.error,
        }, -- Used for "Error" diagnostic virtual lines
        DiagnosticVirtualLinesWarn = {
            bg = util.blend_bg(c.warning, 0.1),
            fg = c.warning,
        }, -- Used for "Warning" diagnostic virtual lines
        DiagnosticVirtualLinesInfo = {
            bg = util.blend_bg(c.info, 0.1),
            fg = c.info,
        }, -- Used for "Information" diagnostic virtual lines
        DiagnosticVirtualLinesHint = {
            bg = util.blend_bg(c.hint, 0.1),
            fg = c.hint,
        }, -- Used for "Hint" diagnostic virtual lines
        DiagnosticVirtualTextError = {
            bg = util.blend_bg(c.error, 0.1),
            fg = c.error,
        }, -- Used for "Error" diagnostic virtual text
        DiagnosticVirtualTextWarn = {
            bg = util.blend_bg(c.warning, 0.1),
            fg = c.warning,
        }, -- Used for "Warning" diagnostic virtual text
        DiagnosticVirtualTextInfo = {
            bg = util.blend_bg(c.info, 0.1),
            fg = c.info,
        }, -- Used for "Information" diagnostic virtual text
        DiagnosticVirtualTextHint = {
            bg = util.blend_bg(c.hint, 0.1),
            fg = c.hint,
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
            fg = c.error,
        },
        healthSuccess = {
            fg = c.teal_dark,
        },
        healthWarning = {
            fg = c.warning,
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
