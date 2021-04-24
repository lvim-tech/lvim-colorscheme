-- Theme: lvim
-- Author: lvim-org
-- License: BSD 3-Clause License
-- Source: https://github.com/lvim-org/lvim-colorscheme
local lvim = {
    base0 = '#242424',
    base1 = '#282828',
    base2 = '#32302f',
    base3 = '#3c3836',
    base4 = '#504945',
    base5 = '#665c54',
    base6 = '#7c6f64',
    base7 = '#7c6f64',
    base8 = '#7c6f64',

    bg = '#282828',
    bg1 = '#d5c4a1',
    bg_popup = '#3c3836',
    bg_highlight = '#242424',
    bg_visual = '#bdae93',

    fg = '#83a598',
    fg_alt = '#665c54',
    color_0 = '#006BC6',
    color_1 = '#007CDC',
    color_2 = '#3E75C7',
    color_3 = '#00839F',
    color_4 = '#2E96B5',
    color_5 = '#689d6a',
    color_6 = '#83a598',
    color_7 = '#a7c080',
    color_8 = '#d5c4a1',
    color_9 = '#E6B673',
    color_10 = '#F2594B',
    color_11 = '#006BC6',
    color_12 = '#e69875',
    color_13 = '#61776f',
    black = '#242424',
    none = 'NONE'
}

