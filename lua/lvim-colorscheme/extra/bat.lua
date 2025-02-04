local scope_mappings = require("lvim-colorscheme.extra.scope_mappings")

local M = {}

local function generate_uuid()
    math.randomseed(os.time())
    return string.gsub("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx", "[xy]", function(c)
        local v = (c == "x") and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format("%x", v)
    end)
end

local function get_hl_color(group)
    local hl = vim.api.nvim_get_hl(0, { name = group })
    return hl.fg and string.format("#%06x", hl.fg) or nil
end

local function get_hl_style(group)
    local hl = vim.api.nvim_get_hl(0, { name = group })
    local styles = {}
    if hl.bold then
        table.insert(styles, "bold")
    end
    if hl.italic then
        table.insert(styles, "italic")
    end
    if hl.underline then
        table.insert(styles, "underline")
    end
    return #styles > 0 and table.concat(styles, " ") or nil
end

local function create_scope_element(name, scope, settings, indent)
    indent = indent or "        "
    local lines = { indent .. "<dict>" }
    if name then
        table.insert(lines, indent .. "    <key>name</key>")
        table.insert(lines, indent .. "    <string>" .. name .. "</string>")
    end
    if scope then
        table.insert(lines, indent .. "    <key>scope</key>")
        table.insert(lines, indent .. "    <string>" .. scope .. "</string>")
    end
    table.insert(lines, indent .. "    <key>settings</key>")
    table.insert(lines, indent .. "    <dict>")
    for key, value in pairs(settings) do
        if value then
            table.insert(lines, indent .. "        <key>" .. key .. "</key>")
            table.insert(lines, indent .. "        <string>" .. value .. "</string>")
        end
    end
    table.insert(lines, indent .. "    </dict>")
    table.insert(lines, indent .. "</dict>")
    return table.concat(lines, "\n")
end

function M.generate(colors)
    if type(scope_mappings) ~= "table" or not scope_mappings.STANDARD_SCOPES then
        error("Invalid scope_mappings: expected a table with STANDARD_SCOPES")
    end
    local background = "dark"
    if colors._style == "light" then
        background = "light"
    end
    local theme_name = "Lvim" .. (colors._style:gsub("^%l", string.upper))
    local theme = {
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
        '<plist version="1.0">',
        "    <dict>",
        string.format("        <key>name</key>\n        <string>%s</string>", theme_name),
        "        <key>semanticClass</key>",
        string.format("        <string>theme.%s.custom</string>", background),
        "        <key>colorSpaceName</key>\n        <string>sRGB</string>",
        string.format("        <key>uuid</key>\n        <string>%s</string>", generate_uuid()),
        "        <key>settings</key>\n        <array>",
    }
    local editor_settings = {
        background = colors.bg,
        foreground = colors.fg,
        backgroundLight = colors.bg_light,
        backgroundSoftLight = colors.bg_soft_light,
        backgroundSoftDark = colors.bg_soft_dark,
        backgroundDark = colors.bg_dark,
        backgroundHighlight = colors.bg_highlight,
        foregroundLight = colors.fg_light,
        foregroundSoftLight = colors.fg_soft_light,
        foregroundSoftDark = colors.fg_soft_dark,
        foregroundDark = colors.fg_dark,
        caret = colors.cursor or colors.fg_light,
        lineHighlight = colors.cursor_line or colors.bg_highlight,
        selection = colors.visual or colors.bg_highlight,
        selectionBorder = colors.visual or colors.bg_highlight,
        invisibles = colors.non_text or colors.bg_dark,
        guide = colors.indent_guide or colors.bg_light,
        blue = colors.blue,
        blueDark = colors.blue_dark,
        green = colors.green,
        greenDark = colors.green_dark,
        cyan = colors.cyan,
        cyanDark = colors.cyan_dark,
        magenta = colors.magenta,
        magentaDark = colors.magenta_dark,
        orange = colors.orange,
        orangeDark = colors.orange_dark,
        yellow = colors.yellow,
        yellowDark = colors.yellow_dark,
        purple = colors.purple,
        purpleDark = colors.purple_dark,
        red = colors.red,
        redDark = colors.red_dark,
        teal = colors.teal,
        tealDark = colors.teal_dark,
        comment = colors.comment,
        terminalBackground = colors.terminal_bg,
        gitAdded = colors.git.add,
        gitModified = colors.git.change,
        gitDeleted = colors.git.delete,
        findHighlight = colors.yellow,
        findHighlightForeground = colors.bg_dark,
        bracketsForeground = colors.fg_light,
        bracketsOptions = "underline",
        bracketContentsForeground = colors.fg_light,
        bracketContentsOptions = "underline",
        tagsOptions = "stippled_underline",
    }
    table.insert(theme, create_scope_element(nil, "editor", editor_settings))
    for _, mapping in ipairs(scope_mappings.STANDARD_SCOPES) do
        local settings = { foreground = get_hl_color(mapping.hl_group) }
        local hl_style = get_hl_style(mapping.hl_group)
        if hl_style then
            settings.fontStyle = hl_style
        end
        if settings.foreground then
            table.insert(theme, create_scope_element(mapping.name, mapping.scope, settings))
        end
    end

    table.insert(theme, "        </array>")
    table.insert(theme, "    </dict>")
    table.insert(theme, "</plist>")

    return table.concat(theme, "\n")
end

return M
