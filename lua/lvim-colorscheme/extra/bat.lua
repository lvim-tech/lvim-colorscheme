local utils = require("lvim-colorscheme.utils")

local M = {}

function M.generate(colors)
    local kitty = utils.template(
        [[
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>name</key>
        <string>Catppuccin</string>
        <key>settings</key>
        <array>
            <dict>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${fg_05}</string>
                    <key>background</key>
                    <string>${bg_01}</string>
                    <key>caret</key>
                    <string>${fg_06}</string>
                    <key>invisibles</key>
                    <string>${fg_06}</string>
                    <key>gutterForeground</key>
                    <string>${bg_06}</string>
                    <key>gutterForegroundHighlight</key>
                    <string>${green_02}</string>
                    <key>lineHighlight</key>
                    <string>${bg_04}</string>
                    <key>selection</key>
                    <string>${bg_04}</string>
                    <key>selectionBorder</key>
                    <string>${orange_03}</string>
                    <key>activeGuide</key>
                    <string>${orange_01}</string>
                    <key>findHighlightForeground</key>
                    <string>${bg_03}</string>
                    <key>findHighlight</key>
                    <string>${fg_02}</string>
                    <key>bracketsForeground</key>
                    <string>${fg_03}</string>
                    <key>bracketContentsForeground</key>
                    <string>${fg_04}</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Comment</string>
                <key>scope</key>
                <string>comment</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${fg_03}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>String</string>
                <key>scope</key>
                <string>string</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${fg_04}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>String regex</string>
                <key>scope</key>
                <string>string.regexp</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${blue_03}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Number</string>
                <key>scope</key>
                <string>constant.numeric</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_03}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Boolean</string>
                <key>scope</key>
                <string>constant.language.boolean</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${blue_01}</string>
                    <key>fontStyle</key>
                    <string>bold italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Built-in constant</string>
                <key>scope</key>
                <string>constant.language</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_02}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Built-in function</string>
                <key>scope</key>
                <string>support.function.builtin</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_01}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>User-defined constant</string>
                <key>scope</key>
                <string>variable.other.constant</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_01}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Variable</string>
                <key>scope</key>
                <string>variable</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${blue_03}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Keyword</string>
                <key>scope</key>
                <string>keyword</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_01}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Conditional/loop</string>
                <key>scope</key>
                <string>keyword.control.loop, keyword.control.conditional, keyword.control.c++</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${orange_01}</string>
                    <key>fontStyle</key>
                    <string>bold</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Return</string>
                <key>scope</key>
                <string>keyword.control.return, keyword.control.flow.return</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_01}</string>
                    <key>fontStyle</key>
                    <string>bold</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Exception</string>
                <key>scope</key>
                <string>support.type.exception</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_03}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Operator</string>
                <key>scope</key>
                <string>keyword.operator, punctuation.accessor</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${orange_01}</string>
                    <key>fontStyle</key>
                    <string>bold</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Punctuation separator</string>
                <key>scope</key>
                <string>punctuation.separator</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${orange_01}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Punctuation terminator</string>
                <key>scope</key>
                <string>punctuation.terminator</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${orange_01}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Punctuation bracket</string>
                <key>scope</key>
                <string>punctuation.section</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_01}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Include</string>
                <key>scope</key>
                <string>keyword.control.import.include</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${blue_03}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Storage</string>
                <key>scope</key>
                <string>storage</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${red_01}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Storage type</string>
                <key>scope</key>
                <string>storage.type</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${orange_03}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Storage modifier</string>
                <key>scope</key>
                <string>storage.modifier</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_02}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Storage type namespace</string>
                <key>scope</key>
                <string>entity.name.namespace, meta.path</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${blue_03}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Storage type class</string>
                <key>scope</key>
                <string>storage.type.class</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${orange_03}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Label</string>
                <key>scope</key>
                <string>entity.name.label</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${red_03}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Keyword class</string>
                <key>scope</key>
                <string>keyword.declaration.class</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${orange_03}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Class name</string>
                <key>scope</key>
                <string>entity.name.class, meta.toc-list.full-identifier</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${cyan_03}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Inherited class</string>
                <key>scope</key>
                <string>entity.other.inherited-class</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${cyan_03}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Function name</string>
                <key>scope</key>
                <string>entity.name.function, variable.function</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${red_02}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Function macro</string>
                <key>scope</key>
                <string>entity.name.function.preprocessor</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${teal_01}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Macro directive - ifdef</string>
                <key>scope</key>
                <string>keyword.control.import</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${teal_01}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Constructor</string>
                <key>scope</key>
                <string>entity.name.function.constructor, entity.name.function.destructor</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${teal_01}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Function argument</string>
                <key>scope</key>
                <string>variable.parameter.function</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${red_02}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Function declaration</string>
                <key>scope</key>
                <string>keyword.declaration.function</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_03}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Library function</string>
                <key>scope</key>
                <string>support.function</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${red_02}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Library constant</string>
                <key>scope</key>
                <string>support.constant</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_02}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Library class/type</string>
                <key>scope</key>
                <string>support.type, support.class</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${orange_03}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Library variable</string>
                <key>scope</key>
                <string>support.other.variable</string>
                <key>settings</key>
                <dict>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Variable function</string>
                <key>scope</key>
                <string>variable.function</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${red_02}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Variable parameter</string>
                <key>scope</key>
                <string>variable.parameter</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${fg_06}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Variable other</string>
                <key>scope</key>
                <string>variable.other</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${fg_06}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Variable field</string>
                <key>scope</key>
                <string>variable.other.member</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${fg_06}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Variable language</string>
                <key>scope</key>
                <string>variable.language</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${fg_06}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Tag name</string>
                <key>scope</key>
                <string>entity.name.tag</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_01}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Tag attribute</string>
                <key>scope</key>
                <string>entity.other.attribute-name</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_01}</string>
                    <key>fontStyle</key>
                    <string>italic</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Tag delimiter</string>
                <key>scope</key>
                <string>punctuation.definition.tag</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${orange_01}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Markdown URL</string>
                <key>scope</key>
                <string>markup.underline.link.markdown</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${blue_02}</string>
                    <key>fontStyle</key>
                    <string>italic underline</string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Invalid</string>
                <key>scope</key>
                <string>invalid</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${bg_01}</string>
                    <key>background</key>
                    <string>${red_02}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Invalid deprecated</string>
                <key>scope</key>
                <string>invalid.deprecated</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${bg_01}</string>
                    <key>background</key>
                    <string>${orange_02}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Diff header</string>
                <key>scope</key>
                <string>meta.diff, meta.diff.header</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${fg_05}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Diff deleted</string>
                <key>scope</key>
                <string>markup.deleted</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${red_02}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Diff inserted</string>
                <key>scope</key>
                <string>markup.inserted</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${green_02}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Diff changed</string>
                <key>scope</key>
                <string>markup.changed</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${orange_03}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
            <dict>
                <key>name</key>
                <string>Message error</string>
                <key>scope</key>
                <string>message.error</string>
                <key>settings</key>
                <dict>
                    <key>foreground</key>
                    <string>${red_02}</string>
                    <key>fontStyle</key>
                    <string></string>
                </dict>
            </dict>
        </array>
        <key>uuid</key>
        <string>4d0379b5-ef82-467b-b8b8-365889420646</string>
        <key>colorSpaceName</key>
        <string>sRGB</string>
        <key>semanticClass</key>
        <string>theme.lvim</string>
        <key>author</key>
        <string>BiserStoilov</string>
    </dict>
</plist>
  ]],
        colors
    )
    return kitty
end

return M
