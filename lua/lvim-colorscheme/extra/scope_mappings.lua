local M = {}

M.STANDARD_SCOPES = {
    -- Comments
    { name = "Comment", scope = "comment", hl_group = "Comment" },
    { name = "Comment Line", scope = "comment.line", hl_group = "Comment" },
    { name = "Comment Line Double-Slash", scope = "comment.line.double-slash", hl_group = "Comment" },
    { name = "Comment Line Double-Dash", scope = "comment.line.double-dash", hl_group = "Comment" },
    { name = "Comment Line Number-Sign", scope = "comment.line.number-sign", hl_group = "Comment" },
    { name = "Comment Line Percentage", scope = "comment.line.percentage", hl_group = "Comment" },
    { name = "Comment Block", scope = "comment.block", hl_group = "Comment" },
    { name = "Comment Block Documentation", scope = "comment.block.documentation", hl_group = "SpecialComment" },
    { name = "Comment Block Documentation HTML", scope = "comment.block.html", hl_group = "SpecialComment" },
    {
        name = "Comment Block Documentation JSDoc",
        scope = "comment.block.documentation.js",
        hl_group = "SpecialComment",
    },
    {
        name = "Comment Block Documentation PHPDoc",
        scope = "comment.block.documentation.phpdoc",
        hl_group = "SpecialComment",
    },
    {
        name = "Comment Block Documentation Python",
        scope = "comment.block.documentation.python",
        hl_group = "SpecialComment",
    },
    {
        name = "Comment Block Documentation Rust",
        scope = "comment.block.documentation.rust",
        hl_group = "SpecialComment",
    },

    -- Strings
    { name = "String", scope = "string", hl_group = "String" },
    { name = "String Quoted", scope = "string.quoted", hl_group = "String" },
    { name = "String Quoted Single", scope = "string.quoted.single", hl_group = "String" },
    { name = "String Quoted Double", scope = "string.quoted.double", hl_group = "String" },
    { name = "String Quoted Triple", scope = "string.quoted.triple", hl_group = "String" },
    { name = "String Quoted Other", scope = "string.quoted.other", hl_group = "String" },
    { name = "String Unquoted", scope = "string.unquoted", hl_group = "String" },
    { name = "String Interpolated", scope = "string.interpolated", hl_group = "String" },
    { name = "String Regexp", scope = "string.regexp", hl_group = "String" },
    { name = "String Other", scope = "string.other", hl_group = "String" },
    { name = "String Documentation", scope = "string.documentation", hl_group = "SpecialComment" },
    { name = "String Template", scope = "string.template", hl_group = "String" },
    { name = "String.Regexp Special", scope = "string.regexp constant.character.escape", hl_group = "SpecialChar" },

    -- Numbers
    { name = "Constant Numeric", scope = "constant.numeric", hl_group = "Number" },
    { name = "Constant Numeric Integer", scope = "constant.numeric.integer", hl_group = "Number" },
    { name = "Constant Numeric Integer Decimal", scope = "constant.numeric.integer.decimal", hl_group = "Number" },
    {
        name = "Constant Numeric Integer Hexadecimal",
        scope = "constant.numeric.integer.hexadecimal",
        hl_group = "Number",
    },
    { name = "Constant Numeric Integer Octal", scope = "constant.numeric.integer.octal", hl_group = "Number" },
    { name = "Constant Numeric Integer Binary", scope = "constant.numeric.integer.binary", hl_group = "Number" },
    { name = "Constant Numeric Float", scope = "constant.numeric.float", hl_group = "Float" },
    { name = "Constant Numeric Float Decimal", scope = "constant.numeric.float.decimal", hl_group = "Float" },
    { name = "Constant Numeric Float Complex", scope = "constant.numeric.float.complex", hl_group = "Float" },
    { name = "Constant Numeric Float Scientific", scope = "constant.numeric.float.scientific", hl_group = "Float" },

    -- Constants
    { name = "Constant Language", scope = "constant.language", hl_group = "Constant" },
    { name = "Constant Language Boolean True", scope = "constant.language.boolean.true", hl_group = "Boolean" },
    { name = "Constant Language Boolean False", scope = "constant.language.boolean.false", hl_group = "Boolean" },
    { name = "Constant Language Null", scope = "constant.language.null", hl_group = "Constant" },
    { name = "Constant Language Undefined", scope = "constant.language.undefined", hl_group = "Constant" },
    { name = "Constant Language Symbol", scope = "constant.language.symbol", hl_group = "Constant" },
    { name = "Constant Character", scope = "constant.character", hl_group = "Character" },
    { name = "Constant Character Escape", scope = "constant.character.escape", hl_group = "SpecialChar" },
    { name = "Constant Character Entity", scope = "constant.character.entity", hl_group = "SpecialChar" },
    { name = "Constant Other", scope = "constant.other", hl_group = "Constant" },

    -- Variables
    { name = "Variable", scope = "variable", hl_group = "Identifier" },
    { name = "Variable Built-in", scope = "variable.language", hl_group = "Identifier" },
    { name = "Variable Parameter", scope = "variable.parameter", hl_group = "Identifier" },
    { name = "Variable Other", scope = "variable.other", hl_group = "Identifier" },
    { name = "Variable Other Readwrite", scope = "variable.other.readwrite", hl_group = "Identifier" },
    { name = "Variable Other Constant", scope = "variable.other.constant", hl_group = "Constant" },
    { name = "Variable Other Global", scope = "variable.other.global", hl_group = "Identifier" },
    { name = "Variable Other Member", scope = "variable.other.member", hl_group = "Identifier" },
    { name = "Variable Function", scope = "variable.function", hl_group = "Function" },
    { name = "Variable Other Object", scope = "variable.other.object", hl_group = "Identifier" },
    { name = "Variable Other Enummember", scope = "variable.other.enummember", hl_group = "Identifier" },
    { name = "Variable Other Property", scope = "variable.other.property", hl_group = "Identifier" },

    -- Keywords
    { name = "Keyword", scope = "keyword", hl_group = "Keyword" },
    { name = "Keyword Control", scope = "keyword.control", hl_group = "Statement" },
    { name = "Keyword Control Conditional", scope = "keyword.control.conditional", hl_group = "Conditional" },
    { name = "Keyword Control Import", scope = "keyword.control.import", hl_group = "Include" },
    { name = "Keyword Control Export", scope = "keyword.control.export", hl_group = "Include" },
    { name = "Keyword Control Flow", scope = "keyword.control.flow", hl_group = "Statement" },
    { name = "Keyword Control Loop", scope = "keyword.control.loop", hl_group = "Repeat" },
    { name = "Keyword Control Exception", scope = "keyword.control.exception", hl_group = "Exception" },
    { name = "Keyword Operator", scope = "keyword.operator", hl_group = "Operator" },
    { name = "Keyword Operator Assignment", scope = "keyword.operator.assignment", hl_group = "Operator" },
    { name = "Keyword Operator Arithmetic", scope = "keyword.operator.arithmetic", hl_group = "Operator" },
    { name = "Keyword Operator Logical", scope = "keyword.operator.logical", hl_group = "Operator" },
    { name = "Keyword Operator Comparison", scope = "keyword.operator.comparison", hl_group = "Operator" },
    { name = "Keyword Operator Bitwise", scope = "keyword.operator.bitwise", hl_group = "Operator" },
    { name = "Keyword Operator Word", scope = "keyword.operator.word", hl_group = "Operator" },
    { name = "Keyword Other", scope = "keyword.other", hl_group = "Keyword" },

    -- Functions
    { name = "Entity Name Function", scope = "entity.name.function", hl_group = "Function" },
    { name = "Entity Name Function Constructor", scope = "entity.name.function.constructor", hl_group = "Function" },
    { name = "Entity Name Function Destructor", scope = "entity.name.function.destructor", hl_group = "Function" },
    { name = "Entity Name Function Macro", scope = "entity.name.function.macro", hl_group = "Macro" },
    { name = "Entity Name Function Method", scope = "entity.name.function.method", hl_group = "Function" },
    { name = "Entity Name Function Preprocessor", scope = "entity.name.function.preprocessor", hl_group = "PreProc" },
    { name = "Support Function", scope = "support.function", hl_group = "Function" },
    { name = "Support Function Builtin", scope = "support.function.builtin", hl_group = "Function" },
    { name = "Support Function Magic", scope = "support.function.magic", hl_group = "Special" },
    -- Classes and Types
    { name = "Entity Name Class", scope = "entity.name.type.class", hl_group = "Type" },
    { name = "Entity Name Struct", scope = "entity.name.type.struct", hl_group = "Type" },
    { name = "Entity Name Enum", scope = "entity.name.type.enum", hl_group = "Type" },
    { name = "Entity Name Interface", scope = "entity.name.type.interface", hl_group = "Type" },
    { name = "Entity Name Type", scope = "entity.name.type", hl_group = "Type" },
    { name = "Entity Name Type Class Base", scope = "entity.name.type.class.base", hl_group = "Type" },
    { name = "Entity Name Type Protocol", scope = "entity.name.type.protocol", hl_group = "Type" },
    { name = "Entity Name Type Namespace", scope = "entity.name.type.namespace", hl_group = "Type" },
    { name = "Entity Name Type Module", scope = "entity.name.type.module", hl_group = "Type" },
    { name = "Entity Name Type Package", scope = "entity.name.type.package", hl_group = "Type" },
    { name = "Entity Name Type Primitive", scope = "entity.name.type.primitive", hl_group = "Type" },
    { name = "Entity Name Type Template", scope = "entity.name.type.template", hl_group = "Type" },
    { name = "Entity Name Type Generic", scope = "entity.name.type.generic", hl_group = "Type" },
    { name = "Entity Name Type Parameter", scope = "entity.name.type.parameter", hl_group = "Type" },
    { name = "Entity Other Inherited Class", scope = "entity.other.inherited-class", hl_group = "Type" },
    { name = "Storage Type", scope = "storage.type", hl_group = "Type" },
    { name = "Storage Type Built-in", scope = "storage.type.builtin", hl_group = "Type" },
    { name = "Storage Type Primitive", scope = "storage.type.primitive", hl_group = "Type" },
    { name = "Storage Type Class", scope = "storage.type.class", hl_group = "StorageClass" },
    { name = "Storage Type Function", scope = "storage.type.function", hl_group = "Type" },
    { name = "Storage Type Interface", scope = "storage.type.interface", hl_group = "Type" },
    { name = "Storage Type Enum", scope = "storage.type.enum", hl_group = "Type" },
    { name = "Storage Type Generic", scope = "storage.type.generic", hl_group = "Type" },
    { name = "Storage Type Modifier", scope = "storage.modifier", hl_group = "StorageClass" },

    -- Tags and Markup
    { name = "Entity Name Tag", scope = "entity.name.tag", hl_group = "Tag" },
    { name = "Entity Name Tag HTML", scope = "entity.name.tag.html", hl_group = "Tag" },
    { name = "Entity Name Tag XML", scope = "entity.name.tag.xml", hl_group = "Tag" },
    { name = "Entity Name Tag YAML", scope = "entity.name.tag.yaml", hl_group = "Tag" },
    { name = "Entity Name Tag CSS", scope = "entity.name.tag.css", hl_group = "Tag" },
    { name = "Entity Other Attribute Name", scope = "entity.other.attribute-name", hl_group = "Identifier" },
    { name = "Markup Heading", scope = "markup.heading", hl_group = "Title" },
    { name = "Markup List", scope = "markup.list", hl_group = "Statement" },
    { name = "Markup Bold", scope = "markup.bold", hl_group = "Bold" },
    { name = "Markup Italic", scope = "markup.italic", hl_group = "Italic" },
    { name = "Markup Underline", scope = "markup.underline", hl_group = "Underlined" },
    { name = "Markup Quote", scope = "markup.quote", hl_group = "Comment" },
    { name = "Markup Raw", scope = "markup.raw", hl_group = "String" },
    { name = "Markup Link", scope = "markup.link", hl_group = "Underlined" },
    { name = "Markup Link Description", scope = "markup.link.description", hl_group = "String" },
    { name = "Markup Math", scope = "markup.math", hl_group = "Special" },
    { name = "Markup Inline", scope = "markup.inline", hl_group = "Special" },
    { name = "Markup Setext Header", scope = "markup.heading.setext", hl_group = "Title" },

    -- Punctuation
    { name = "Punctuation", scope = "punctuation", hl_group = "Delimiter" },
    { name = "Punctuation Definition", scope = "punctuation.definition", hl_group = "Delimiter" },
    { name = "Punctuation Section", scope = "punctuation.section", hl_group = "Delimiter" },
    { name = "Punctuation Terminator", scope = "punctuation.terminator", hl_group = "Delimiter" },
    { name = "Punctuation Separator", scope = "punctuation.separator", hl_group = "Delimiter" },
    { name = "Punctuation Accessor", scope = "punctuation.accessor", hl_group = "Delimiter" },
    { name = "Punctuation Quote", scope = "punctuation.quote", hl_group = "Delimiter" },
    { name = "Punctuation Bracket", scope = "punctuation.bracket", hl_group = "Delimiter" },
    { name = "Punctuation Brace", scope = "punctuation.brace", hl_group = "Delimiter" },
    { name = "Punctuation Parenthesis", scope = "punctuation.parenthesis", hl_group = "Delimiter" },
    { name = "Punctuation Definition Comment", scope = "punctuation.definition.comment", hl_group = "Comment" },
    { name = "Punctuation Definition String", scope = "punctuation.definition.string", hl_group = "String" },
    { name = "Punctuation Definition Variable", scope = "punctuation.definition.variable", hl_group = "Identifier" },
    { name = "Punctuation Definition Keyword", scope = "punctuation.definition.keyword", hl_group = "Keyword" },
    { name = "Punctuation Definition Parameters", scope = "punctuation.definition.parameters", hl_group = "Delimiter" },

    -- Meta
    { name = "Meta Class", scope = "meta.class", hl_group = "Type" },
    { name = "Meta Class Body", scope = "meta.class.body", hl_group = "Normal" },
    { name = "Meta Method", scope = "meta.method", hl_group = "Function" },
    { name = "Meta Method Parameters", scope = "meta.method.parameters", hl_group = "Normal" },
    { name = "Meta Function", scope = "meta.function", hl_group = "Function" },
    { name = "Meta Function Parameters", scope = "meta.function.parameters", hl_group = "Normal" },
    { name = "Meta Block", scope = "meta.block", hl_group = "Normal" },
    { name = "Meta Braces", scope = "meta.braces", hl_group = "Delimiter" },
    { name = "Meta Brackets", scope = "meta.brackets", hl_group = "Delimiter" },
    { name = "Meta Parentheses", scope = "meta.parentheses", hl_group = "Delimiter" },
    { name = "Meta Array Literal", scope = "meta.array.literal", hl_group = "Normal" },
    { name = "Meta Object Literal", scope = "meta.object.literal", hl_group = "Normal" },
    { name = "Meta Group", scope = "meta.group", hl_group = "Normal" },
    { name = "Meta Tag", scope = "meta.tag", hl_group = "Tag" },
    { name = "Meta Attribute", scope = "meta.attribute", hl_group = "Normal" },
    { name = "Meta Preprocessor", scope = "meta.preprocessor", hl_group = "PreProc" },
    { name = "Meta Template", scope = "meta.template", hl_group = "Normal" },
    { name = "Meta Type", scope = "meta.type", hl_group = "Type" },
    { name = "Meta Type Annotation", scope = "meta.type.annotation", hl_group = "Type" },

    -- Support
    { name = "Support Class", scope = "support.class", hl_group = "Type" },
    { name = "Support Type", scope = "support.type", hl_group = "Type" },
    { name = "Support Function", scope = "support.function", hl_group = "Function" },
    { name = "Support Variable", scope = "support.variable", hl_group = "Identifier" },
    { name = "Support Constant", scope = "support.constant", hl_group = "Constant" },
    { name = "Support Other", scope = "support.other", hl_group = "Normal" },
    { name = "Support Module", scope = "support.module", hl_group = "Include" },
    { name = "Support Type Primitive", scope = "support.type.primitive", hl_group = "Type" },
    { name = "Support Type Built-in", scope = "support.type.builtin", hl_group = "Type" },
    { name = "Support Class Component", scope = "support.class.component", hl_group = "Type" },
    { name = "Support Variable Property", scope = "support.variable.property", hl_group = "Identifier" },
    { name = "Support Variable DOM", scope = "support.variable.dom", hl_group = "Identifier" },

    -- Invalid and Deprecated
    { name = "Invalid", scope = "invalid", hl_group = "Error" },
    { name = "Invalid Illegal", scope = "invalid.illegal", hl_group = "Error" },
    { name = "Invalid Deprecated", scope = "invalid.deprecated", hl_group = "Error" },
    { name = "Message Error", scope = "message.error", hl_group = "ErrorMsg" },

    -- Embedded
    { name = "Embedded Source", scope = "text.html.embedded", hl_group = "Normal" },
    { name = "Embedded SQL", scope = "text.html.embedded.sql", hl_group = "Normal" },
    { name = "Embedded CSS", scope = "source.css.embedded", hl_group = "Normal" },
    { name = "Embedded JS", scope = "source.js.embedded", hl_group = "Normal" },
    { name = "Embedded JSON", scope = "source.json.embedded", hl_group = "Normal" },
    { name = "Embedded Regex", scope = "source.regexp.embedded", hl_group = "Normal" },
    { name = "Embedded String", scope = "string.embedded", hl_group = "String" },

    -- Debug
    { name = "Debug", scope = "keyword.other.debugger", hl_group = "Debug" },
    { name = "Debug Function", scope = "support.function.debug", hl_group = "Debug" },

    -- Diff
    { name = "Diff Header", scope = "meta.diff.header", hl_group = "DiffChange" },
    { name = "Diff Range", scope = "meta.diff.range", hl_group = "DiffChange" },
    { name = "Diff Index", scope = "meta.diff.index", hl_group = "DiffChange" },
    { name = "Diff Added", scope = "markup.inserted", hl_group = "DiffAdd" },
    { name = "Diff Deleted", scope = "markup.deleted", hl_group = "DiffDelete" },
    { name = "Diff Changed", scope = "markup.changed", hl_group = "DiffChange" },

    -- Git
    { name = "Git Added", scope = "markup.inserted.git_gutter", hl_group = "DiffAdd" },
    { name = "Git Modified", scope = "markup.changed.git_gutter", hl_group = "DiffChange" },
    { name = "Git Deleted", scope = "markup.deleted.git_gutter", hl_group = "DiffDelete" },
    { name = "Git Ignored", scope = "markup.ignored.git_gutter", hl_group = "NonText" },
    { name = "Git Untracked", scope = "markup.untracked.git_gutter", hl_group = "NonText" },

    -- Log
    { name = "Log Entry", scope = "meta.log.entry", hl_group = "Normal" },
    { name = "Log Error", scope = "meta.log.error", hl_group = "Error" },
    { name = "Log Warning", scope = "meta.log.warning", hl_group = "WarningMsg" },
    { name = "Log Info", scope = "meta.log.info", hl_group = "Normal" },
    { name = "Log Debug", scope = "meta.log.debug", hl_group = "Debug" },

    -- Shell
    { name = "Shell Command", scope = "support.function.builtin.shell", hl_group = "Function" },
    { name = "Shell Variable", scope = "variable.other.special.shell", hl_group = "Identifier" },
    { name = "Shell Test Operator", scope = "keyword.operator.logical.shell", hl_group = "Operator" },
    { name = "Shell Brackets", scope = "punctuation.definition.logical-expression.shell", hl_group = "Delimiter" },
    { name = "Shell Option", scope = "string.other.option.shell", hl_group = "String" },

    -- Rust Language Scopes
    { name = "Source Rust", scope = "source.rust", hl_group = "Normal" },
    -- Rust Keywords
    { name = "Rust Keyword", scope = "keyword.other.rust", hl_group = "Keyword" },
    { name = "Rust Control", scope = "keyword.control.rust", hl_group = "Keyword" },
    { name = "Rust Unsafe", scope = "keyword.other.unsafe.rust", hl_group = "Keyword" },
    { name = "Rust Operator", scope = "keyword.operator.rust", hl_group = "Operator" },
    -- Rust Types
    { name = "Rust Type", scope = "storage.type.rust", hl_group = "Type" },
    { name = "Rust Type Primitive", scope = "storage.type.primitive.rust", hl_group = "Type" },
    { name = "Rust Type Core", scope = "storage.type.core.rust", hl_group = "Type" },
    { name = "Rust Type User-Defined", scope = "entity.name.type.rust", hl_group = "Type" },
    { name = "Rust Trait", scope = "entity.name.type.trait.rust", hl_group = "Type" },
    -- Rust Functions and Macros
    { name = "Rust Function", scope = "entity.name.function.rust", hl_group = "Function" },
    { name = "Rust Macro", scope = "entity.name.function.macro.rust", hl_group = "Macro" },
    { name = "Rust Macro Call", scope = "meta.macro.rust", hl_group = "Macro" },
    { name = "Rust Attribute", scope = "meta.attribute.rust", hl_group = "PreProc" },
    -- Rust Variables and Constants
    { name = "Rust Variable", scope = "variable.other.rust", hl_group = "Identifier" },
    { name = "Rust Constant", scope = "constant.other.rust", hl_group = "Constant" },
    { name = "Rust Self", scope = "variable.language.self.rust", hl_group = "Keyword" },
    { name = "Rust Static", scope = "storage.modifier.static.rust", hl_group = "StorageClass" },
    { name = "Rust Mut", scope = "storage.modifier.mut.rust", hl_group = "StorageClass" },
    -- Rust Strings and Characters
    { name = "Rust String", scope = "string.quoted.double.rust", hl_group = "String" },
    { name = "Rust Raw String", scope = "string.quoted.raw.rust", hl_group = "String" },
    { name = "Rust Character", scope = "string.quoted.single.char.rust", hl_group = "Character" },
    { name = "Rust Escape", scope = "constant.character.escape.rust", hl_group = "SpecialChar" },
    -- Rust Numbers
    { name = "Rust Number", scope = "constant.numeric.decimal.rust", hl_group = "Number" },
    { name = "Rust Float", scope = "constant.numeric.float.rust", hl_group = "Float" },
    { name = "Rust Integer", scope = "constant.numeric.integer.rust", hl_group = "Number" },
    { name = "Rust Hex", scope = "constant.numeric.hex.rust", hl_group = "Number" },
    { name = "Rust Binary", scope = "constant.numeric.binary.rust", hl_group = "Number" },
    { name = "Rust Octal", scope = "constant.numeric.octal.rust", hl_group = "Number" },
    -- Python Language Scopes
    { name = "Source Python", scope = "source.python", hl_group = "Normal" },
    { name = "Python Decorator", scope = "entity.name.function.decorator.python", hl_group = "PreProc" },
    { name = "Python Function", scope = "entity.name.function.python", hl_group = "Function" },
    { name = "Python Class", scope = "entity.name.type.class.python", hl_group = "Type" },
    { name = "Python Import", scope = "keyword.control.import.python", hl_group = "Include" },
    { name = "Python Self", scope = "variable.language.special.self.python", hl_group = "Keyword" },
    {
        name = "Python F-String",
        scope = "string.quoted.single.python constant.character.format.placeholder.other",
        hl_group = "SpecialChar",
    },

    -- JavaScript/TypeScript Language Scopes
    { name = "Source JavaScript", scope = "source.js", hl_group = "Normal" },
    { name = "Source TypeScript", scope = "source.ts", hl_group = "Normal" },
    { name = "JS/TS Class", scope = "entity.name.type.class.js", hl_group = "Type" },
    { name = "JS/TS Interface", scope = "entity.name.type.interface.ts", hl_group = "Type" },
    { name = "JS/TS Enum", scope = "entity.name.type.enum.ts", hl_group = "Type" },
    { name = "JS/TS Type", scope = "entity.name.type.ts", hl_group = "Type" },
    { name = "JS/TS Namespace", scope = "entity.name.type.namespace.ts", hl_group = "Type" },
    { name = "JS/TS Module", scope = "entity.name.type.module.ts", hl_group = "Type" },
    { name = "JS/TS Arrow Function", scope = "storage.type.function.arrow.js", hl_group = "Function" },
    { name = "JSX Tag", scope = "entity.name.tag.jsx", hl_group = "Tag" },
    { name = "TSX Tag", scope = "entity.name.tag.tsx", hl_group = "Tag" },

    -- C/C++ Language Scopes
    { name = "Source C", scope = "source.c", hl_group = "Normal" },
    { name = "Source C++", scope = "source.cpp", hl_group = "Normal" },
    { name = "C/C++ Class", scope = "entity.name.type.class.cpp", hl_group = "Type" },
    { name = "C/C++ Struct", scope = "entity.name.type.struct.cpp", hl_group = "Type" },
    { name = "C/C++ Enum", scope = "entity.name.type.enum.cpp", hl_group = "Type" },
    { name = "C/C++ Namespace", scope = "entity.name.namespace.cpp", hl_group = "Type" },
    { name = "C/C++ Template", scope = "entity.name.type.template.cpp", hl_group = "Type" },
    { name = "C/C++ Preprocessor", scope = "keyword.control.directive.cpp", hl_group = "PreProc" },

    -- Java Language Scopes
    { name = "Source Java", scope = "source.java", hl_group = "Normal" },
    { name = "Java Class", scope = "entity.name.type.class.java", hl_group = "Type" },
    { name = "Java Interface", scope = "entity.name.type.interface.java", hl_group = "Type" },
    { name = "Java Enum", scope = "entity.name.type.enum.java", hl_group = "Type" },
    { name = "Java Annotation", scope = "storage.type.annotation.java", hl_group = "PreProc" },
    { name = "Java Generic", scope = "entity.name.type.generic.java", hl_group = "Type" },

    -- Go Language Scopes
    { name = "Source Go", scope = "source.go", hl_group = "Normal" },
    { name = "Go Function", scope = "entity.name.function.go", hl_group = "Function" },
    { name = "Go Type", scope = "entity.name.type.go", hl_group = "Type" },
    { name = "Go Interface", scope = "entity.name.type.interface.go", hl_group = "Type" },
    { name = "Go Package", scope = "entity.name.package.go", hl_group = "Include" },

    -- Ruby Language Scopes
    { name = "Source Ruby", scope = "source.ruby", hl_group = "Normal" },
    { name = "Ruby Class", scope = "entity.name.type.class.ruby", hl_group = "Type" },
    { name = "Ruby Module", scope = "entity.name.type.module.ruby", hl_group = "Type" },
    { name = "Ruby Symbol", scope = "constant.other.symbol.ruby", hl_group = "Constant" },
    { name = "Ruby Block Parameter", scope = "variable.other.block.ruby", hl_group = "Identifier" },

    -- PHP Language Scopes
    { name = "Source PHP", scope = "source.php", hl_group = "Normal" },
    { name = "PHP Class", scope = "entity.name.type.class.php", hl_group = "Type" },
    { name = "PHP Interface", scope = "entity.name.type.interface.php", hl_group = "Type" },
    { name = "PHP Trait", scope = "entity.name.type.trait.php", hl_group = "Type" },
    { name = "PHP Namespace", scope = "entity.name.type.namespace.php", hl_group = "Type" },

    -- Swift Language Scopes
    { name = "Source Swift", scope = "source.swift", hl_group = "Normal" },
    { name = "Swift Class", scope = "entity.name.type.class.swift", hl_group = "Type" },
    { name = "Swift Protocol", scope = "entity.name.type.protocol.swift", hl_group = "Type" },
    { name = "Swift Extension", scope = "entity.name.type.extension.swift", hl_group = "Type" },
    { name = "Swift Enum", scope = "entity.name.type.enum.swift", hl_group = "Type" },

    -- Kotlin Language Scopes
    { name = "Source Kotlin", scope = "source.kotlin", hl_group = "Normal" },
    { name = "Kotlin Class", scope = "entity.name.type.class.kotlin", hl_group = "Type" },
    { name = "Kotlin Interface", scope = "entity.name.type.interface.kotlin", hl_group = "Type" },
    { name = "Kotlin Object", scope = "entity.name.type.object.kotlin", hl_group = "Type" },
    { name = "Kotlin Companion", scope = "entity.name.type.companion.kotlin", hl_group = "Type" },

    -- Scala Language Scopes
    { name = "Source Scala", scope = "source.scala", hl_group = "Normal" },
    { name = "Scala Class", scope = "entity.name.type.class.scala", hl_group = "Type" },
    { name = "Scala Object", scope = "entity.name.type.object.scala", hl_group = "Type" },
    { name = "Scala Trait", scope = "entity.name.type.trait.scala", hl_group = "Type" },
    { name = "Scala Type", scope = "entity.name.type.scala", hl_group = "Type" },

    -- Haskell Language Scopes
    { name = "Source Haskell", scope = "source.haskell", hl_group = "Normal" },
    { name = "Haskell Type", scope = "entity.name.type.haskell", hl_group = "Type" },
    { name = "Haskell Constructor", scope = "entity.name.tag.haskell", hl_group = "Constant" },
    { name = "Haskell Function", scope = "entity.name.function.haskell", hl_group = "Function" },
    { name = "Haskell Pragma", scope = "meta.preprocessor.haskell", hl_group = "PreProc" },

    -- Shell Script Scopes
    { name = "Source Shell", scope = "source.shell", hl_group = "Normal" },
    { name = "Shell Variable", scope = "variable.other.special.shell", hl_group = "Identifier" },
    { name = "Shell Function", scope = "entity.name.function.shell", hl_group = "Function" },
    { name = "Shell Command", scope = "keyword.other.command.shell", hl_group = "Statement" },
    { name = "Shell Parameter", scope = "variable.parameter.shell", hl_group = "Identifier" },

    -- HTML/CSS/XML Scopes
    { name = "Text HTML", scope = "text.html", hl_group = "Normal" },
    { name = "HTML Tag", scope = "entity.name.tag.html", hl_group = "Tag" },
    { name = "HTML Attribute", scope = "entity.other.attribute-name.html", hl_group = "Identifier" },
    { name = "CSS Class", scope = "entity.other.attribute-name.class.css", hl_group = "Identifier" },
    { name = "CSS ID", scope = "entity.other.attribute-name.id.css", hl_group = "Identifier" },
    { name = "CSS Property", scope = "support.type.property-name.css", hl_group = "Type" },
    { name = "CSS Value", scope = "support.constant.property-value.css", hl_group = "Constant" },
    { name = "CSS Unit", scope = "keyword.other.unit.css", hl_group = "Number" },
    { name = "CSS Color", scope = "constant.other.color.rgb-value.css", hl_group = "Number" },

    -- Markdown/Documentation Scopes
    { name = "Text Markdown", scope = "text.html.markdown", hl_group = "Normal" },
    { name = "Markdown Heading", scope = "markup.heading.markdown", hl_group = "Title" },
    { name = "Markdown List", scope = "markup.list.markdown", hl_group = "Statement" },
    { name = "Markdown Link", scope = "markup.underline.link.markdown", hl_group = "Underlined" },
    { name = "Markdown Code", scope = "markup.raw.block.markdown", hl_group = "String" },
    { name = "Markdown Bold", scope = "markup.bold.markdown", hl_group = "Bold" },
    { name = "Markdown Italic", scope = "markup.italic.markdown", hl_group = "Italic" },

    -- YAML/JSON/TOML Scopes
    { name = "Source YAML", scope = "source.yaml", hl_group = "Normal" },
    { name = "YAML Key", scope = "entity.name.tag.yaml", hl_group = "Identifier" },
    { name = "YAML Value", scope = "string.unquoted.yaml", hl_group = "String" },
    { name = "Source JSON", scope = "source.json", hl_group = "Normal" },
    { name = "JSON Key", scope = "support.type.property-name.json", hl_group = "Identifier" },
    { name = "Source TOML", scope = "source.toml", hl_group = "Normal" },
    { name = "TOML Key", scope = "keyword.key.toml", hl_group = "Identifier" },

    -- SQL Scopes
    { name = "Source SQL", scope = "source.sql", hl_group = "Normal" },
    { name = "SQL Keyword", scope = "keyword.other.sql", hl_group = "Keyword" },
    { name = "SQL Function", scope = "support.function.sql", hl_group = "Function" },
    { name = "SQL Table", scope = "entity.name.table.sql", hl_group = "Type" },
    { name = "SQL Column", scope = "entity.name.column.sql", hl_group = "Identifier" },

    -- Docker/Kubernetes Scopes
    { name = "Source Dockerfile", scope = "source.dockerfile", hl_group = "Normal" },
    { name = "Dockerfile Instruction", scope = "keyword.other.special-method.dockerfile", hl_group = "Keyword" },
    { name = "Source YAML Kubernetes", scope = "source.yaml.kubernetes", hl_group = "Normal" },

    -- GraphQL Scopes
    { name = "Source GraphQL", scope = "source.graphql", hl_group = "Normal" },
    { name = "GraphQL Type", scope = "entity.name.type.graphql", hl_group = "Type" },
    { name = "GraphQL Field", scope = "entity.name.field.graphql", hl_group = "Identifier" },
    { name = "GraphQL Directive", scope = "entity.name.directive.graphql", hl_group = "PreProc" },

    -- Proto Scopes
    { name = "Source Proto", scope = "source.proto", hl_group = "Normal" },
    { name = "Proto Message", scope = "entity.name.type.message.proto", hl_group = "Type" },
    { name = "Proto Service", scope = "entity.name.type.service.proto", hl_group = "Type" },
    { name = "Proto Field", scope = "variable.other.proto", hl_group = "Identifier" },
}

return M
