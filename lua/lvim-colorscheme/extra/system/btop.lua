-- lvim-colorscheme.extra.btop: generate a btop theme from the palette.
--
--     mkdir -p ~/.config/btop/themes
--     ln -sf .../extras/btop/LvimNord_dark.theme ~/.config/btop/themes/
--     # then in ~/.config/btop/btop.conf: color_theme = "LvimNord_dark"
--
-- The nine gradients are what btop actually renders with; giving each a
-- start/mid/end from the palette is why the meters look like the rest of the
-- desktop instead of like btop's own rainbow.
--
---@module "lvim-colorscheme.extra.system.btop"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    -- btop paints its own background (`main_bg`), so every colour that carries a WORD is floored
    -- against that and not against the terminal's. Measured before this existed, `inactive_fg` read
    -- at 1.94:1 and `graph_text` at 1.46:1 on their own panel — a legend that cannot be read is not
    -- a quieter tier, it is a missing one.
    --
    -- The nine gradients below are NOT floored and must not be: `temp_*`, `cpu_*`, `free_*`,
    -- `cached_*`, `available_*`, `used_*`, `download_*`, `upload_*` and `process_*` are the fill of
    -- a meter, `meter_bg` and `div_line` are a rule and a trough. Nothing is read against any of
    -- them, and flooring them would repaint every meter in the program to fix text that is not there.
    local function text(hex, bg)
        return util.ensure_contrast(hex, bg or colors.bg_dark, 4.5)
    end
    local t = vim.tbl_extend("force", colors, {
        btop_fg = text(colors.fg),
        btop_title = text(colors.fg_light),
        btop_hi = text(colors.blue),
        -- The selected row has a background of its own.
        btop_sel_fg = text(colors.fg_light, colors.bg_highlight),
        btop_inactive = text(colors.comment),
        btop_graph_text = text(colors.fg_dark),
        btop_proc_misc = text(colors.purple),
        -- A box colour draws the frame AND the box's name in the frame, so it is read.
        btop_cpu_box = text(colors.blue_dark),
        btop_mem_box = text(colors.green_dark),
        btop_net_box = text(colors.red_dark),
        btop_proc_box = text(colors.purple_dark),
    })
    return util.template(
        [[
# ${_style_name}
theme[main_bg]="${bg_dark}"
theme[main_fg]="${btop_fg}"
theme[title]="${btop_title}"
theme[hi_fg]="${btop_hi}"
theme[selected_bg]="${bg_highlight}"
theme[selected_fg]="${btop_sel_fg}"
theme[inactive_fg]="${btop_inactive}"
theme[graph_text]="${btop_graph_text}"
theme[meter_bg]="${bg_light}"
theme[proc_misc]="${btop_proc_misc}"
theme[cpu_box]="${btop_cpu_box}"
theme[mem_box]="${btop_mem_box}"
theme[net_box]="${btop_net_box}"
theme[proc_box]="${btop_proc_box}"
theme[div_line]="${bg_light}"
theme[temp_start]="${teal}"
theme[temp_mid]="${yellow}"
theme[temp_end]="${red}"
theme[cpu_start]="${green}"
theme[cpu_mid]="${yellow}"
theme[cpu_end]="${red}"
theme[free_start]="${green}"
theme[free_mid]="${green_dark}"
theme[free_end]="${teal}"
theme[cached_start]="${cyan}"
theme[cached_mid]="${cyan_dark}"
theme[cached_end]="${blue}"
theme[available_start]="${yellow}"
theme[available_mid]="${orange}"
theme[available_end]="${orange_dark}"
theme[used_start]="${red}"
theme[used_mid]="${red_dark}"
theme[used_end]="${magenta}"
theme[download_start]="${green}"
theme[download_mid]="${teal}"
theme[download_end]="${cyan}"
theme[upload_start]="${orange}"
theme[upload_mid]="${red}"
theme[upload_end]="${magenta}"
theme[process_start]="${blue}"
theme[process_mid]="${purple}"
theme[process_end]="${magenta}"
]],
        t
    )
end

return M
