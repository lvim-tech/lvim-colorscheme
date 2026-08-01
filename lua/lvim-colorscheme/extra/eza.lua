-- lvim-colorscheme.extra.eza: generate an eza theme file from the lvim-colorscheme palette.
--
-- eza reads ONE theme, from `~/.config/eza/theme.yml` (or `$EZA_CONFIG_DIR/theme.yml`) — there is
-- no theme directory and no name to select, so the generated files are meant to be symlinked:
--
--     mkdir -p ~/.config/eza
--     ln -sf .../extras/eza/LvimNord_dark.yml ~/.config/eza/theme.yml
--
-- Colours are `#rrggbb`: eza's own `color_from_str` matches `['#', r1, r2, g1, g2, b1, b2]` before
-- it falls back to the named palette, so the hex goes in unchanged.
--
-- This is the newer of eza's two mechanisms. `EZA_COLORS` is the LS_COLORS-style environment
-- variable it still honours, but it can only carry ANSI escape parameters — every entry here that
-- needs a 24-bit value would have to be spelled as `38;2;r;g;b`, and the UI slots that have no
-- two-letter code could not be set at all.
--
-- Like the other terminal tools, every colour clears a contrast floor against the TERMINAL
-- background rather than the editor one (see extra/clipack.lua for why the two differ).
--
---@module "lvim-colorscheme.extra.eza"

local util = require("lvim-colorscheme.util")

local M = {}

--- Render one style entry. `spec` is a colour string, or a table `{ fg, bold, italic, underline }`.
---@param spec string|table
---@param indent string
---@return string
local function style(spec, indent)
    if type(spec) == "string" then
        spec = { fg = spec }
    end
    local out = indent .. 'foreground: "' .. spec.fg .. '"\n'
    if spec.bold then
        out = out .. indent .. "is_bold: true\n"
    end
    if spec.italic then
        out = out .. indent .. "is_italic: true\n"
    end
    if spec.underline then
        out = out .. indent .. "is_underline: true\n"
    end
    return out
end

--- Render a `key: {…}` section, or a bare style when `spec` has an `fg`.
---@param key string
---@param spec table|string
---@param indent string
---@return string
local function section(key, spec, indent)
    if type(spec) == "string" or spec.fg then
        return indent .. key .. ":\n" .. style(spec, indent .. "  ")
    end
    local out = indent .. key .. ":\n"
    -- Sorted so the generated file is stable across Lua's unordered pairs().
    local keys = vim.tbl_keys(spec)
    table.sort(keys)
    for _, k in ipairs(keys) do
        out = out .. section(k, spec[k], indent .. "  ")
    end
    return out
end

