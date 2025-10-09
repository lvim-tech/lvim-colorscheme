local M = {}

---@type lvim-colorscheme.HighlightsFn
function M.get(c, _)
    return {
        -- PHP
        phpRegion = {
            fg = c.blue,
        },
        phpFunction = {
            fg = c.blue,
            bold = true,
        },
        phpMethod = {
            fg = c.blue,
        },
        phpClass = {
            fg = c.yellow,
            bold = true,
        },
        phpIdentifier = {
            fg = c.fg_light,
        },
        phpStringSingle = {
            fg = c.green,
        },
        phpStringDouble = {
            fg = c.green,
        },
        phpOperator = {
            fg = c.magenta,
        },
        phpVarSelector = {
            fg = c.fg_light,
        },
        phpKeyword = {
            fg = c.purple,
        },
        phpType = {
            fg = c.yellow_dark,
        },
        phpComment = {
            fg = c.comment,
            italic = true,
        },

        -- HTML
        htmlTag = {
            fg = c.cyan,
        },
        htmlEndTag = {
            fg = c.cyan,
        },
        htmlTagName = {
            fg = c.blue,
        },
        htmlArg = {
            fg = c.yellow,
        },
        htmlTitle = {
            fg = c.fg_light,
            bold = true,
        },
        htmlSpecialChar = {
            fg = c.orange,
        },

        -- CSS
        cssIdentifier = {
            fg = c.yellow,
        },
        cssClassName = {
            fg = c.green,
        },
        cssTagName = {
            fg = c.blue,
        },
        cssProp = {
            fg = c.cyan,
        },
        cssAttr = {
            fg = c.green_dark,
        },
        cssColor = {
            fg = c.orange,
        },
        cssImportant = {
            fg = c.red,
            bold = true,
        },

        -- JavaScript
        javaScriptFunction = {
            fg = c.purple,
            bold = true,
        },
        javaScriptIdentifier = {
            fg = c.purple,
        },
        javaScriptBraces = {
            fg = c.fg,
        },
        javaScriptNumber = {
            fg = c.orange,
        },
        javaScriptReserved = {
            fg = c.purple,
        },
        javaScriptOperator = {
            fg = c.magenta,
        },
        javaScriptRegexpString = {
            fg = c.red,
        },
        javaScriptStatement = {
            fg = c.purple,
        },

        -- TypeScript
        typescriptBraces = {
            fg = c.fg,
        },
        typescriptDecorators = {
            fg = c.yellow,
        },
        typescriptFuncKeyword = {
            fg = c.purple,
        },
        typescriptIdentifier = {
            fg = c.blue,
        },
        typescriptExport = {
            fg = c.purple,
            bold = true,
        },
        typescriptImport = {
            fg = c.purple,
            bold = true,
        },
        typescriptTypeReference = {
            fg = c.yellow_dark,
        },

        -- Python
        pythonFunction = {
            fg = c.blue,
            bold = true,
        },
        pythonBuiltin = {
            fg = c.cyan,
        },
        pythonStatement = {
            fg = c.purple,
        },
        pythonOperator = {
            fg = c.magenta,
        },
        pythonClass = {
            fg = c.yellow,
            bold = true,
        },
        pythonDecorator = {
            fg = c.yellow,
        },
        pythonInclude = {
            fg = c.purple,
        },
        pythonString = {
            fg = c.green,
        },
        pythonComment = {
            fg = c.comment,
            italic = true,
        },

        -- Ruby
        rubyClass = {
            fg = c.yellow,
            bold = true,
        },
        rubyFunction = {
            fg = c.blue,
            bold = true,
        },
        rubySymbol = {
            fg = c.cyan,
        },
        rubyConstant = {
            fg = c.yellow_dark,
        },
        rubyInstanceVariable = {
            fg = c.teal,
        },
        rubyBlockParameter = {
            fg = c.orange,
        },
        rubyRegexp = {
            fg = c.red,
        },

        -- Go
        goType = {
            fg = c.yellow_dark,
        },
        goSignedInts = {
            fg = c.yellow_dark,
        },
        goUnsignedInts = {
            fg = c.yellow_dark,
        },
        goFunction = {
            fg = c.blue,
            bold = true,
        },
        goFunctionCall = {
            fg = c.blue,
        },
        goVarDefs = {
            fg = c.fg_light,
        },
        goReceiverVar = {
            fg = c.orange,
        },
        goPackage = {
            fg = c.purple,
        },

        -- Rust
        rustModPath = {
            fg = c.fg_light,
        },
        rustFuncCall = {
            fg = c.blue,
        },
        rustFuncName = {
            fg = c.blue,
            bold = true,
        },
        rustType = {
            fg = c.yellow_dark,
        },
        rustSigil = {
            fg = c.magenta,
        },
        rustMacro = {
            fg = c.cyan,
        },
        rustStorage = {
            fg = c.purple,
        },

        -- Java
        javaType = {
            fg = c.yellow_dark,
        },
        javaStorageClass = {
            fg = c.purple,
        },
        javaAnnotation = {
            fg = c.yellow,
        },
        javaClassDecl = {
            fg = c.yellow,
            bold = true,
        },
        javaMethod = {
            fg = c.blue,
            bold = true,
        },
        javaOperator = {
            fg = c.magenta,
        },

        -- C/C++
        cType = {
            fg = c.yellow_dark,
        },
        cStructure = {
            fg = c.purple,
        },
        cStorageClass = {
            fg = c.purple,
        },
        cFunction = {
            fg = c.blue,
            bold = true,
        },
        cppStatement = {
            fg = c.purple,
        },
        cppAccess = {
            fg = c.purple,
        },
        cppType = {
            fg = c.yellow_dark,
        },
        cppExceptions = {
            fg = c.red,
        },

        -- Markdown
        markdownHeadingDelimiter = {
            fg = c.red,
            bold = true,
        },
        markdownH1 = {
            fg = c.red,
            bold = true,
        },
        markdownH2 = {
            fg = c.orange,
            bold = true,
        },
        markdownH3 = {
            fg = c.yellow,
            bold = true,
        },
        markdownH4 = {
            fg = c.green,
            bold = true,
        },
        markdownH5 = {
            fg = c.blue,
            bold = true,
        },
        markdownH6 = {
            fg = c.purple,
            bold = true,
        },
        markdownCode = {
            fg = c.green,
        },
        markdownCodeBlock = {
            fg = c.green,
        },
        markdownLink = {
            fg = c.blue,
            underline = true,
        },
        markdownListMarker = {
            fg = c.cyan,
        },
        markdownBold = {
            fg = c.fg_light,
            bold = true,
        },
        markdownItalic = {
            fg = c.fg_light,
            italic = true,
        },

        -- Lua
        luaFunction = {
            fg = c.purple,
            bold = true,
        },
        luaTable = {
            fg = c.fg,
        },
        luaIn = {
            fg = c.purple,
        },
        luaOperator = {
            fg = c.magenta,
        },
        luaFuncCall = {
            fg = c.blue,
        },
        luaSpecialTable = {
            fg = c.cyan,
        },

        -- JSON
        jsonKeyword = {
            fg = c.blue,
        },
        jsonString = {
            fg = c.green,
        },
        jsonNumber = {
            fg = c.orange,
        },
        jsonBraces = {
            fg = c.fg,
        },

        -- YAML
        yamlKey = {
            fg = c.blue,
        },
        yamlAnchor = {
            fg = c.purple,
        },
        yamlAlias = {
            fg = c.purple,
        },
        yamlDocumentHeader = {
            fg = c.green,
        },

        -- Shell
        shDerefVar = {
            fg = c.teal,
        },
        shFunction = {
            fg = c.blue,
            bold = true,
        },
        shStatement = {
            fg = c.purple,
        },
        shOption = {
            fg = c.cyan,
        },
        shQuote = {
            fg = c.green,
        },

        -- SQL
        sqlKeyword = {
            fg = c.purple,
        },
        sqlFunction = {
            fg = c.blue,
        },
        sqlStatement = {
            fg = c.purple,
        },
        sqlSpecial = {
            fg = c.orange,
        },

        -- XML
        xmlTag = {
            fg = c.cyan,
        },
        xmlTagName = {
            fg = c.blue,
        },
        xmlEndTag = {
            fg = c.cyan,
        },
        xmlAttrib = {
            fg = c.yellow,
        },
    }
end

return M
