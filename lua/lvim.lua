-- Theme: lvim
-- Author: lvim-org
-- License: BSD 3-Clause License
-- Source: https://github.com/lvim-org/lvim-colorscheme
local lvim = {
    base0 = '#2E3440',
    base1 = '#252A34',
    base2 = '#2B303B',

    bg = '#2E3440',
    bg1 = '#EBCB8B',
    bg_highlight = '#252A34',
    bg_visual = '#EBCB8B',

    fg = '#EBCB8B',
    color_0 = '#56adb7',
    color_1 = '#00839F',
    color_2 = '#98c379',
    color_3 = '#f78c6c',
    color_4 = '#1C9898',
    color_5 = '#25B8A5',
    color_6 = '#628b97',
    color_7 = '#ff5c57',
    color_8 = '#F2994B',
    color_9 = '#F2AF5C',
    color_10 = '#E6C068',
    color_11 = '#EBCB8B',
    color_12 = '#8fbcbb',
    color_13 = '#F05F4E',
    color_14 = '#0087d7',

    term_0 = '#2E3440',
    term_1 = '#F05F4E',
    term_2 = '#25B8A5',
    term_3 = '#1F8C8C',
    term_4 = '#EBCB8B',
    term_5 = '#83a598',
    term_6 = '#F2994B',
    term_7 = '#00839F',
    term_8 = '#2aa198',
    term_9 = '#F05F4E',
    term_10 = '#25B8A5',
    term_11 = '#1F8C8C',
    term_12 = '#EBCB8B',
    term_13 = '#83a598',
    term_14 = '#F2994B',
    term_15 = '#00839F',

    color_error = '#F05F4E',
    color_warning = '#F2994B',
    color_info = '#56adb7',

    color_add = '#56adb7',
    color_delete = '#F05F4E',
    color_change = '#EBCB8B',
    color_change_delete = '#F2994B',

    -- black = '#252A34',
    black = '#1E222A',
    hl = '#4C566A',

    -- #449dab #0db9d7 #1abc9c #8fbcbb #5e81ac #ffb86c #ebdbb2 
    -- #458588 #83a598 #bf616a #81b88b #6395ec #56b6c2 #98c379  
    -- #f78c6c #ff5370 #ff5c57 #ff8380 #57c7ff #449dab #F07178 
    -- #36A3D9 #4CBF99 #007AFF #008787 #df5f5f #5f8787 #5f87af
    -- #25B8A5 #0088CC #C95F5F #EAC06E #458a8a #56adb7 #2aa198
    -- #2aa198 #CD5C5C #569F7A #0086B3 #1C9898 #2aa889 #33859E
    -- #599cab #b5bd68 #f0c674 #cc517a #3f83a6 #327698 #00af87
    -- #D75F5F #FFAF5F #66d9ae #EC5f67 #62b3b2 #ec5f67 #f99157
    -- #56b6c2 #0997b3 #0087d7 #0087af #00afaf #008EC4 #ff8485
    -- #00a0a0 #d75e5e #5da19f #2aa198 #2aa1ae #20af81 #009ba2
    -- #008EC4 #56b6c2
    none = 'NONE'
}

function lvim.terminal_color()
    vim.g.terminal_color_0 = lvim.term_0
    vim.g.terminal_color_1 = lvim.term_1
    vim.g.terminal_color_2 = lvim.term_2
    vim.g.terminal_color_3 = lvim.term_3
    vim.g.terminal_color_4 = lvim.term_4
    vim.g.terminal_color_5 = lvim.term_5
    vim.g.terminal_color_6 = lvim.term_6
    vim.g.terminal_color_7 = lvim.term_7
    vim.g.terminal_color_8 = lvim.term_8
    vim.g.terminal_color_9 = lvim.term_9
    vim.g.terminal_color_10 = lvim.term_10
    vim.g.terminal_color_11 = lvim.term_11
    vim.g.terminal_color_12 = lvim.term_12
    vim.g.terminal_color_13 = lvim.term_13
    vim.g.terminal_color_14 = lvim.term_14
    vim.g.terminal_color_15 = lvim.term_15
