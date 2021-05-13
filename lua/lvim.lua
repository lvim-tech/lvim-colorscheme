-- Theme: lvim
-- Author: lvim-org
-- License: BSD 3-Clause License
-- Source: https://github.com/lvim-org/lvim-colorscheme
local lvim = {
    base0 = '#242424',
    base1 = '#303030',
    base2 = '#343434',

    bg = '#282828',
    bg1 = '#F2CA7E',
    bg_highlight = '#242424',
    bg_visual = '#F2CA7E',

    fg = '#00839F',
    color_0 = '#008080',
    color_1 = '#007CDC',
    color_2 = '#E0AF69',
    color_3 = '#39A291',
    color_4 = '#2E96B5',
    color_5 = '#F2CA7E',
    color_6 = '#83a598',
    color_7 = '#F05F4E',
    color_8 = '#E7BC74',
    color_9 = '#F2994B',
    color_10 = '#F2594B',
    color_11 = '#006BC6',
    color_12 = '#7ABF85',
    color_13 = '#1F8C8C',
    black = '#181818',
    none = 'NONE'
}

function lvim.terminal_color()
    vim.g.terminal_color_0 = lvim.base2
    vim.g.terminal_color_1 = lvim.color_10
    vim.g.terminal_color_2 = lvim.color_3
    vim.g.terminal_color_3 = lvim.color_13
    vim.g.terminal_color_4 = lvim.color_8
    vim.g.terminal_color_5 = lvim.color_6
    vim.g.terminal_color_6 = lvim.color_9
    vim.g.terminal_color_7 = lvim.fg
    vim.g.terminal_color_8 = lvim.color_3
    vim.g.terminal_color_9 = lvim.color_10
    vim.g.terminal_color_10 = lvim.color_3
    vim.g.terminal_color_11 = lvim.color_13
    vim.g.terminal_color_12 = lvim.color_8
    vim.g.terminal_color_13 = lvim.color_6
    vim.g.terminal_color_14 = lvim.color_9
    vim.g.terminal_color_15 = lvim.fg
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
        LineNr = {fg = lvim.color_13},
        qfLineNr = {fg = lvim.color_7},
        CursorLineNr = {fg = lvim.color_8},
        DiffAdd = {fg = lvim.black, bg = lvim.color_6},
        DiffChange = {fg = lvim.black, bg = lvim.color_3},
        DiffDelete = {fg = lvim.black, bg = lvim.color_0},
        DiffText = {fg = lvim.black, bg = lvim.fg},
        Directory = {fg = lvim.color_8, bg = lvim.none},
        ErrorMsg = {fg = lvim.color_10, bg = lvim.none},
        WarningMsg = {fg = lvim.color_9, bg = lvim.NONE},
        ModeMsg = {fg = lvim.color_6, bg = lvim.none},
        FocusedSymbol = {fg = lvim.color_5},
        MatchParen = {fg = lvim.color_0, bg = lvim.none},
        NonText = {fg = lvim.bg1},
        Whitespace = {fg = lvim.base2},
        SpecialKey = {fg = lvim.bg1},
        Pmenu = {fg = lvim.fg, bg = lvim.base2},
        PmenuSel = {fg = lvim.base0, bg = lvim.color_8},
        PmenuSelBold = {fg = lvim.base0, g = lvim.color_8},
        PmenuSbar = {fg = lvim.none, bg = lvim.base2},
        PmenuThumb = {fg = lvim.color_9, bg = lvim.color_4},
        WildMenu = {fg = lvim.fg, bg = lvim.color_5},
        Question = {fg = lvim.color_3},
        NormalFloat = {fg = lvim.bg_visual, bg = lvim.none},
        Tabline = {fg = lvim.fg, bg = lvim.none},
        TabLineFill = {style = lvim.none},
        TabLineSel = {fg = lvim.bg1, bg = lvim.none},
        StatusLine = {fg = lvim.color_13, bg = lvim.base1, style = lvim.none},
        StatusLineNC = {fg = lvim.color_12, bg = lvim.base1, style = lvim.none},
        SpellBad = {fg = lvim.color_0, bg = lvim.none, style = 'undercurl'},
        SpellCap = {fg = lvim.color_8, bg = lvim.none, style = 'undercurl'},
        SpellLocal = {fg = lvim.color_7, bg = lvim.none, style = 'undercurl'},
        SpellRare = {fg = lvim.color_9, bg = lvim.none, style = 'undercurl'},
        Visual = {fg = lvim.color_8, bg = lvim.color_13},
        VisualNOS = {fg = lvim.color_8, bg = lvim.color_13},
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
        Keyword = {fg = lvim.color_8},
        Typedef = {fg = lvim.color_0},
        Exception = {fg = lvim.color_0},
        Statement = {fg = lvim.color_0},
        Error = {fg = lvim.color_10},
        StorageClass = {fg = lvim.color_2},
        Tag = {fg = lvim.color_8},
        Label = {fg = lvim.color_2},
        Structure = {fg = lvim.color_2},
        Operator = {fg = lvim.color_5},
        Title = {fg = lvim.color_2},
        Special = {fg = lvim.color_3},
        SpecialChar = {fg = lvim.color_3},
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
        Delimiter = {fg = lvim.fg},
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
        TSFunction = {fg = lvim.color_7},
        TSMethod = {fg = lvim.color_7},
        TSKeywordFunction = {fg = lvim.color_0},
        TSProperty = {fg = lvim.color_3},
        TSType = {fg = lvim.color_11},
        TSPunctBracket = {fg = lvim.color_12},

        vimCommentTitle = {fg = lvim.color_12},
        vimLet = {fg = lvim.color_2},
        vimVar = {fg = lvim.color_7},
        vimFunction = {fg = lvim.color_1},
        vimIsCommand = {fg = lvim.fg},
        vimCommand = {fg = lvim.color_8},
        vimNotFunc = {fg = lvim.color_9},
        vimUserFunc = {fg = lvim.color_3},
        vimFuncName = {fg = lvim.color_3},

        diffAdded = {fg = lvim.color_3},
        diffRemoved = {fg = lvim.color_10},
        diffChanged = {fg = lvim.color_9},
        diffOldFile = {fg = lvim.color_3},
        diffNewFile = {fg = lvim.color_2},
        diffFile = {fg = lvim.aqua},
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

        GitGutterAdd = {fg = lvim.color_6},
        GitGutterChange = {fg = lvim.color_8},
        GitGutterDelete = {fg = lvim.color_0},
        GitGutterChangeDelete = {fg = lvim.color_9},

        GitSignsAdd = {fg = lvim.color_3},
        GitSignsChange = {fg = lvim.color_9},
        GitSignsDelete = {fg = lvim.color_10},
        GitSignsAddNr = {fg = lvim.color_3},
        GitSignsChangeNr = {fg = lvim.color_9},
        GitSignsDeleteNr = {fg = lvim.color_10},
        GitSignsAddLn = {fg = lvim.color_3},
        GitSignsChangeLn = {fg = lvim.color_9},
        GitSignsDeleteLn = {fg = lvim.color_10},

        SignifySignAdd = {fg = lvim.color_6},
        SignifySignChange = {fg = lvim.color_8},
        SignifySignDelete = {fg = lvim.color_0},

        dbui_tables = {fg = lvim.color_8},

        LspDiagnosticsSignError = {fg = lvim.color_10},
        LspDiagnosticsSignWarning = {fg = lvim.color_9},
        LspDiagnosticsSignInformation = {fg = lvim.color_6},
        LspDiagnosticsSignHint = {fg = lvim.color_9},

        LspDiagnosticsVirtualTextError = {fg = lvim.color_10},
        LspDiagnosticsVirtualTextWarning = {fg = lvim.color_9},
        LspDiagnosticsVirtualTextInformation = {fg = lvim.color_6},
        LspDiagnosticsVirtualTextHint = {fg = lvim.color_9},

        LspDiagnosticsUnderlineError = {style = "undercurl", sp = lvim.color_10},
        LspDiagnosticsUnderlineWarning = {
            style = "undercurl",
            sp = lvim.color_9
        },
        LspDiagnosticsUnderlineInformation = {
            style = "undercurl",
            sp = lvim.color_6
        },
        LspDiagnosticsUnderlineHint = {style = "undercurl", sp = lvim.color_9},

        NvimTreeFolderName = {fg = lvim.color_13},
        NvimTreeEmptyFolderName = {fg = lvim.color_13},
        NvimTreeRootFolder = {fg = lvim.color_0},
        NvimTreeSpecialFile = {fg = lvim.fg, bg = lvim.none, stryle = 'NONE'},
        NvimTreeFolderIcon = {fg = lvim.color_13},
        NvimTreeIndentMarker = {fg = lvim.color_13},
        NvimTreeSignError = {fg = lvim.color_10},
        NvimTreeSignWarning = {fg = lvim.color_9},
        NvimTreeSignInformation = {fg = lvim.color_6},
        NvimTreeSignHint = {fg = lvim.color_9},
        NvimTreeLspDiagnosticsError = {fg = lvim.color_10},
        NvimTreeLspDiagnosticsWarning = {fg = lvim.color_9},
        NvimTreeLspDiagnosticsInformation = {fg = lvim.color_6},
        NvimTreeLspDiagnosticsHint = {fg = lvim.color_9},

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
        BufferTabpageFill = {fg = lvim.none}

        -- BufferCurrentIcon = {fg = lvim.color_3},
        -- BufferCurrent = {fg = lvim.color_3},
        -- BufferVisibleIcon = {fg = lvim.color_3},
        -- BufferVisible = {fg = lvim.color_3},
        -- BufferInactiveIcon = {fg = lvim.color_3},
        -- BufferInactive = {fg = lvim.color_3}

        -- BufferInactive = {fg = lvim.color_4}
    }
    return plugin_syntax
end

local async_load_plugin

async_load_plugin = vim.loop.new_async(vim.schedule_wrap(
                                           function()
        lvim.terminal_color()
        local syntax = lvim.load_plugin_syntax()
        for group, colors in pairs(syntax) do
            lvim.highlight(group, colors)
        end
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
