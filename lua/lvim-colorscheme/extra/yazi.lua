-- lvim-colorscheme.extra.yazi: generate a Yazi flavor from the lvim-colorscheme palette.
--
-- Targets Yazi 26. Version 26 reshaped the theme schema, and a flavor written for 25 does not
-- merely lose styling — it aborts startup with a TOML parse error:
--
--   [manager]                    -> [mgr]
--   [completion]                 -> [cmp]
--   hovered / preview_hovered    -> [indicator] current / preview (and `parent`, new)
--   tab_active / tab_inactive    -> [tabs] active / inactive
--   tab_width                    -> gone
--   [status] separator_open/close-> [status] sep_left / sep_right, each { open, close }
--   [confirm] content            -> [confirm] body
--   [filetype] rules: name =     -> url =
--
-- CONTRAST. Every colour here clears a floor against whatever it is actually painted on, because
-- the palette's raw values do not. Measured across all 48 styles before this was added, the worst
-- case for each pair was:
--
--   count_selected  1.00:1   fg on teal_dark      — the same colour, invisible
--   count_copied    1.00:1   fg on green_dark     — likewise
--   normal_alt      1.04:1   blue on fg_soft_dark
--   cwd             1.42:1   fg_dark on bg        — the path bar, unreadable
--   normal_main     1.70:1   black on blue        — the mode indicator
--   perm_sep        1.89:1   comment on bg
--
-- Not one pair reached 3.05:1. These are EDITOR colours: `fg_dark` is tuned as the dimmest step of
-- a syntax palette, `black` as a terminal ANSI slot — neither was ever chosen to be read as UI text
-- on a coloured block, which is what Yazi does with them.
--
-- `[icon]` is deliberately not emitted. Yazi merges a flavor over its own preset, so leaving the
-- section out keeps upstream's icon set; writing one would freeze a glyph list into every palette.
-- `[flavor]` is likewise absent — that key selects a flavor, and a flavor selecting itself is
-- circular. The `sep_*` keys are left to the preset for the same reason: emitting empty strings,
-- as an earlier version did, overrode the preset's separators with nothing.
--
---@module "lvim-colorscheme.extra.yazi"

