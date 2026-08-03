-- lvim-colorscheme.extra.ripgrep: generate a ripgrep config from the palette.
--
--     export RIPGREP_CONFIG_PATH=.../extras/ripgrep/LvimNord_dark.conf
--
-- ripgrep has no config-file discovery of its own: the file is whatever
-- RIPGREP_CONFIG_PATH points at, one CLI flag per line. Only --colors lines
-- are written, so pointing the variable here does not silently change your
-- search behaviour.
--
-- Colours go in as decimal r,g,b (24-bit); `intense` is deliberately unused
-- because ripgrep ignores it as soon as extended colours are in play.
--
---@module "lvim-colorscheme.extra.files.ripgrep"

local ansi = require("lvim-colorscheme.extra.ansi")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    local d = ansi.decimal
    return table.concat({
        "# " .. (colors._style_name or "Lvim"),
        "--colors=path:fg:" .. d(colors.blue),
        "--colors=path:style:bold",
        "--colors=line:fg:" .. d(colors.comment),
        "--colors=column:fg:" .. d(colors.comment),
        "--colors=match:fg:" .. d(colors.bg_dark),
        "--colors=match:bg:" .. d(colors.yellow),
        "--colors=match:style:nobold",
        "",
    }, "\n")
end

return M