end

function lvim.highlight(group, color)
    local style = color.style and 'gui=' .. color.style or 'gui=NONE'
    local fg = color.fg and 'guifg=' .. color.fg or 'guifg=NONE'
    local bg = color.bg and 'guibg=' .. color.bg or 'guibg=NONE'
    local sp = color.sp and 'guisp=' .. color.sp or ''
    vim.api.nvim_command('highlight ' .. group .. ' ' .. style .. ' ' .. fg ..
                             ' ' .. bg .. ' ' .. sp)
end

function lvim.load_syntax()
    local syntax = {
        Normal = {fg = lvim.fg, bg = lvim.bg},
        Terminal = {fg = lvim.fg, bg = lvim.bg},
        SignColumn = {fg = lvim.fg, bg = lvim.bg},
        FoldColumn = {fg = lvim.color_10, bg = lvim.black},
        VertSplit = {fg = lvim.black, bg = lvim.bg},
        Folded = {fg = lvim.color_12, bg = lvim.bg_highlight},
        EndOfBuffer = {fg = lvim.bg, bg = lvim.none},
        IncSearch = {fg = lvim.base0, bg = lvim.color_13, style = lvim.none},
        Search = {fg = lvim.base0, bg = lvim.color_13},
        ColorColumn = {fg = lvim.none, bg = lvim.bg_highlight},
        Conceal = {fg = lvim.color_12, bg = lvim.none},
        Cursor = {fg = lvim.none, bg = lvim.none, style = 'reverse'},
        vCursor = {fg = lvim.none, bg = lvim.none, style = 'reverse'},
        iCursor = {fg = lvim.none, bg = lvim.none, style = 'reverse'},
        lCursor = {fg = lvim.none, bg = lvim.none, style = 'reverse'},
        CursorIM = {fg = lvim.none, bg = lvim.none, style = 'reverse'},
        CursorColumn = {fg = lvim.none, bg = lvim.bg_highlight},
        CursorLine = {fg = lvim.none, bg = lvim.bg_highlight},
        LineNr = {fg = lvim.hl},
        qfLineNr = {fg = lvim.color_10},
        CursorLineNr = {fg = lvim.color_10},
        DiffAdd = {fg = lvim.black, bg = lvim.color_6},
        DiffChange = {fg = lvim.black, bg = lvim.color_3},
        DiffDelete = {fg = lvim.black, bg = lvim.color_0},
        DiffText = {fg = lvim.black, bg = lvim.fg},
        Directory = {fg = lvim.color_8, bg = lvim.none},
        ErrorMsg = {fg = lvim.color_error, bg = lvim.none},
        WarningMsg = {fg = lvim.color_warning, bg = lvim.NONE},
        ModeMsg = {fg = lvim.color_6, bg = lvim.none},
        FocusedSymbol = {fg = lvim.color_5},
        MatchParen = {fg = lvim.color_0, bg = lvim.none},
        NonText = {fg = lvim.bg1},
        Whitespace = {fg = lvim.base2},
        SpecialKey = {fg = lvim.bg1},
        Pmenu = {fg = lvim.color_10, bg = lvim.base2},
        PmenuSel = {fg = lvim.base0, bg = lvim.color_10},
        PmenuSelBold = {fg = lvim.base0, bg = lvim.color_10},
        PmenuSbar = {fg = lvim.none, bg = lvim.base2},
        PmenuThumb = {fg = lvim.color_9, bg = lvim.color_4},
        WildMenu = {fg = lvim.color_10, bg = lvim.color_5},
        Question = {fg = lvim.color_3},
        NormalFloat = {fg = lvim.bg_visual, bg = lvim.base2},
        Tabline = {fg = lvim.color_10, bg = lvim.none},
        TabLineFill = {style = lvim.none},
        TabLineSel = {fg = lvim.bg1, bg = lvim.none},
        StatusLine = {fg = lvim.color_13, bg = lvim.base2, style = lvim.none},
        StatusLineNC = {fg = lvim.color_12, bg = lvim.base2, style = lvim.none},
        SpellBad = {fg = lvim.color_0, bg = lvim.none, style = 'undercurl'},
        SpellCap = {fg = lvim.color_8, bg = lvim.none, style = 'undercurl'},
        SpellLocal = {fg = lvim.color_7, bg = lvim.none, style = 'undercurl'},
        SpellRare = {fg = lvim.color_9, bg = lvim.none, style = 'undercurl'},
        Visual = {fg = lvim.color_12, bg = lvim.black},
        VisualNOS = {fg = lvim.color_12, bg = lvim.black},
        QuickFixLine = {fg = lvim.color_9},
        Debug = {fg = lvim.color_2},
        debugBreakpoint = {fg = lvim.bg, bg = lvim.color_0},

        Boolean = {fg = lvim.color_2},
        Number = {fg = lvim.color_13},
        Float = {fg = lvim.color_13},
        PreProc = {fg = lvim.color_9},
        PreCondit = {fg = lvim.color_9},
        Include = {fg = lvim.color_9},
        Define = {fg = lvim.color_3},
        Conditional = {fg = lvim.color_5},
        Repeat = {fg = lvim.color_10},
        Keyword = {fg = lvim.color_2},
        Typedef = {fg = lvim.color_0},
        Exception = {fg = lvim.color_0},
        Statement = {fg = lvim.color_0},
        Error = {fg = lvim.color_error},
        StorageClass = {fg = lvim.color_2},
        Tag = {fg = lvim.color_8},
        Label = {fg = lvim.color_2},
        Structure = {fg = lvim.color_2},
        Operator = {fg = lvim.color_5},
        Title = {fg = lvim.color_2},
        Special = {fg = lvim.fg, style = "bold"},
        SpecialChar = {fg = lvim.fg, style = "bold"},
        Type = {fg = lvim.color_11},
        Function = {fg = lvim.color_3},
        String = {fg = lvim.color_4},
        Character = {fg = lvim.color_5},
        Constant = {fg = lvim.color_7},
        Macro = {fg = lvim.color_7},
        Identifier = {fg = lvim.color_8},

        Comment = {fg = lvim.color_6},
        SpecialComment = {fg = lvim.color_6},
        Todo = {fg = lvim.color_6},
        Delimiter = {fg = lvim.color_5},
        Ignore = {fg = lvim.color_12},
        Underlined = {fg = lvim.none, style = 'underline'},

        DashboardShortCut = {fg = lvim.color_10},
        DashboardHeader = {fg = lvim.color_0},
        DashboardCenter = {fg = lvim.color_7},
        DashboardFooter = {fg = lvim.color_5},

        Repeat = {fg = lvim.color_9}

    }
    return syntax
