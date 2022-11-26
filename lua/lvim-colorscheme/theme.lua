local config = require("lvim-colorscheme.config")

local M = {}

M.setup = function(colors)
    local c = colors
    local highlights = {
        Boolean = { fg = c.blue_01 },
        Character = { fg = c.fg_01 },
        Comment = { fg = c.fg_03, style = config.styles.comments },
        Conditional = { fg = c.orange_01 }, -- fix
        Constant = { fg = c.green_02 },
        Constructor = { fg = c.teal_01 },
        Danger = { fg = c.bg_03 },
        Debug = { fg = c.green_02 }, -- fix
        Define = { fg = c.blue_01 }, -- fix
        Delimiter = { fg = c.orange_01 },
        Exception = { fg = c.green_03 },
        Field = { fg = c.orange_03 },
        Float = { fg = c.cyan_02 },
        FuncBuiltin = { fg = c.green_01 },
        Function = { fg = c.red_02, style = config.styles.functions },
        Identifier = { fg = c.green_02, style = config.styles.variables },
        Include = { fg = c.blue_03 },
        Keyword = { fg = c.green_01, style = config.styles.keywords },
        KeywordFunction = { fg = c.cyan_02, style = config.styles.keywords },
        Label = { fg = c.blue_03 },
        Macro = { fg = c.teal_01 },
        Note = { fg = c.fg_03 },
        Number = { fg = c.green_03 },
        Operator = { fg = c.orange_01, style = "bold" },
        Parameter = { fg = c.fg_06 },
        PreProc = { fg = c.teal_03 },
        Property = { fg = c.blue_03 },
        Repeat = { fg = c.red_01 }, -- fix
        Special = { fg = c.green_01 },
        SpecialChar = { fg = c.teal_02 }, -- fix
        SpecialComment = { fg = c.fg_03, style = config.styles.comments }, -- fix
        StorageClass = { fg = c.red_01 }, -- fix
        String = { fg = c.fg_04 },
        StringEscape = { fg = c.orange_02 },
        StringRegex = { fg = c.blue_03 },
        Structure = { fg = c.red_02 },
        Tag = { fg = c.green_01 },
        TextReference = { fg = c.teal_01 },
        Title = { fg = c.green_01, style = "bold" },
        Todo = { fg = c.orange_01 },
        Type = { fg = c.orange_01 },
        Typedef = { fg = c.red_03 },
        Variable = { fg = c.fg_06, style = config.styles.variables },
        VariableBuiltin = { fg = c.blue_03 },
        Directory = { fg = c.orange_01 },
        --
        ErrorMsg = { fg = c.none },
        WarningMsg = { fg = c.none },
        Error = { fg = c.none },
        Warning = { bg = c.none },
        -- ModeMsg = { bg = c.none, fg = c.color_16, style = "bold" },
        -- MoreMsg = { fg = c.color_13 },
        -- MsgArea = { fg = c.color_16 },
        --
        Normal = { bg = c.bg_01, fg = c.fg_02 },
        NormalNC = { bg = c.bg_03, fg = c.fg_02 },
        NormalSB = { bg = c.bg_sidebar, fg = c.fg_02 },
        NormalFloat = { bg = c.bg_float, fg = c.fg_02 },
        FloatBorder = { bg = c.bg_float, fg = c.bg_float },
        SideBar = { bg = c.bg_sidebar, fg = c.fg_02 },
        SideBarNC = { bg = c.bg_sidebar, fg = c.fg_02 },
        Pmenu = { bg = c.bg_sidebar, fg = c.orange_03 },
        PmenuSbar = { bg = c.bg_sidebar },
        PmenuSel = { bg = c.bg_03, fg = c.orange_03 },
        PmenuThumb = { bg = c.orange_03 },
        StatusLine = { bg = c.bg_statusline, fg = c.fg_01 },
        StatusLineNC = { bg = c.bg_statusline, fg = c.bg_statusline },
        Winbar = { bg = c.bg_statusline, fg = c.fg_02 },
        CursorLine = { bg = c.bg_03 },
        LineNr = { fg = c.bg_06 },
        CursorLineNr = { fg = c.green_02, style = "bold" },
        ColorColumn = { bg = c.bg_04 },
        Conceal = { fg = c.fg_02 },
        Cursor = { bg = c.orange_02, fg = c.none },
        CursorIM = { bg = c.orange_02, fg = c.none },
        lCursor = { bg = c.orange_02, fg = c.none },
        CursorColumn = { bg = c.bg_04 },
        EndOfBuffer = { fg = c.bg_03 },
        Underlined = { sp = c.blue_01, style = "undercurl" },
        Visual = { bg = c.bg_visual },
        VisualNOS = { bg = c.bg_visual },
        TabLine = { bg = c.bg_statusline, fg = c.green_02, style = "bold" },
        TabLineFill = { bg = c.bg_statusline },
        TabLineSel = { bg = c.bg_statusline, fg = c.green_02 },
        VertSplit = { bg = c.bg_01, fg = c.bg_01 },
        SignColumn = { bg = c.none },
        SignColumnSB = { bg = c.bg_sidebar },
        FoldColumn = { bg = c.none, fg = c.fg_02 },
        Folded = { bg = c.none, fg = c.fg_02 },
        MatchParen = { fg = c.orange_03, style = "bold" },
        Substitute = { bg = c.red_01, fg = c.bg_01 },
        FocusedSymbol = { bg = c.none, style = "bold" },
        Replace = { bg = c.bg_search, fg = c.red_01 },
        Search = { bg = c.bg_search, fg = c.green_01 },
        SpellBad = { sp = c.error, style = "undercurl" },
        SpellCap = { sp = c.warning, style = "undercurl" },
        SpellLocal = { sp = c.info, style = "undercurl" },
        SpellRare = { sp = c.hint, style = "undercurl" },
        QuickFixLine = { bg = c.bg_03, style = "bold" },
        qfFileName = { fg = c.orange_02 },
        qfLineNr = { fg = c.green_01 },
        healthError = { fg = c.error },
        healthSuccess = { fg = c.success },
        healthWarning = { fg = c.warning },
        IncSearch = { bg = c.bg_search, fg = c.green_01, style = "bold" },
        Question = { fg = c.blue_01 },
        NonText = { fg = c.bg_04 },
        SpecialKey = { fg = c.bg_04 },
        Statement = { fg = c.orange_02 },
        Whitespace = { fg = c.bg_05 },
        WildMenu = { bg = c.bg_visual },
        --
        DiffAdd = { bg = c.diff.add },
        DiffChange = { bg = c.diff.change },
        DiffDelete = { bg = c.diff.delete },
        DiffText = { bg = c.bg_sidebar },
        diffAdded = { fg = c.git.add },
        diffChanged = { fg = c.git.change },
        diffFile = { fg = c.green_01 },
        diffIndexLine = { fg = c.green_01 },
        diffLine = { fg = c.fg_03 },
        diffNewFile = { fg = c.blue_01 },
        diffOldFile = { fg = c.teal_01 },
        diffRemoved = { fg = c.red_01 },
        --
        --
        -- Bold = { style = "bold" },
        -- Italic = { style = "italic" },
        --
        AlphaHeader = { fg = c.red_02 },
        AlphaButton = { fg = c.orange_03 },
        AlphaFooter = { fg = c.orange_01 },
        AlphaQuote = { fg = c.fg_05 },
        BqfPreviewBorder = { bg = c.bg_sidebar, fg = c.green_01 },
        BqfPreviewRange = { bg = c.none, fg = c.green_01 },
        -- BufferCurrent = { bg = c.color_04, fg = c.color_21 },
        -- BufferCurrentIndex = { bg = c.color_04, fg = c.info },
        -- BufferCurrentMod = { bg = c.color_04, fg = c.warning },
        -- BufferCurrentSign = { bg = c.color_04, fg = c.info },
        -- BufferCurrentTarget = { bg = c.color_04, fg = c.color_25 },
        -- BufferInactive = { bg = c.bg_statusline, fg = c.color_06 },
        -- BufferInactiveIndex = { bg = c.bg_statusline, fg = c.color_06 },
        -- BufferInactiveMod = { bg = c.bg_statusline, fg = c.warning },
        -- BufferInactiveSign = { bg = c.bg_statusline, fg = c.border_highlight },
        -- BufferInactiveTarget = { bg = c.bg_statusline, fg = c.color_25 },
        -- BufferLineFill = { bg = c.color_02 },
        -- BufferLineIndicatorSelected = { fg = c.git.change },
        -- BufferTabpage = { bg = c.bg_statusline, fg = c.border_highlight },
        -- BufferTabpages = { bg = c.bg_statusline, fg = c.none },
        -- BufferVisible = { bg = c.bg_statusline, fg = c.color_21 },
        -- BufferVisibleIndex = { bg = c.bg_statusline, fg = c.info },
        -- BufferVisibleMod = { bg = c.bg_statusline, fg = c.warning },
        -- BufferVisibleSign = { bg = c.bg_statusline, fg = c.info },
        -- BufferVisibleTarget = { bg = c.bg_statusline, fg = c.color_25 },
        CalNormal = { bg = c.bg_sidebar },
        CalSaturday = { fg = c.green_03 },
        CalSunday = { fg = c.green_03 },
        CalToday = { fg = c.green_01, style = "bold" },
        --
        CmpDocumentation = { bg = c.bg_float, fg = c.orange_01 },
        CmpDocumentationBorder = { bg = c.bg_float, fg = c.bg_float },
        CmpItemAbbr = { bg = c.none, fg = c.fg_01 },
        CmpItemAbbrDeprecated = { bg = c.none, fg = c.orange_03, style = "strikethrough" },
        CmpItemAbbrMatch = { bg = c.none, fg = c.orange_02 },
        CmpItemMenu = { bg = c.none, fg = c.fg_01 },
        CmpItemAbbrMatchFuzzy = { bg = c.none, fg = c.orange_02 },
        CmpItemKindSnippet = { bg = c.none, fg = c.green_01 },
        CmpItemKindClass = { link = "Function", default = true },
        CmpItemKindConstant = { link = "Constant", default = true },
        CmpItemKindConstructor = { link = "Constructor", default = true },
        CmpItemKindDefault = { link = "String", default = true },
        CmpItemKindEnum = { link = "Repeat", default = true },
        CmpItemKindEnumMember = { link = "String", default = true },
        CmpItemKindEvent = { link = "Special", default = true },
        CmpItemKindField = { link = "Field", default = true },
        CmpItemKindFunction = { link = "Function", default = true },
        CmpItemKindInterface = { link = "Special", default = true },
        CmpItemKindKeyword = { link = "Keyword", default = true },
        CmpItemKindMethod = { link = "Function", default = true },
        CmpItemKindModule = { link = "Special", default = true },
        CmpItemKindOperator = { link = "Operator", default = true },
        CmpItemKindProperty = { link = "Property", default = true },
        CmpItemKindReference = { link = "TextReference", default = true },
        CmpItemKindStruct = { link = "Structure", default = true },
        CmpItemKindTypeParameter = { link = "Type", default = true },
        CmpItemKindUnit = { link = "Number", default = true },
        CmpItemKindValue = { link = "Variable", default = true },
        CmpItemKindVariable = { link = "Variable", default = true },
        --
        --
        NavicSeparator = { link = "Delimiter", default = true },
        NavicIconsArray = { link = "Constructor", default = true },
        NavicText = { link = "Character", default = true },
        NavicIconsClass = { link = "Function", default = true },
        NavicIconsBoolean = { link = "Boolean", default = true },
        NavicIconsConstant = { link = "Constant", default = true },
        NavicIconsConstructor = { link = "Constructor", default = true },
        NavicIconsEnum = { link = "Repeat", default = true },
        NavicIconsEnumMember = { link = "String", default = true },
        NavicIconsEvent = { link = "Special", default = true },
        NavicIconsField = { link = "Field", default = true },
        NavicIconsFile = { link = "Directory", default = true },
        NavicIconsFunction = { link = "Function", default = true },
        NavicIconsInterface = { link = "Special", default = true },
        NavicIconsKey = { link = "Keyword", default = true },
        NavicIconsMethod = { link = "Function", default = true },
        NavicIconsModule = { link = "Special", default = true },
        NavicIconsNamespace = { link = "Include", default = true },
        NavicIconsNull = { link = "Character", default = true },
        NavicIconsNumber = { link = "Number", default = true },
        NavicIconsObject = { link = "Structure", default = true },
        NavicIconsOperator = { link = "Operator", default = true },
        NavicIconsPackage = { link = "Special", default = true },
        NavicIconsProperty = { link = "Property", default = true },
        NavicIconsString = { link = "String", default = true },
        NavicIconsStruct = { link = "Structure", default = true },
        NavicIconsTypeParameter = { link = "Type", default = true },
        NavicIconsVariable = { link = "Variable", default = true },
        --
        ToDoError = { fg = c.red_02 },
        ToDoWarning = { fg = c.orange_02 },
        ToDoInfo = { fg = c.blue_02 },
        ToDoHint = { fg = c.teal_02 },
        ToDoTest = { fg = c.red_02 },
        ToDoDefault = { fg = c.blue_02 },
        --
        CtrlSpaceNormal = { bg = c.bg_sidebar },
        --
        DapUIBreakpointsCurrentLine = { fg = c.green_01, style = "bold" },
        DapUIBreakpointsDisabledLine = { fg = c.bg_01 },
        DapUIBreakpointsInfo = { fg = c.green_01 },
        DapUIBreakpointsLine = { fg = c.cyan_01 },
        DapUIBreakpointsPath = { fg = c.cyan_01 },
        DapUICurrentFrameName = { fg = c.green_01 },
        DapUIDecoration = { fg = c.cyan_01 },
        DapUIFloatBorder = { fg = c.blue_01 },
        DapUIFrameName = { fg = c.green_03 },
        DapUILineNumber = { fg = c.blue_01 },
        DapUIModifiedValue = { fg = c.cyan_01 },
        DapUIScope = { fg = c.blue_01 },
        DapUISource = { fg = c.cyan_01 },
        DapUIStoppedThread = { fg = c.cyan_01 },
        DapUIThread = { fg = c.green_01 },
        DapUIType = { fg = c.cyan_01 },
        DapUIValue = { fg = c.green_03, style = "bold" },
        DapUIVariable = { fg = c.fg_01 },
        DapUIWatchesEmpty = { fg = c.red_02 },
        DapUIWatchesError = { fg = c.red_02 },
        DapUIWatchesValue = { fg = c.green_01 },
        --
        DefinitionCount = { fg = c.orange_02 },
        DefinitionIcon = { fg = c.cyan_02 },
        --
        DiagnosticError = { fg = c.error },
        DiagnosticWarn = { fg = c.warning },
        DiagnosticInfo = { fg = c.info },
        DiagnosticHint = { fg = c.hint },
        DiagnosticUnderlineError = { style = "undercurl", sp = c.error },
        DiagnosticUnderlineWarn = { style = "undercurl", sp = c.warning },
        DiagnosticUnderlineInfo = { style = "undercurl", sp = c.info },
        DiagnosticUnderlineHint = { style = "undercurl", sp = c.hint },
        DiagnosticVirtualTextError = { bg = c.bg_statusline, fg = c.error },
        DiagnosticVirtualTextHint = { bg = c.bg_statusline, fg = c.hint },
        DiagnosticVirtualTextInfo = { bg = c.bg_statusline, fg = c.info },
        DiagnosticVirtualTextWarn = { bg = c.bg_statusline, fg = c.warning },
        --
        DifbufFile = { fg = c.teal_02 },
        DirbufBlock = { fg = c.teal_02 },
        DirbufChar = { fg = c.teal_02 },
        DirbufDirectory = { fg = c.teal_02 },
        DirbufFifo = { fg = c.teal_02 },
        DirbufHash = { fg = c.teal_02 },
        DirbufLink = { fg = c.teal_02 },
        DirbufSocket = { fg = c.teal_02 },
        --
        GitGutterAdd = { fg = c.gitSigns.add },
        GitGutterChange = { fg = c.gitSigns.change },
        GitGutterDelete = { fg = c.gitSigns.delete },
        GitSignsAdd = { fg = c.gitSigns.add },
        GitSignsChange = { fg = c.gitSigns.change },
        GitSignsDelete = { fg = c.gitSigns.delete },

        IndentBlanklineChar = { fg = c.bg_04 },
        IndentBlanklineContextChar = { fg = c.green_02 },
        -- GlyphPalette1 = { fg = c.color_25 },
        -- GlyphPalette2 = { fg = c.color_18 },
        -- GlyphPalette3 = { fg = c.color_19 },
        -- GlyphPalette4 = { fg = c.color_13 },
        -- GlyphPalette6 = { fg = c.color_08 },
        -- GlyphPalette7 = { fg = c.color_21 },
        -- GlyphPalette9 = { fg = c.color_25 },
        --
        HlSearchFloat = { fg = c.red_01, style = "bold" },
        HlSearchLens = { fg = c.green_01, style = "bold" },
        HlSearchLensNear = { fg = c.red_01, style = "bold" },
        HlSearchNear = { fg = c.orange_01, style = "bold" },
        --
        HopNextKey = { fg = c.orange_03, style = "bold" },
        HopNextKey1 = { fg = c.blue_03, style = "bold" },
        HopNextKey2 = { fg = c.teal_03, style = "bold" },
        HopUnmatched = { fg = c.green_03 },
        -- LightspeedGreyWash = { fg = c.color_05 },
        -- LightspeedLabel = { fg = c.color_17, style = "bold,underline" },
        -- LightspeedLabelDistant = { fg = c.color_08, style = "bold,underline" },
        -- LightspeedLabelDistantOverlapped = { fg = c.color_11, style = "underline" },
        -- LightspeedLabelOverlapped = { fg = c.color_17, style = "underline" },
        -- LightspeedMaskedChar = { fg = c.color_20 },
        -- LightspeedOneCharMatch = { bg = c.color_17, fg = c.color_21, style = "bold" },
        -- LightspeedPendingOpArea = { bg = c.color_17, fg = c.color_21 },
        -- LightspeedShortcut = { bg = c.color_17, fg = c.color_21, style = "bold,underline" },
        -- LightspeedUnlabeledMatch = { fg = c.color_10, style = "bold" },
        LspCodeLens = { fg = c.fg_01 },
        LspFloatWinBorder = { fg = c.bg_float },
        LspFloatWinNormal = { bg = c.bg_float },
        LspInlayHint = { fg = c.fg_01 },
        -- LspInstallerError = { fg = c.error },
        -- LspInstallerGreen = { fg = c.success },
        -- LspInstallerHeader = { bg = c.bg_03, fg = c.orange_02, style = "bold" },
        -- LspInstallerHeaderHelp = { fg = c.teal_02, style = "bold" },
        -- LspInstallerHeading = { fg = c.teal_02, style = "bold" },
        -- LspInstallerHighlighted = { bg = c.orange_02, fg = c.bg_03, style = "bold" },
        -- LspInstallerMuted = { fg = c.orange_02 },
        -- LspInstallerOrange = { fg = c.orange_02 },
        -- LspInstallerVaderSaber = { bg = c.none, fg = c.color_22, style = "bold" },
        -- LspInstallerVersionCheckLoader = { bg = c.bg_visual, fg = c.color_25, style = "bold" },
        -- LspInstallerVersionCheckLoaderDone = { bg = c.bg_visual, fg = c.color_18, style = "bold" },
        LspReferenceRead = { bg = c.bg_04 },
        LspReferenceText = { bg = c.bg_04 },
        LspReferenceWrite = { bg = c.bg_04 },
        -- LspSagaBorderTitle = { fg = c.color_23 },
        -- LspSagaCodeActionBorder = { fg = c.color_13 },
        -- LspSagaCodeActionContent = { fg = c.color_22 },
        -- LspSagaCodeActionTitle = { fg = c.color_12 },
        -- LspSagaDefPreviewBorder = { fg = c.color_18 },
        -- LspSagaFinderSelection = { fg = c.bg_visual },
        -- LspSagaHoverBorder = { fg = c.color_13 },
        -- LspSagaRenameBorder = { fg = c.color_18 },
        -- LspSagaSignatureHelpBorder = { fg = c.color_25 },
        -- LspSignatureActiveParameter = { fg = c.color_20 },
        LvimPopupNormal = { bg = c.bg_statusline },
        LvimPopupBorder = { bg = c.bg_statusline, fg = c.red_02, style = "bold" },
        LvimSelectNormal = { bg = c.bg_statusline, fg = c.green_01 },
        LvimSelectBorder = { bg = c.bg_statusline, fg = c.red_02, style = "bold" },
        LvimInputNormal = { bg = c.bg_statusline, fg = c.green_01 },
        LvimInputBorder = { bg = c.bg_statusline, fg = c.red_02, style = "bold" },
        --
        MasonError = { fg = c.red_02 },
        MasonHeader = { bg = c.bg_03, fg = c.orange_02, style = "bold" },
        MasonHeaderSecondary = { bg = c.bg_03, fg = c.orange_02, style = "bold" },
        MasonHeading = { fg = c.teal_02, style = "bold" },
        MasonHighlight = { fg = c.green_02 },
        MasonHighlightBlock = { bg = c.orange_02, fg = c.bg_03 },
        MasonHighlightBlockBold = { bg = c.orange_02, fg = c.bg_03, style = "bold" },
        MasonHighlightBlockBoldSecondary = { bg = c.orange_02, fg = c.bg_03, style = "bold" },
        MasonHighlightBlockSecondary = { bg = c.orange_02, fg = c.bg_03 },
        MasonHighlightSecondary = { fg = c.orange_02 },
        MasonLink = { bg = c.bg_03, fg = c.orange_02_02, style = "bold" },
        MasonMuted = { fg = c.orange_02 },
        MasonMutedBlock = { bg = c.bg_03, fg = c.orange_02 },
        MasonMutedBlockBold = { bg = c.bg_03, fg = c.orange_02, style = "bold" },
        --
        GlancePreviewbormal = { bg = c.bg_statusline },
        GlancePreviewMatch = { bg = c.bg_04 },
        GlancePreviewCursorLine = { bg = c.bg_03 },
        GlancePreviewSignColumn = { bg = c.bg_sidebar },
        GlancePreviewEndOfBuffer = { bg = c.bg_statusline },
        GlancePreviewLineNr = { bg = c.bg_statusline, fg = c.bg_06 },
        GlancePreviewBorderBottom = { bg = c.bg_statusline },
        GlanceWinBarFilename = { bg = c.bg_statusline, fg = c.green_01, style = "bold" },
        GlanceWinBarFilepath = { bg = c.bg_statusline, fg = c.fg_06, style = "bold" },
        GlanceWinBarTitle = { bg = c.bg_statusline, fg = c.red_02, style = "bold" },
        GlanceListNormal = { bg = c.bg_statusline, fg = c.orange_03 },
        GlanceListFilename = { fg = c.green_01, style = "bold" },
        GlanceListFilepath = { fg = c.fg_06, style = "bold" },
        GlanceListCount = { fg = c.red_01, style = "bold" },
        GlanceListMatch = { bg = c.orange_03, fg = c.bg_01, style = "bold" },
        GlanceListCursorLine = { bg = c.bg_03 },
        GlanceListEndOfBuffer = { fg = c.green_01 },
        GlanceListBorderBottom = { bg = c.bg_statusline },
        GlanceFoldIcon = { fg = c.orange_03 },
        GlanceIndent = { fg = c.bg_06 },
        GlanceBorderTop = { bg = c.bg_statusline },
        --
        NeoTreeDimText = { fg = c.fg_03 },
        NeoTreeDirectoryIcon = { fg = c.green_02 },
        NeoTreeDirectoryName = { fg = c.green_02 },
        NeoTreeDotfile = { fg = c.cyan_02 },
        NeoTreeExpander = { fg = c.blue_01_13 },
        NeoTreeFileName = { fg = c.green_02 },
        NeoTreeFloatBorder = { bg = c.bg_float, fg = c.bg_float },
        NeoTreeFloatTitle = { fg = c.orange_02, style = "bold" },
        NeoTreeMessage = { fg = c.fg_03 },
        -- NeoTreeModified = { fg = c.none },
        NeoTreeNormal = { bg = c.bg_sidebar, fg = c.green_02 },
        NeoTreeNormalNC = { bg = c.bg_sidebar, fg = c.green_02 },
        NeoTreeRootName = { fg = c.blue_02, style = "bold" },
        -- NeoTreeStatusLine = { fg = c.color_08 },
        NeoTreeTabInactive = { bg = c.bg_statusline, fg = c.green_02, style = "bold" },
        NeoTreeTabActive = { bg = c.green_02, fg = c.bg_statusline, style = "bold" },
        NeoTreeDiagTotalCount = { fg = c.blue_01, style = "bold" },
        NeoTreeDiagMessage = { fg = c.fg_05 },
        --
        -- NeogitBranch = { fg = c.color_24 },
        -- NeogitDiffAddHighlight = { bg = c.diff.add, fg = c.git.add },
        -- NeogitDiffContextHighlight = { bg = c.bg_statusline, fg = c.color_16 },
        -- NeogitDiffDeleteHighlight = { bg = c.diff.delete, fg = c.git.delete },
        -- NeogitHunkHeader = { bg = c.color_02, fg = c.color_21 },
        -- NeogitHunkHeaderHighlight = { bg = c.color_04, fg = c.color_13 },
        -- NeogitRemote = { fg = c.color_24 },
        -- NeogitNotificationInfo = { fg = c.info },
        -- NeogitNotificationWarning = { fg = c.warning },
        -- NeogitNotificationError = { fg = c.error },
        -- NeogitCommitViewDescription = { fg = c.color_07 },
        -- NeogitFilePath = { fg = c.error },
        -- NeogitCommitViewHeader = { fg = c.error },
        -- NeogitCommitMessage = { fg = c.color_07 },
        -- NeogitCommitView = { fg = c.color_24 },
        --
        NoiceBody = { link = "NuiBody", default = true },
        NoiceBorder = { link = "NuiBorder", default = true },
        NoiceText = { fg = c.green_01 },
        NoiceLspProgressSpinner = { fg = c.red_01 },
        NoiceLspProgressTitle = { fg = c.green_01 },
        NoiceLspProgressClient = { fg = c.orange_03 },
        NoiceFormatProgressTodo = { bg = c.none, fg = c.green_01 },
        NoiceFormatProgressDone = { bg = c.green_01, fg = c.bg_01 },
        NoiceFormatConfirm = { bg = c.bg_statusline, fg = c.green_01 },
        NoiceFormatConfirmDefault = { bg = c.bg_statusline, fg = c.green_01 },
        --
        NotifyDEBUGBody = { bg = c.bg_statusline, fg = c.fg_01 },
        NotifyDEBUGBorder = { bg = c.bg_statusline, fg = c.hint },
        NotifyDEBUGIcon = { bg = c.bg_statusline, fg = c.hint },
        NotifyDEBUGTitle = { bg = c.bg_statusline, fg = c.hint },
        NotifyERRORBody = { bg = c.bg_statusline, fg = c.fg_01 },
        NotifyERRORBorder = { bg = c.bg_statusline, fg = c.error },
        NotifyERRORIcon = { bg = c.bg_statusline, fg = c.error },
        NotifyERRORTitle = { bg = c.bg_statusline, fg = c.error },
        NotifyINFOBody = { bg = c.bg_statusline, fg = c.fg_01 },
        NotifyINFOBorder = { bg = c.bg_statusline, fg = c.info },
        NotifyINFOIcon = { bg = c.bg_statusline, fg = c.info },
        NotifyINFOTitle = { bg = c.bg_statusline, fg = c.info },
        NotifyTRACEBody = { bg = c.bg_statusline, fg = c.fg_01 },
        NotifyTRACEBorder = { bg = c.bg_statusline, fg = c.hint },
        NotifyTRACEIcon = { bg = c.bg_statusline, fg = c.hint },
        NotifyTRACETitle = { bg = c.bg_statusline, fg = c.hint },
        NotifyWARNBody = { bg = c.bg_statusline, fg = c.fg_01 },
        NotifyWARNBorder = { bg = c.bg_statusline, fg = c.warning },
        NotifyWARNIcon = { bg = c.bg_statusline, fg = c.warning },
        NotifyWARNTitle = { bg = c.bg_statusline, fg = c.warning },
        --
        NuiBody = { bg = c.bg_statusline, fg = c.green_01 },
        NuiBorder = { bg = c.bg_statusline, fg = c.red_02, style = "bold" },
        --
        -- NvimTreeEmptyFolderName = { fg = c.color_21, style = "bold" },
        -- NvimTreeExecFile = { fg = c.color_25 },
        -- NvimTreeFile = { fg = c.color_25 },
        -- NvimTreeFolderIcon = { fg = c.color_07 },
        -- NvimTreeFolderName = { fg = c.color_21, style = "bold" },
        -- NvimTreeGitDeleted = { fg = c.git.delete },
        -- NvimTreeGitDirty = { fg = c.git.change },
        -- NvimTreeGitNew = { fg = c.git.add },
        -- NvimTreeImageFile = { fg = c.color_11 },
        -- NvimTreeIndentMarker = { fg = c.color_22 },
        -- NvimTreeLspDiagnosticsError = { fg = c.error },
        -- NvimTreeLspDiagnosticsHint = { fg = c.hint },
        -- NvimTreeLspDiagnosticsInformation = { fg = c.info },
        -- NvimTreeLspDiagnosticsWarning = { fg = c.warning },
        -- NvimTreeNormal = { bg = c.bg_sidebar, fg = c.color_23 },
        -- NvimTreeNormalNC = { bg = c.bg_sidebar, fg = c.color_23 },
        -- NvimTreeOpenedFolderName = { fg = c.color_21, style = "bold" },
        -- NvimTreeRootFolder = { fg = c.color_07, style = "bold" },
        -- NvimTreeSignError = { fg = c.error },
        -- NvimTreeSignHint = { fg = c.hint },
        -- NvimTreeSignInformation = { fg = c.info },
        -- NvimTreeSignWarning = { fg = c.warning },
        -- NvimTreeSpecialFile = { fg = c.color_18 },
        -- NvimTreeSymlink = { fg = c.color_22 },
        -- NvimTreeWindowPicker = { bg = c.color_22, fg = c.color_03, style = "bold" },
        --
        OctoBubble = { bg = c.green_01, fg = c.fg_01 },
        OctoStateClosed = { fg = c.green_03 },
        OctoStateOpen = { fg = c.green_01 },
        OctoViewer = { fg = c.orange_01 },
        --
        OrgTSBlock = { fg = c.fg_05 },
        OrgTSBlockCode = { bg = c.bg_statusline },
        OrgTSCheckbox = { fg = c.red_02, style = "bold" },
        OrgTSCheckboxChecked = { fg = c.green_02, style = "bold" },
        OrgTSCheckboxHalfChecked = { fg = c.orange_02, style = "bold" },
        OrgTSHeadlineLevel1 = { fg = c.blue_01, style = "bold" },
        OrgTSHeadlineLevel2 = { fg = c.teal_01, style = "bold" },
        OrgTSHeadlineLevel3 = { fg = c.cyan_01, style = "bold" },
        OrgTSHeadlineLevel4 = { fg = c.green_01, style = "bold" },
        OrgTSHeadlineLevel5 = { fg = c.red_01, style = "bold" },
        OrgTSHeadlineLevel6 = { fg = c.orange_01, style = "bold" },
        OrgTSHeadlineLevel7 = { fg = c.teal_03, style = "bold" },
        OrgTSHeadlineLevel8 = { fg = c.cyan_03, style = "bold" },
        --
        packerStatus = { fg = c.orange_02 },
        packerStatusCommit = { fg = c.teal_02 },
        packerStatusSuccess = { fg = c.green_01 },
        packerStatusFail = { fg = c.red_01 },
        packerPackageName = { fg = c.orange_02 },
        packerPackageNotLoaded = { fg = c.red_02 },
        packerString = { fg = c.orange_01 },
        packerBool = { fg = c.blue_01 },
        packerBreakingChange = { fg = c.red_02 },
        packerWorking = { fg = c.cyan_03 },
        packerSuccess = { fg = c.green_01 },
        packerFail = { fg = c.red_01 },
        packerHash = { fg = c.orange_01 },
        packerRelDate = { fg = c.teal_01 },
        packerProgress = { fg = c.teal_01 },
        packerOutput = { fg = c.orange_01 },
        --
        -- ReferencesCount = { fg = c.color_22 },
        -- ReferencesIcon = { fg = c.color_13 },
        --
        Sneak = { bg = c.red_02, fg = c.bg_02 },
        SneakScope = { bg = c.bg_visual },
        --
        SniprunFloatingWinErr = { fg = c.error, style = "bold" },
        SniprunFloatingWinOk = { fg = c.success, style = "bold" },
        SniprunVirtualTextErr = { fg = c.error, style = "bold" },
        SniprunVirtualTextOk = { fg = c.success, style = "bold" },
        --
        -- TargetWord = { fg = c.color_23 },
        --
        TelescopeBorder = { bg = c.bg_01, fg = c.bg_01 },
        TelescopeMatching = { bg = c.orange_02, fg = c.bg_01, style = "bold" },
        TelescopeMultiSelection = { bg = c.bg_05, fg = c.green_01 },
        TelescopeNormal = { bg = c.bg_01, fg = c.orange_01 },
        TelescopePreviewTitle = { bg = c.green_01, fg = c.bg_04, style = "bold" },
        TelescopePromptBorder = { bg = c.bg_sidebar, fg = c.bg_sidebar },
        TelescopePromptNormal = { bg = c.bg_sidebar, fg = c.green_01 },
        TelescopePromptPrefix = { bg = c.bg_sidebar, fg = c.green_01 },
        TelescopePromptTitle = { bg = c.green_01, fg = c.bg_04, style = "bold" },
        TelescopeResultsTitle = { bg = c.none, fg = c.none },
        TelescopeSelection = { bg = c.bg_03, fg = c.green_01 },
        TelescopeSelectionCaret = { bg = c.bg_05, fg = c.green_01 },
        --
        -- TroubleCount = { fg = c.color_23 },
        -- TroubleError = { bg = c.error },
        -- TroubleInformation = { bg = c.info },
        -- TroubleNormal = { bg = c.color_01 },
        -- TroubleText = { fg = c.color_19 },
        -- TroubleTextError = { fg = c.error },
        -- TroubleTextHint = { fg = c.hint },
        -- TroubleTextInformation = { fg = c.info },
        -- TroubleTextWarning = { fg = c.warning },
        -- TroubleWarning = { bg = c.warning },
        --
        WhichKey = { fg = c.orange_01 },
        WhichKeyBorder = { bg = c.bg_float, fg = c.bg_float },
        WhichKeyDesc = { fg = c.red_01 },
        WhichKeyFloat = { bg = c.bg_float },
        WhichKeyGroup = { fg = c.fg_06 },
        WhichKeySeparator = { fg = c.fg_05 },
        WhichKeyValue = { fg = c.fg_06 },
        --
        -- debugBreakpoint = { bg = colors.bg_statusline, fg = c.info },
        -- debugPC = { bg = c.bg_sidebar },
        --
        -- illuminatedCurWord = { bg = c.color_04 },
        -- illuminatedWord = { bg = c.color_04 },
        -- mkdCodeDelimiter = { bg = c.color_03, fg = c.color_21 },
        -- mkdCodeEnd = { fg = c.color_09, style = "bold" },
        -- mkdCodeStart = { fg = c.color_09, style = "bold" },
        TreesitterContext = { bg = c.bg_statusline },
        TreesitterContextLineNumber = { bg = c.bg_statusline, fg = c.red_02, style = "bold" },
        --
        TSAnnotation = { link = "PreProc", default = true },
        TSAttribute = { link = "PreProc", default = true }, --
        TSBoolean = { link = "Boolean", default = true }, --
        TSCharacterSpecial = { link = "SpecialChar", default = true }, --
        TSComment = { link = "Comment", default = true }, --
        TSConditional = { link = "Conditional", default = true }, --
        TSConstBuiltin = { link = "Special", default = true },
        TSConstMacro = { link = "Define", default = true },
        TSConstant = { link = "Constant", default = true }, --
        TSConstructor = { link = "Constructor", default = true }, --
        TSDanger = { link = "Danger", default = true }, --
        TSDebug = { link = "Debug", default = true },
        TSDefine = { link = "Define", default = true },
        TSEmphasis = { italic = true, default = true },
        TSEnvironment = { link = "Macro", default = true },
        TSEnvironmentName = { link = "Type", default = true },
        TSError = { link = "ErrorMsg" },
        TSException = { link = "Exception", default = true },
        TSField = { link = "Field", default = true }, --
        TSFloat = { link = "Float", default = true },
        TSFuncBuiltin = { link = "FuncBuiltin", default = true },
        TSFuncMacro = { link = "Macro", default = true },
        TSFunction = { link = "Function", default = true },
        TSFunctionCall = { link = "TSFunction", default = true },
        TSInclude = { link = "Include", default = true },
        TSKeyword = { link = "Keyword", default = true }, --
        TSKeywordFunction = { link = "KeywordFunction", default = true }, --
        TSKeywordOperator = { link = "Operator", default = true },
        TSKeywordReturn = { link = "TSKeyword", default = true },
        TSLabel = { link = "Label", default = true },
        TSLiteral = { link = "String", default = true },
        TSMath = { link = "Special", default = true },
        TSMethod = { link = "Function", default = true },
        TSMethodCall = { link = "TSMethod", default = true },
        TSNamespace = { link = "Include", default = true },
        TSNone = { default = true },
        TSNote = { link = "Note", default = true },
        TSNumber = { link = "Number", default = true },
        TSOperator = { link = "Operator", default = true }, --
        TSParameter = { link = "Parameter", default = true },
        TSParameterReference = { link = "TSParameter", default = true },
        TSPreProc = { link = "PreProc", default = true },
        TSProperty = { link = "Property", default = true }, --
        TSPunctBracket = { link = "Delimiter", default = true }, --
        TSPunctDelimiter = { link = "Delimiter", default = true }, --
        TSPunctSpecial = { link = "Special", default = true }, --
        TSRepeat = { link = "Repeat", default = true },
        TSStorageClass = { link = "StorageClass", default = true },
        TSStrike = { strikethrough = true },
        TSString = { link = "String", default = true }, --
        TSStringEscape = { link = "StringEscape", default = true }, --
        TSStringRegex = { link = "StringRegex", default = true }, --
        TSStringSpecial = { link = "SpecialChar", default = true },
        TSStrong = { bold = true, default = true },
        TSStructure = { link = "Structure", default = true }, --
        TSSymbol = { link = "Identifier", default = true },
        TSTag = { link = "Tag", default = true }, --
        TSTagAttribute = { link = "TSProperty", default = true }, --
        TSTagDelimiter = { link = "Delimiter", default = true }, --
        TSText = { link = "TSNone", default = true },
        TSTextReference = { link = "TextReference", default = true }, --
        TSTitle = { link = "Title", default = true }, --
        TSTodo = { link = "Todo", default = true },
        TSType = { link = "Type", default = true }, --
        TSTypeBuiltin = { link = "Type", default = true }, --
        TSTypeDefinition = { link = "Typedef", default = true }, --
        TSTypeQualifier = { link = "Type", default = true },
        TSURI = { link = "Underlined", default = true },
        TSUnderline = { link = "Underlined", default = true },
        TSVariable = { link = "Variable", default = true }, --
        TSVariableBuiltin = { link = "VariableBuiltin", default = true }, --
        TSWarning = { link = "Warning", default = true },
        TScharacter = { link = "Character", default = true }, --
        ["@attribute"] = { link = "PreProc", default = true },
        ["@boolean"] = { link = "Boolean", default = true },
        ["@character"] = { link = "Character", default = true },
        ["@character.special"] = { link = "SpecialChar", default = true },
        ["@comment"] = { link = "Comment", default = true },
        ["@conditional"] = { link = "Conditional", default = true },
        ["@constant"] = { link = "Constant", default = true },
        ["@constructor"] = { link = "Constructor", default = true },
        ["@ditectory"] = { link = "Directory", default = true },
        ["@field"] = { link = "Field", default = true },
        ["@float"] = { link = "Float", default = true },
        ["@include"] = { link = "Include", default = true },
        ["@keyword"] = { link = "Keyword", default = true },
        ["@keyword.function"] = { link = "KeywordFunction", default = true },
        ["@label"] = { link = "Label", default = true },
        ["@method"] = { link = "Function", default = true },
        ["@namespace"] = { link = "Include", default = true },
        ["@number"] = { link = "Number", default = true },
        ["@operator"] = { link = "Operator", default = true },
        ["@parameter"] = { link = "Parameter", default = true },
        ["@property"] = { link = "Property", default = true },
        ["@punctuation.bracket"] = { link = "Delimiter", default = true },
        ["@punctuation.delimiter"] = { link = "Delimiter", default = true },
        ["@punctuation.special"] = { link = "Special", default = true },
        ["@string"] = { link = "String", default = true },
        ["@string.escape"] = { link = "StringEscape", default = true },
        ["@string.regex"] = { link = "StringRegex", default = true },
        ["@structure"] = { link = "Structure", default = true },
        ["@tag"] = { link = "Tag", default = true },
        ["@tag.attribute"] = { link = "TSProperty", default = true },
        ["@tag.delimiter"] = { link = "Delimiter", default = true },
        ["@text.danger"] = { link = "Danger", default = true },
        ["@text.reference"] = { link = "TextReference", default = true },
        ["@text.warning"] = { link = "Warning", default = true },
        ["@title"] = { link = "Title", default = true },
        ["@type"] = { link = "Type", default = true },
        ["@type.builtin"] = { link = "Type", default = true },
        ["@type.definition"] = { link = "Typedef", default = true },
        ["@variable"] = { link = "Variable", default = true },
        ["@variable.builtin"] = { link = "VariableBuiltin", default = true },
    }
    if not vim.diagnostic then
        local severity_map = {
            Error = "Error",
            Warn = "Warning",
            Info = "Information",
            Hint = "Hint",
        }
        local types = { "Default", "VirtualText", "Underline" }
        for _, type in ipairs(types) do
            for snew, sold in pairs(severity_map) do
                highlights["LspDiagnostics" .. type .. sold] = {
                    link = "Diagnostic" .. (type == "Default" and "" or type) .. snew,
                }
            end
        end
    end
    return highlights
end

return M