function lvim.terminal_color()
    vim.g.terminal_color_0 = lvim.bg
    vim.g.terminal_color_1 = lvim.color_0
    vim.g.terminal_color_2 = lvim.color_5
    vim.g.terminal_color_3 = lvim.color_3
    vim.g.terminal_color_4 = lvim.color_8
    vim.g.terminal_color_5 = lvim.color_9
    vim.g.terminal_color_6 = lvim.color_7
    vim.g.terminal_color_7 = lvim.bg1
    vim.g.terminal_color_8 = lvim.color_13
    vim.g.terminal_color_9 = lvim.color_0
    vim.g.terminal_color_10 = lvim.color_5
    vim.g.terminal_color_11 = lvim.color_3
    vim.g.terminal_color_12 = lvim.color_8
    vim.g.terminal_color_13 = lvim.color_9
    vim.g.terminal_color_14 = lvim.color_7
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
        FoldColumn = {fg = lvim.fg_alt, bg = lvim.black},
        VertSplit = {fg = lvim.black, bg = lvim.bg},
        Folded = {fg = lvim.color_12, bg = lvim.bg_highlight},
        EndOfBuffer = {fg = lvim.bg, bg = lvim.none},
        IncSearch = {fg = lvim.bg1, bg = lvim.color_11, style = lvim.none},
        Search = {fg = lvim.bg1, bg = lvim.color_11},
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
        ErrorMsg = {fg = lvim.color_10, bg = lvim.none, style = 'bold'},
        WarningMsg = {fg = lvim.color_9, bg = lvim.none, style = 'bold'},
        ModeMsg = {fg = lvim.color_6, bg = lvim.none, style = 'bold'},
        FocusedSymbol = {bg = lvim.color_0, fg = lvim.color_8},
        MatchParen = {fg = lvim.color_0, bg = lvim.none},
        NonText = {fg = lvim.bg1},
        Whitespace = {fg = lvim.base4},
        SpecialKey = {fg = lvim.bg1},
        Pmenu = {fg = lvim.fg, bg = lvim.bg_popup},
        PmenuSel = {fg = lvim.base0, bg = lvim.color_8},
        PmenuSelBold = {fg = lvim.base0, g = lvim.color_8},
        PmenuSbar = {fg = lvim.none, bg = lvim.base4},
        PmenuThumb = {fg = lvim.color_9, bg = lvim.color_4},
        WildMenu = {fg = lvim.fg, bg = lvim.color_5},
        Question = {fg = lvim.color_3},
        NormalFloat = {fg = lvim.base8, bg = lvim.bg_highlight},
        Tabline = {fg = lvim.base6, bg = lvim.base2},
        TabLineFill = {style = lvim.none},
        TabLineSel = {fg = lvim.fg, bg = lvim.none},
        StatusLine = {fg = lvim.base8, bg = lvim.base2, style = lvim.none},
        StatusLineNC = {fg = lvim.color_12, bg = lvim.base2, style = lvim.none},
        SpellBad = {fg = lvim.color_0, bg = lvim.none, style = 'undercurl'},
        SpellCap = {fg = lvim.color_8, bg = lvim.none, style = 'undercurl'},
        SpellLocal = {fg = lvim.color_7, bg = lvim.none, style = 'undercurl'},
        SpellRare = {fg = lvim.color_9, bg = lvim.none, style = 'undercurl'},
        Visual = {fg = lvim.black, bg = lvim.bg_visual},
        VisualNOS = {fg = lvim.black, bg = lvim.bg_visual},
        QuickFixLine = {fg = lvim.color_9, style = 'bold'},
        Debug = {fg = lvim.color_2},
        debugBreakpoint = {fg = lvim.bg, bg = lvim.color_0},

        Boolean = {fg = lvim.color_2},
        Number = {fg = lvim.color_13},
        Float = {fg = lvim.color_13},
        PreProc = {fg = lvim.color_9},
        PreCondit = {fg = lvim.color_9},
        Include = {fg = lvim.color_9},
        Define = {fg = lvim.color_9},
        Conditional = {fg = lvim.color_10},
        Repeat = {fg = lvim.color_10},
        Keyword = {fg = lvim.color_5},
        Typedef = {fg = lvim.color_0},
        Exception = {fg = lvim.color_0},
        Statement = {fg = lvim.color_0},
        Error = {fg = lvim.color_10},
        StorageClass = {fg = lvim.color_2},
        Tag = {fg = lvim.color_2},
        Label = {fg = lvim.color_2},
        Structure = {fg = lvim.color_2},
        Operator = {fg = lvim.color_1},
        Title = {fg = lvim.color_2, style = 'bold'},
        Special = {fg = lvim.color_3},
        SpecialChar = {fg = lvim.color_3},
        Type = {fg = lvim.color_11},
        Function = {fg = lvim.color_3},
        String = {fg = lvim.color_4},
        Character = {fg = lvim.color_5},
        Constant = {fg = lvim.color_7},
        Macro = {fg = lvim.color_7},
        Identifier = {fg = lvim.color_8},

        Comment = {fg = lvim.color_13},
        SpecialComment = {fg = lvim.color_13},
        Todo = {fg = lvim.color_13},
        Delimiter = {fg = lvim.fg},
        Ignore = {fg = lvim.color_12},
        Underlined = {fg = lvim.none, style = 'underline'},

        DashboardShortCut = {fg = lvim.color_10},
        DashboardHeader = {fg = lvim.color_2},
        DashboardCenter = {fg = lvim.color_7},
        DashboardFooter = {fg = lvim.color_3, style = 'bold'}
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

        vimCommentTitle = {fg = lvim.color_12, style = 'bold'},
        vimLet = {fg = lvim.color_2},
        vimVar = {fg = lvim.color_7},
        vimFunction = {fg = lvim.color_1},
        vimIsCommand = {fg = lvim.fg},
        vimCommand = {fg = lvim.color_8},
        vimNotFunc = {fg = lvim.color_9, style = 'bold'},
        vimUserFunc = {fg = lvim.color_3, style = 'bold'},
        vimFuncName = {fg = lvim.color_3, style = 'bold'},

        diffAdded = {fg = lvim.color_6},
        diffRemoved = {fg = lvim.color_0},
        diffChanged = {fg = lvim.color_8},
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
        VistaTag = {fg = lvim.color_9, style = 'bold'},
        VistaPrefix = {fg = lvim.color_12},
        VistaColon = {fg = lvim.color_9},
        VistaIcon = {fg = lvim.color_3},
        VistaLineNr = {fg = lvim.fg},

        GitGutterAdd = {fg = lvim.color_6},
        GitGutterChange = {fg = lvim.color_8},
        GitGutterDelete = {fg = lvim.color_0},
        GitGutterChangeDelete = {fg = lvim.color_9},

        GitSignsAdd = {fg = lvim.color_6},
        GitSignsChange = {fg = lvim.color_8},
        GitSignsDelete = {fg = lvim.color_0},
        GitSignsAddNr = {fg = lvim.color_6},
        GitSignsChangeNr = {fg = lvim.color_8},
        GitSignsDeleteNr = {fg = lvim.color_0},
        GitSignsAddLn = {bg = lvim.bg_popup},
        GitSignsChangeLn = {bg = lvim.bg_highlight},
        GitSignsDeleteLn = {bg = lvim.bg1},

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

        NvimTreeFolderName = {fg = lvim.color_4},
        NvimTreeEmptyFolderName = {fg = lvim.color_4},
        NvimTreeRootFolder = {fg = lvim.color_0, style = 'bold'},
        NvimTreeSpecialFile = {fg = lvim.fg, bg = lvim.none, stryle = 'NONE'},
        NvimTreeFolderIcon = {fg = lvim.color_4},
        NvimTreeIndentMarker = {fg = lvim.color_4},
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
        TelescopeSelection = {
            fg = lvim.color_3,
            bg = lvim.bg_highlight,
            style = 'bold'
        },
        TelescopeSelectionCaret = {fg = lvim.color_3},
        TelescopeMultiSelection = {fg = lvim.color_11},

        Floaterm = {fg = lvim.color_9},
        FloatermBorder = {fg = lvim.color_11}
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
