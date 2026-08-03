-- lvim-colorscheme.extra.lazydocker: generate a Lazydocker theme/colour config from the lvim-colorscheme palette.
--
---@module "lvim-colorscheme.extra.lazydocker"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    colors.bg_line = util.blend_bg(colors.bg_highlight, 0.1)
    -- A palette FRAGMENT, not a standalone file: lazydocker reads exactly one
    -- config.yml and has no include or multi-file mechanism, so clipack's
    -- config.sh appends these keys under the `theme:` line that base.yml
    -- deliberately ends with. The settings this used to carry (logs,
    -- commandTemplates, stats graphs, ...) are that base.yml.
    local lazydocker = util.template(
        [[# Palette fragment — appended under `gui: theme:` at the end of base.yml
# by clipack's config.sh. Not a complete lazydocker configuration.
    activeBorderColor:
      - "${orange}"
      - "bold"
    inactiveBorderColor:
      - "${border_highlight}"
    selectedLineBgColor:
      - "${bg_line}"
    optionsTextColor:
      - "${blue}"]],
        colors
    )
    return lazydocker
end

return M