local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    local bg = colors.bg

    -- Text drawn straight onto the pane background.
    local function on_bg(color, min)
        return util.ensure_contrast(color, bg, min or 4.5)
    end

    -- Text drawn ON a coloured block. Starts from whichever of the palette's two poles already
    -- contrasts better with that block — a light block wants dark ink and vice versa — and then
    -- lifts it to the floor. Picking one pole unconditionally is what produced 1.70:1 on the light
    -- styles, where `black` is not actually the darker choice.
    local function ink(block, min)
        local dark, light = colors.bg_dark, colors.fg_light
        local base = dark
        if util.contrast(light, block) > util.contrast(dark, block) then
            base = light
        end
        return util.ensure_contrast(base, block, min or 4.5)
    end

    colors.bg_search = util.blend_bg(colors.info, 0.1)

    -- Blocks: the mode indicator, the counters and the progress bar all paint text on these.
    colors.yazi_block_alt = util.ensure_contrast(colors.bg_light, bg, 1.35)

    -- [mgr]
    colors.yazi_cwd = on_bg(colors.fg)
    colors.yazi_find_kw_fg = ink(colors.orange)
    colors.yazi_find_pos_fg = ink(colors.bg_search)
    colors.yazi_symlink = on_bg(colors.comment, 3)
    colors.yazi_border = util.ensure_contrast(colors.border_highlight, bg, 1.6)
    colors.yazi_count_copied = ink(colors.green_dark)
    colors.yazi_count_cut = ink(colors.red_dark)
    colors.yazi_count_selected = ink(colors.teal_dark)

    -- [indicator] — a wash behind the hovered row, not text. It only has to be visible as a band.
    colors.yazi_row_current = util.ensure_contrast(colors.bg_highlight, bg, 1.25)
    colors.yazi_row_parent = util.ensure_contrast(colors.bg_visual, bg, 1.15)

    -- [tabs] and [mode]
    colors.yazi_tab_active_fg = ink(colors.bg_highlight)
    colors.yazi_tab_inactive_fg = on_bg(colors.fg_soft_dark, 3.5)
    colors.yazi_mode_normal_fg = ink(colors.blue)
    colors.yazi_mode_select_fg = ink(colors.magenta)
    colors.yazi_mode_unset_fg = ink(colors.purple)
    colors.yazi_mode_normal_alt = util.ensure_contrast(colors.blue, colors.yazi_block_alt, 4.5)
    colors.yazi_mode_select_alt = util.ensure_contrast(colors.magenta, colors.yazi_block_alt, 4.5)
    colors.yazi_mode_unset_alt = util.ensure_contrast(colors.purple, colors.yazi_block_alt, 4.5)

    -- [status]
    colors.yazi_progress_fg = ink(colors.bg_dark, 4.5)
    colors.yazi_progress_err_fg = ink(colors.red)
    colors.yazi_perm_type = on_bg(colors.blue)
    colors.yazi_perm_read = on_bg(colors.yellow)
    colors.yazi_perm_write = on_bg(colors.red)
    colors.yazi_perm_exec = on_bg(colors.green)
    colors.yazi_perm_sep = on_bg(colors.comment, 3)

    -- Overlays: pickers, inputs, completion, tasks — all paint on the selection wash.
    colors.yazi_sel_fg = ink(colors.bg_visual)
    colors.yazi_overlay_border = on_bg(colors.blue_dark, 3)
    colors.yazi_input_value = on_bg(colors.purple)

    -- [which] draws over its own mask rather than the pane background.
    colors.yazi_which_cand = util.ensure_contrast(colors.cyan, colors.bg_dark, 4.5)
    colors.yazi_which_rest = util.ensure_contrast(colors.blue, colors.bg_dark, 4.5)
    colors.yazi_which_desc = util.ensure_contrast(colors.magenta, colors.bg_dark, 4.5)
    colors.yazi_which_sep = util.ensure_contrast(colors.comment, colors.bg_dark, 3)

    colors.yazi_notify_info = on_bg(colors.info)
    colors.yazi_notify_warn = on_bg(colors.warning)
    colors.yazi_notify_error = on_bg(colors.error)

    colors.yazi_help_on = on_bg(colors.green)
    colors.yazi_help_run = on_bg(colors.magenta)
    colors.yazi_help_desc = on_bg(colors.fg_soft_dark, 3.5)

    colors.yazi_spot_col = on_bg(colors.blue)
    colors.yazi_spot_cell = util.ensure_contrast(colors.yellow, colors.bg_visual, 4.5)

    -- [filetype] — the listing itself, which is the text read most.
    colors.yazi_ft_image = on_bg(colors.yellow)
    colors.yazi_ft_media = on_bg(colors.magenta)
    colors.yazi_ft_archive = on_bg(colors.red)
    colors.yazi_ft_doc = on_bg(colors.cyan)
    colors.yazi_ft_vfs = on_bg(colors.comment, 3)
    colors.yazi_ft_exec = on_bg(colors.green)
    colors.yazi_ft_dir = on_bg(colors.blue)

    return util.template(
        [[
#:schema https://yazi-rs.github.io/schemas/theme.json
# ${_style_name}
# Generated by lvim-colorscheme for Yazi 26 — https://github.com/sxyazi/yazi

[mgr]
cwd = { fg = "${yazi_cwd}", italic = true }

# Find
find_keyword  = { fg = "${yazi_find_kw_fg}", bg = "${orange}", bold = true }
find_position = { fg = "${yazi_find_pos_fg}", bg = "${bg_search}", bold = true }

# Symlink
symlink_target = { fg = "${yazi_symlink}", italic = true }

# Marker — a solid bar, so foreground and background match on purpose
marker_copied   = { fg = "${yellow_dark}", bg = "${yellow_dark}" }
marker_cut      = { fg = "${red}", bg = "${red}" }
marker_marked   = { fg = "${magenta}", bg = "${magenta}" }
marker_selected = { fg = "${blue}", bg = "${blue}" }
marker_symbol   = "│"

# Count
count_copied   = { fg = "${yazi_count_copied}", bg = "${green_dark}" }
count_cut      = { fg = "${yazi_count_cut}", bg = "${red_dark}" }
count_selected = { fg = "${yazi_count_selected}", bg = "${teal_dark}" }

# Border
border_symbol = "│"
border_style  = { fg = "${yazi_border}" }

# The row under the cursor in each pane. In 25 this was `hovered` and
# `preview_hovered` under [manager]; 26 gives the parent pane one of its own.
#
# `padding` is REQUIRED here, and it is required because of the `bg` above.
# components/entity.lua gives every row one leading space, except a hovered row
# whose style has a background — that case is handed `indicator.padding.open`
# instead, and the preset leaves it empty:
#
#   function Entity:padding()
#     if not self._file.is_hovered then return " " end
#     local style = self:style_rev()          -- non-nil only when the row has a bg
#     if style then return ui.Span(th.indicator.padding.open) else return " " end
#   end
#
# Upstream styles the hovered row with `reversed = true` and no background, so
# it never reaches that branch. A wash — which is what this palette wants, and
# what Yazi 25 did here — does reach it, and an empty padding then costs the
# hovered row a column and shifts its icon out of line with every other row.
[indicator]
parent  = { bg = "${yazi_row_parent}" }
current = { bg = "${yazi_row_current}" }
preview = { bg = "${yazi_row_current}" }
padding = { open = " ", close = " " }

[tabs]
active   = { fg = "${yazi_tab_active_fg}", bg = "${bg_highlight}", bold = true }
inactive = { fg = "${yazi_tab_inactive_fg}", bg = "${bg}" }

[mode]
normal_main = { fg = "${yazi_mode_normal_fg}", bg = "${blue}", bold = true }
normal_alt  = { fg = "${yazi_mode_normal_alt}", bg = "${yazi_block_alt}" }

select_main = { fg = "${yazi_mode_select_fg}", bg = "${magenta}", bold = true }
select_alt  = { fg = "${yazi_mode_select_alt}", bg = "${yazi_block_alt}" }

unset_main  = { fg = "${yazi_mode_unset_fg}", bg = "${purple}", bold = true }
unset_alt   = { fg = "${yazi_mode_unset_alt}", bg = "${yazi_block_alt}" }

[status]
# Progress
progress_label  = { fg = "${yazi_cwd}", bold = true }
progress_normal = { fg = "${yazi_progress_fg}", bg = "${bg_dark}" }
progress_error  = { fg = "${yazi_progress_err_fg}", bg = "${red}" }

# Permissions
perm_type  = { fg = "${yazi_perm_type}" }
perm_read  = { fg = "${yazi_perm_read}" }
perm_write = { fg = "${yazi_perm_write}" }
perm_exec  = { fg = "${yazi_perm_exec}" }
perm_sep   = { fg = "${yazi_perm_sep}" }

[pick]
border   = { fg = "${yazi_overlay_border}" }
active   = { fg = "${yazi_sel_fg}", bg = "${bg_visual}" }
inactive = { fg = "${yazi_cwd}" }

[input]
border   = { fg = "${yazi_overlay_border}" }
title    = { fg = "${yazi_overlay_border}" }
value    = { fg = "${yazi_input_value}" }
selected = { fg = "${yazi_sel_fg}", bg = "${bg_visual}" }

[cmp]
border   = { fg = "${yazi_overlay_border}" }
active   = { fg = "${yazi_sel_fg}", bg = "${bg_visual}" }
inactive = { fg = "${yazi_cwd}" }

icon_file    = ""
icon_folder  = ""
icon_command = ""

[tasks]
border  = { fg = "${yazi_border}" }
title   = { fg = "${yazi_cwd}" }
hovered = { fg = "${yazi_sel_fg}", bg = "${bg_visual}" }

[which]
cols            = 3
mask            = { bg = "${bg_dark}" }
cand            = { fg = "${yazi_which_cand}" }
rest            = { fg = "${yazi_which_rest}" }
desc            = { fg = "${yazi_which_desc}" }
separator       = " ➜ "
separator_style = { fg = "${yazi_which_sep}" }

[confirm]
border  = { fg = "${yazi_overlay_border}" }
title   = { fg = "${yazi_overlay_border}" }
body    = {}
list    = {}
btn_yes = { fg = "${yazi_sel_fg}", bg = "${bg_visual}" }
btn_no  = {}
btn_labels = [ "  [Y]es  ", "  (N)o  " ]

[spot]
border   = { fg = "${yazi_border}" }
title    = { fg = "${yazi_cwd}" }
tbl_col  = { fg = "${yazi_spot_col}" }
tbl_cell = { fg = "${yazi_spot_cell}", bg = "${bg_visual}" }

[notify]
title_info  = { fg = "${yazi_notify_info}" }
title_warn  = { fg = "${yazi_notify_warn}" }
title_error = { fg = "${yazi_notify_error}" }

icon_info  = ""
icon_warn  = ""
icon_error = ""

[help]
on      = { fg = "${yazi_help_on}" }
run     = { fg = "${yazi_help_run}" }
desc    = { fg = "${yazi_help_desc}" }
hovered = { fg = "${yazi_sel_fg}", bg = "${bg_visual}", bold = true }
footer  = { fg = "${yazi_tab_active_fg}", bg = "${bg_highlight}" }

[filetype]
rules = [
	# Images
	{ mime = "image/*", fg = "${yazi_ft_image}" },

	# Media
	{ mime = "{audio,video}/*", fg = "${yazi_ft_media}" },

	# Archives
	{ mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", fg = "${yazi_ft_archive}" },

	# Documents
	{ mime = "application/{pdf,doc,rtf}", fg = "${yazi_ft_doc}" },

	# Virtual file system — 26 reports unreachable remote entries through this
	{ mime = "vfs/{absent,stale}", fg = "${yazi_ft_vfs}" },

	# Special files. `url` here was `name` before 26.
	{ url = "*", is = "orphan", bg = "${red}" },
	{ url = "*", is = "exec"  , fg = "${yazi_ft_exec}" },
	{ url = "*", is = "dummy", bg = "${red}" },
	{ url = "*/", is = "dummy", bg = "${red}" },

	# Fallback
	{ url = "*/", fg = "${yazi_ft_dir}" }
]
    ]],
        colors
    )
end

return M