--- @param colors ColorScheme
--- @param _ table  highlight groups, unused: eza maps from the palette
--- @param opts table
function M.generate(colors, _, opts)
    local bg = colors.terminal.background
    local function c(color, min)
        return util.ensure_contrast(color, bg, min or 3)
    end

    local text = c(colors.terminal.foreground, 4.5)
    -- Two quieter tiers, placed RELATIVE to `text`. A fixed floor only pushes a colour away from
    -- the background, and `fg_soft_dark` is brighter than the terminal foreground in 12 of the 48
    -- styles (all of dracula, material and nightfox) — floored, the "dim" tier came out level with
    -- ordinary text. `text` clears 6:1 by construction, so these never sink below 3.6:1 / 2.2:1.
    local text_contrast = util.contrast(text, bg)
    local dim = util.to_contrast(colors.fg_soft_dark, bg, text_contrast * 0.6)
    local muted = util.to_contrast(colors.comment, bg, math.max(text_contrast * 0.35, 2.2))

    local blue = c(colors.blue)
    local cyan = c(colors.cyan)
    local green = c(colors.green)
    local yellow = c(colors.yellow)
    local orange = c(colors.orange)
    local red = c(colors.red)
    local magenta = c(colors.magenta)
    local teal = c(colors.teal)

    -- The file listing, top to bottom of a long-format row.
    local theme = {
        filekinds = {
            normal = text,
            directory = { fg = blue, bold = true },
            symlink = cyan,
            pipe = yellow,
            block_device = { fg = orange, bold = true },
            char_device = { fg = orange, bold = true },
            socket = { fg = magenta, bold = true },
            special = magenta,
            executable = { fg = green, bold = true },
            mount_point = { fg = teal, bold = true },
        },
        -- Permission bits: read / write / execute keep one colour each, so the column reads as a
        -- shape rather than a word.
        perms = {
            user_read = { fg = yellow, bold = true },
            user_write = { fg = red, bold = true },
            user_execute_file = { fg = green, bold = true },
            user_execute_other = { fg = green, bold = true },
            group_read = yellow,
            group_write = red,
            group_execute = green,
            other_read = dim,
            other_write = dim,
            other_execute = dim,
            special_user_file = magenta,
            special_other = muted,
            attribute = muted,
        },
        -- Size climbs with magnitude, so a big file is visible without reading the number. Units
        -- sit one tier quieter than the digits they follow.
        size = {
            major = { fg = orange, bold = true },
            minor = orange,
            number_byte = dim,
            number_kilo = green,
            number_mega = yellow,
            number_giga = orange,
            number_huge = { fg = red, bold = true },
            unit_byte = muted,
            unit_kilo = c(colors.green_dark),
            unit_mega = c(colors.yellow_dark),
            unit_giga = c(colors.orange_dark),
            unit_huge = c(colors.red_dark),
        },
        -- Ownership: yours is warm, root is a warning, everyone else recedes.
        users = {
            user_you = { fg = yellow, bold = true },
            user_root = { fg = red, bold = true },
            user_other = muted,
            group_yours = yellow,
            group_root = red,
            group_other = muted,
        },
        links = {
            normal = cyan,
            multi_link_file = { fg = orange, bold = true },
        },
        -- Git status column, matching the conventional add/change/remove reading.
        git = {
            new = green,
            modified = yellow,
            deleted = red,
            renamed = blue,
            typechange = magenta,
            ignored = muted,
            conflicted = { fg = red, bold = true },
        },
        git_repo = {
            branch_main = green,
            branch_other = yellow,
            git_clean = green,
            git_dirty = { fg = red, bold = true },
        },
        security_context = {
            none = muted,
            selinux = {
                colon = muted,
                user = blue,
                role = green,
                typ = yellow,
                range = cyan,
            },
        },
        -- Content classes, used when eza colours by file type.
        file_type = {
            image = magenta,
            video = { fg = orange, bold = true },
            music = cyan,
            lossless = teal,
            crypto = { fg = red, bold = true },
            document = blue,
            compressed = { fg = red, bold = true },
            temp = muted,
            compiled = yellow,
            build = orange,
            source = green,
        },
        -- Column furniture.
        punctuation = muted,
        date = teal,
        inode = muted,
        blocks = dim,
        header = { fg = text, bold = true, underline = true },
        octal = green,
        flags = muted,
        symlink_path = cyan,
        control_char = { fg = red, bold = true },
        broken_symlink = { fg = red, bold = true },
        broken_path_overlay = { fg = red, underline = true },
    }

    local body = ""
    local keys = vim.tbl_keys(theme)
    table.sort(keys)
    for _, k in ipairs(keys) do
        body = body .. section(k, theme[k], "")
    end

    colors.eza_theme_name = "Lvim" .. (opts.style:gsub("^%l", string.upper))

    return util.template(
        [[# ${_style_name}
# Generated by lvim-colorscheme for eza — https://github.com/eza-community/eza
#
# eza reads a single theme file, so pick one by symlinking it:
#   mkdir -p ~/.config/eza
#   ln -sf extras/eza/${eza_theme_name}.yml ~/.config/eza/theme.yml
#
# `filenames:` and `extensions:` are deliberately absent — they map globs to icons and
# per-name colours, which is a preference, not part of a palette. Adding either here would
# overwrite whatever you had set.

]],
        colors
    ) .. body
end

return M
