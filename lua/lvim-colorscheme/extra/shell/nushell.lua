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
    -- Nushell writes no background of its own: every value below lands on the TERMINAL's, which
    -- this project themes from the same palette, so `terminal.background` is the honest surface
    -- rather than a guess. Measured across the 48 styles before this existed, 1955 of the 2592
    -- pairs here were under WCAG AA's 4.5:1.
    --
    -- Two keys are deliberately NOT floored, and they are the only two this proxy has to skip
    -- because each is read by exactly one line of the theme below:
    --
    --   * `bg_light` draws `separator`, the rules between table cells. It is a *background* key
    --     used as a line precisely so the data stands in front of it; flooring it puts a grid on
    --     the screen that nobody asked for.
    --   * `comment` draws `hints`, the inline autosuggestion of what you are about to type. It is
    --     ghost text: it has to be told apart from what has actually been typed, and a
    --     suggestion floored to 4.5:1 reads as typed. Measured worst case 1.99:1 on kanagawa_soft.
    --
    -- The `shape_*` keys ARE floored. They are the command line's syntax highlighting, but not the
    -- kind that carries a hierarchy — there is no receding tier among them, they are the same
    -- saturated accents the data colours use, and the same word coming out one colour while typed
    -- and another in the output table is what leaving them would buy.
    local function text(hex)
        return util.ensure_contrast(hex, colors.terminal.background, 4.5)
    end
    local t = setmetatable({}, {
        __index = function(_, k)
            local v = colors[k]
            if type(v) == "string" and v:match("^#%x%x%x%x%x%x$") and k ~= "bg_light" and k ~= "comment" then
                return text(v)
            end
            return v
        end,
    })

    -- The two places nushell paints a block and writes on it. `search_result` reverses the theme:
    -- the block is the palette's own `fg` and the match is written on it in red, which measured
    -- **1.05:1** on base_dark — the match was invisible in the block that exists to show it. The
    -- block does not move (a reversed match is what nushell means by it), so the red does, in
    -- whichever lightness direction that block leaves room in: `fg` sits mid-luminance on a dark
    -- palette and `ensure_contrast` picks its direction from the background alone, so it is the
    -- either-way walk that is needed here.
    --
    -- What that costs is worth saying: the block lands mid-luminance, and 4.5:1 against a surface
    -- at luminance L admits only text below (L+0.05)/4.5-0.05 or above 4.5*(L+0.05)-0.05, so on
    -- base_dark the red comes out #1c1616 and on everforest_soft #fdcdcd — the hue survives as a
    -- tint and no more. That is the whole room this block leaves; a red that stays red on it does
    -- not exist. It is one colour on one block, so nothing is lost that has to be told apart,
    -- which is why this is floored where `zellij`'s four ribbon emphases are not.
    --
    -- `shape_garbage` is the other way round — light text on the palette's red — and there the
    -- red itself gives a step of lightness where the text alone cannot reach, exactly as
    -- `extra/desktop/qutebrowser.lua` does with its message strips. hsluv holds the hue, so it
    -- stays red.
    local search_fg = util.ensure_contrast_either_way(colors.red, colors.fg, 4.5)
    local garbage_fg = util.ensure_contrast_either_way(colors.fg_light, colors.red, 4.5)
    local garbage_bg = util.ensure_contrast(colors.red, garbage_fg, 4.5)
    t = setmetatable({
        nu_search_fg = search_fg,
        nu_search_bg = colors.fg,
        nu_garbage_fg = garbage_fg,
        nu_garbage_bg = garbage_bg,
    }, getmetatable(t))

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
        search_result: { fg: "${nu_search_fg}" bg: "${nu_search_bg}" }

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
        shape_garbage: { fg: "${nu_garbage_fg}" bg: "${nu_garbage_bg}" attr: "b" }
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
        t
    )
end

return M
