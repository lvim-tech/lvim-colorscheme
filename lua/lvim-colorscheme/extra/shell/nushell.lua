-- lvim-colorscheme.extra.nushell: generate a nushell colour theme from the
-- palette.
--
--     mkdir -p ~/.config/nushell/themes
--     ln -sf .../extras/nushell/LvimNord_dark.nu ~/.config/nushell/themes/lvim.nu
--     # then in config.nu:
--     #   use ~/.config/nushell/themes/lvim.nu
--     #   $env.config.color_config = (lvim)
--
-- Nushell has no theme FILE format: a theme is a module returning a record,
-- which is why this emits a `def main` rather than data. The `use` + assign
-- pair above is the convention nu_scripts established.
--
---@module "lvim-colorscheme.extra.shell.nushell"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    return util.template(
        [[
# ${_style_name}
export def main [] {
    return {
        separator: "${bg_light}"
        leading_trailing_space_bg: { attr: "n" }
        header: { fg: "${green}" attr: "b" }
        empty: "${blue}"
        bool: "${cyan}"
        int: "${purple}"
        filesize: "${cyan}"
        duration: "${fg}"
        date: "${magenta}"
        range: "${fg}"
        float: "${fg}"
        string: "${fg}"
        nothing: "${red}"
        binary: "${purple}"
        cell-path: "${fg}"
        row_index: { fg: "${green}" attr: "b" }
        record: "${fg}"
        list: "${fg}"
        block: "${fg}"
        hints: "${comment}"
        search_result: { fg: "${red}" bg: "${fg}" }

        shape_and: { fg: "${purple}" attr: "b" }
        shape_binary: { fg: "${purple}" attr: "b" }
        shape_block: { fg: "${blue}" attr: "b" }
        shape_bool: "${cyan}"
        shape_closure: { fg: "${green}" attr: "b" }
        shape_custom: "${green}"
        shape_datetime: { fg: "${cyan}" attr: "b" }
        shape_directory: "${cyan}"
        shape_external: "${cyan}"
        shape_externalarg: { fg: "${green}" attr: "b" }
        shape_external_resolved: { fg: "${yellow}" attr: "b" }
        shape_filepath: "${cyan}"
        shape_flag: { fg: "${blue}" attr: "b" }
        shape_float: { fg: "${purple}" attr: "b" }
        shape_garbage: { fg: "${fg_light}" bg: "${red}" attr: "b" }
        shape_glob_interpolation: { fg: "${cyan}" attr: "b" }
        shape_globpattern: { fg: "${cyan}" attr: "b" }
        shape_int: { fg: "${purple}" attr: "b" }
        shape_internalcall: { fg: "${cyan}" attr: "b" }
        shape_keyword: { fg: "${purple}" attr: "b" }
        shape_list: { fg: "${cyan}" attr: "b" }
        shape_literal: "${blue}"
        shape_match_pattern: "${green}"
        shape_matching_brackets: { attr: "u" }
        shape_nothing: "${cyan}"
        shape_operator: "${yellow}"
        shape_or: { fg: "${purple}" attr: "b" }
        shape_pipe: { fg: "${purple}" attr: "b" }
        shape_range: { fg: "${yellow}" attr: "b" }
        shape_record: { fg: "${cyan}" attr: "b" }
        shape_redirection: { fg: "${purple}" attr: "b" }
        shape_signature: { fg: "${green}" attr: "b" }
        shape_string: "${green}"
        shape_string_interpolation: { fg: "${cyan}" attr: "b" }
        shape_table: { fg: "${blue}" attr: "b" }
        shape_variable: "${purple}"
        shape_vardecl: "${purple}"
    }
}
]],
        colors
    )
end

return M