end

function lvim.load_plugin_syntax()
    local plugin_syntax = {

        TSAnnotation = {fg = lvim.color_0},
        TSAttribute = {fg = lvim.color_1},
        TSBoolean = {fg = lvim.color_2},
        TSCharacter = {fg = lvim.color_3},
        TSConditional = {fg = lvim.color_4},
        TSConstant = {fg = lvim.color_5},
        TSEmphasis = {fg = lvim.color_6},
        TSError = {fg = lvim.color_7},
        TSException = {fg = lvim.color_8},
        TSField = {fg = lvim.color_9},
        TSFloat = {fg = lvim.color_10},
        TSFuncBuiltin = {fg = lvim.color_12},
        TSFuncMacro = {fg = lvim.color_12},
        TSKeywordFunction = {fg = lvim.color_0},
        TSLiteral = {fg = lvim.color_10},
        TSNamespace = {fg = lvim.color_0},
        TSNumber = {fg = lvim.color_1},
        TSParameterReference = {fg = lvim.color_2},
        TSPunctSpecial = {fg = lvim.color_3},
        TSRepeat = {fg = lvim.color_4},
        TSString = {fg = lvim.color_5},
        TSStringEscape = {fg = lvim.color_6},
        TSStringRegex = {fg = lvim.color_7},
        TSStrong = {fg = lvim.color_8},
        TSStructure = {fg = lvim.color_9},
        TSText = {fg = lvim.color_10},
        TSTitle = {fg = lvim.color_11},
        TSTypeBuiltin = {fg = lvim.color_12},
        TSUnderline = {fg = lvim.color_13},
        TSURI = {fg = lvim.color_10},
        TSInclude = {fg = lvim.color_0},
        TSPunctBracket = {fg = lvim.color_12},
        TSPunctDelimiter = {fg = lvim.color_2},
        TSParameter = {fg = lvim.color_3},
        TSType = {fg = lvim.color_11},
        TSFunction = {fg = lvim.color_9},
        TSTagDelimiter = {fg = lvim.color_6},
        TSProperty = {fg = lvim.color_3},
        TSMethod = {fg = lvim.color_1},
        TSParameter = {fg = lvim.color_9},
        TSConstructor = {fg = lvim.color_10},
        TSVariable = {fg = lvim.color_2},
        TSOperator = {fg = lvim.color_12},
        TSKeyword = {fg = lvim.color_0},
        TSVariableBuiltin = {fg = lvim.color_10},
        TSTag = {fg = lvim.color_0},
        TSLabel = {fg = lvim.color_1},

        vimCommentTitle = {fg = lvim.color_12},
        vimLet = {fg = lvim.color_2},
        vimVar = {fg = lvim.color_7},
        vimFunction = {fg = lvim.color_1},
        vimIsCommand = {fg = lvim.fg},
        vimCommand = {fg = lvim.color_8},
        vimNotFunc = {fg = lvim.color_9},
        vimUserFunc = {fg = lvim.color_3},
        vimFuncName = {fg = lvim.color_3},

        diffAdded = {fg = lvim.color_add},
        diffRemoved = {fg = lvim.color_delete},
        diffChanged = {fg = lvim.color_change},
        diffOldFile = {fg = lvim.color_3},
        diffNewFile = {fg = lvim.color_2},
        diffFile = {fg = lvim.color_7},
        diffLine = {fg = lvim.color_12},
        diffIndexLine = {fg = lvim.color_9},

        gitcommitSummary = {fg = lvim.color_0},
        gitcommitUntracked = {fg = lvim.color_12},
        gitcommitDiscarded = {fg = lvim.color_12},
        gitcommitSelected = {fg = lvim.color_12},
        gitcommitUnmerged = {fg = lvim.color_12},
        gitcommitOnBranch = {fg = lvim.color_12},
        gitcommitArrow = {fg = lvim.color_12},
        gitcommitFile = {fg = lvim.color_6},

        NeogitBranch = {fg = lvim.color_6},
        NeogitRemote = {fg = lvim.color_6},
        NeogitHunkHeader = {fg = lvim.color_0, bg = lvim.black},
        NeogitHunkHeaderHighlight = {fg = lvim.color_0, bg = lvim.black},
        NeogitDiffContextHighlight = {fg = lvim.color_add, bg = lvim.black},
        NeogitDiffDeleteHighlight = {fg = lvim.color_delete, bg = lvim.black},
        NeogitDiffAddHighlight = {fg = lvim.color_add, bg = lvim.black},
        NeogitDiffAdd = {fg = lvim.color_add, bg = lvim.black},
        NeogitDiffDelete = {fg = lvim.color_delete, bg = lvim.black},

        VistaBracket = {fg = lvim.color_12},
        VistaChildrenNr = {fg = lvim.color_8},
        VistaKind = {fg = lvim.color_9},
        VistaScope = {fg = lvim.color_0},
        VistaScopeKind = {fg = lvim.color_8},
        VistaTag = {fg = lvim.color_9},
        VistaPrefix = {fg = lvim.color_12},
        VistaColon = {fg = lvim.color_9},
        VistaIcon = {fg = lvim.color_3},
        VistaLineNr = {fg = lvim.fg},

        GitGutterAdd = {fg = lvim.color_add},
        GitGutterChange = {fg = lvim.color_change},
        GitGutterDelete = {fg = lvim.color_delete},
        GitGutterChangeDelete = {fg = lvim.color_change_delete},

        GitSignsAdd = {fg = lvim.color_add},
        GitSignsChange = {fg = lvim.color_change},
        GitSignsDelete = {fg = lvim.color_delete},
        GitSignsAddNr = {fg = lvim.color_add},
        GitSignsChangeNr = {fg = lvim.color_change},
        GitSignsDeleteNr = {fg = lvim.color_delete},
        GitSignsAddLn = {fg = lvim.color_add},
        GitSignsChangeLn = {fg = lvim.color_change},
        GitSignsDeleteLn = {fg = lvim.color_delete},

        SignifySignAdd = {fg = lvim.color_add},
        SignifySignChange = {fg = lvim.color_change},
        SignifySignDelete = {fg = lvim.color_delete},

        dbui_tables = {fg = lvim.color_8},

        LspDiagnosticsSignError = {fg = lvim.color_error},
        LspDiagnosticsSignWarning = {fg = lvim.color_warning},
        LspDiagnosticsSignInformation = {fg = lvim.color_info},
        LspDiagnosticsSignHint = {fg = lvim.color_info},

        LspDiagnosticsVirtualTextError = {fg = lvim.color_error},
        LspDiagnosticsVirtualTextWarning = {fg = lvim.color_warning},
        LspDiagnosticsVirtualTextInformation = {fg = lvim.color_info},
        LspDiagnosticsVirtualTextHint = {fg = lvim.color_info},

        LspDiagnosticsUnderlineError = {
            style = "undercurl",
            sp = lvim.color_error
        },
        LspDiagnosticsUnderlineWarning = {
            style = "undercurl",
            sp = lvim.color_warning
        },
        LspDiagnosticsUnderlineInformation = {
            style = "undercurl",
            sp = lvim.color_info
        },
        LspDiagnosticsUnderlineHint = {
            style = "undercurl",
            sp = lvim.color_info
        },

        LvimHelperNormal = {fg = lvim.color_6, bg = lvim.base2},
        LvimHelperTitle = {fg = lvim.bg, bg = lvim.color_3},

        NvimTreeNormal = {bg = lvim.base2},
        NvimTreeFolderName = {fg = lvim.color_4},
        NvimTreeOpenedFolderName = {fg = lvim.color_11},
        NvimTreeEmptyFolderName = {fg = lvim.color_4},
        NvimTreeRootFolder = {fg = lvim.color_4},
        NvimTreeSpecialFile = {fg = lvim.fg, bg = lvim.none, stryle = 'NONE'},
        NvimTreeFolderIcon = {fg = lvim.color_4},
        NvimTreeIndentMarker = {fg = lvim.hl},
        NvimTreeSignError = {fg = lvim.color_error},
        NvimTreeSignWarning = {fg = lvim.color_warning},
        NvimTreeSignInformation = {fg = lvim.color_info},
        NvimTreeSignHint = {fg = lvim.color_info},
        NvimTreeLspDiagnosticsError = {fg = lvim.color_error},
        NvimTreeLspDiagnosticsWarning = {fg = lvim.color_warning},
        NvimTreeLspDiagnosticsInformation = {fg = lvim.color_info},
        NvimTreeLspDiagnosticsHint = {fg = lvim.color_info},
        NvimTreeWindowPicker = {gui = 'bold', fg = lvim.bg, bg = lvim.color_11},

        TelescopeBorder = {fg = lvim.color_11},
        TelescopePromptBorder = {fg = lvim.color_3},
        TelescopeMatching = {fg = lvim.color_11},
        TelescopeSelection = {fg = lvim.color_3, bg = lvim.bg_highlight},
        TelescopeSelectionCaret = {fg = lvim.color_3},
        TelescopeMultiSelection = {fg = lvim.color_11},

        Floaterm = {fg = lvim.color_9},
        FloatermBorder = {fg = lvim.color_11},

        BufferCurrent = {fg = lvim.color_8},
        BufferCurrentIndex = {fg = lvim.color_8},
        BufferCurrentMod = {fg = lvim.color_8},
        BufferCurrentSign = {fg = lvim.fg},
        BufferCurrentTarget = {fg = lvim.color_8},

        BufferVisible = {fg = lvim.color_3},
        BufferVisibleIndex = {fg = lvim.color_3},
        BufferVisibleMod = {fg = lvim.color_3},
        BufferVisibleSign = {fg = lvim.fg},
        BufferVisibleTarget = {fg = lvim.color_3},

        BufferInactive = {fg = lvim.color_3},
        BufferInactiveIndex = {fg = lvim.color_3},
        BufferInactiveMod = {fg = lvim.color_3},
        BufferInactiveSign = {fg = lvim.fg},
        BufferInactiveTarget = {fg = lvim.color_3},

        BufferTabpages = {fg = lvim.none},
        BufferTabpageFill = {fg = lvim.none},

        BufferCurrentIcon = {fg = lvim.color_3},
        BufferVisibleIcon = {fg = lvim.color_3},
        BufferInactiveIcon = {fg = lvim.color_3},

        IndentBlanklineChar = {fg = lvim.hl, bg = lvim.none},
        IndentBlanklineSpaceCharBlankline = {fg = lvim.color_1, bg = lvim.none},
        IndentBlanklineContextChar = {fg = lvim.color_1, bg = lvim.none},
        IndentBlanklineContextChar = {fg = lvim.color_1, bg = lvim.none},

        ClapDir = {fg = lvim.color_4, bg = lvim.bg},
        ClapFile = {fg = lvim.color_4, bg = lvim.bg},
        ClapCurrentSelection = {fg = lvim.color_8, bg = lvim.bg},
        ClapCurrentSelectionSign = {fg = lvim.color_8, bg = lvim.bg},
        ClapInput = {fg = lvim.fg, bg = lvim.bg},
        ClapSpinner = {fg = lvim.fg, bg = lvim.bg},
        ClapSearchText = {fg = lvim.color_4, bg = lvim.bg},
        ClapPreview = {fg = lvim.fg, bg = lvim.bg},
        ClapSelected = {fg = lvim.fg, bg = lvim.bg},
        ClapSelectedSign = {fg = lvim.fg, bg = lvim.bg},

        VimwikiHeader1 = {fg = lvim.color_1},
        VimwikiHeader2 = {fg = lvim.color_4},
        VimwikiHeader3 = {fg = lvim.color_5},
        VimwikiHeader4 = {fg = lvim.color_2},
        VimwikiHeader5 = {fg = lvim.color_3},
        VimwikiHeader6 = {fg = lvim.color_9},
        VimwikiLink = {fg = lvim.color_14},
        VimwikiHeaderChar = {fg = lvim.color_6},
        VimwikiHR = {fg = lvim.color_12},
        VimwikiList = {fg = lvim.color_13},
        VimwikiTag = {fg = lvim.color_1}
    }
    return plugin_syntax
end

local async_load_plugin

async_load_plugin = vim.loop.new_async(vim.schedule_wrap(function()
    lvim.terminal_color()
    local syntax = lvim.load_plugin_syntax()
    for group, colors in pairs(syntax) do lvim.highlight(group, colors) end
    async_load_plugin:close()
end))

function lvim.colorscheme()
    vim.api.nvim_command('hi clear')
    if vim.fn.exists('syntax_on') then vim.api.nvim_command('syntax reset') end
    vim.o.background = 'dark'
    vim.o.termguicolors = true
    vim.g.colors_name = 'lvim'
    local syntax = lvim.load_syntax()
    for group, colors in pairs(syntax) do lvim.highlight(group, colors) end
    async_load_plugin:send()
end

lvim.colorscheme()

return lvim
