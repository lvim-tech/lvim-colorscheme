local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  colors.bg_search = util.blend_bg(colors.info, 0.1)
  local yazi = util.template([[
[manager]
cwd = { fg = "${fg_dark}", italic = true }

# Hovered
hovered         = { bg = "${bg_highlight}" }
preview_hovered = { bg = "${bg_highlight}" }

# Find
find_keyword  = { fg = "${bg_dark}", bg = "${orange}", bold = true }
find_position = { fg = "${blue_dark}", bg = "${bg_search}", bold = true }

# Marker
marker_copied   = { fg = "${yellow_dark}", bg = "${yellow_dark}" }
marker_cut      = { fg = "${red}", bg = "${red}" }
marker_marked   = { fg = "${magenta}", bg = "${magenta}" }
marker_selected = { fg = "${blue}", bg = "${blue}" }

# Tab
tab_active   = { fg = "${fg}", bg = "${bg_highlight}" }
tab_inactive = { fg = "${fg_soft_dark}", bg = "${bg}" }
tab_width    = 1

# Count
count_copied   = { fg = "${fg}", bg = "${green_dark}" }
count_cut      = { fg = "${fg}", bg = "${red_dark}" }
count_selected = { fg = "${fg}", bg = "${teal_dark}" }

# Border
border_symbol = "│"
border_style  = { fg = "${border_highlight}" }

[mode]
normal_main = { fg = "${black}", bg = "${blue}", bold = true }
normal_alt  = { fg = "${blue}", bg = "${fg_soft_dark}" }

select_main = { fg = "${black}", bg = "${magenta}", bold = true }
select_alt  = { fg = "${magenta}", bg = "${fg_soft_dark}" }

unset_main  = { fg = "${black}", bg = "${purple}", bold = true }
unset_alt   = { fg = "${purple}", bg = "${fg_soft_dark}" }

[status]
separator_open    = ""
separator_close   = ""
# separator_style = { fg = "${fg_soft_dark}", bg = "${fg_soft_dark}" }

# Progress
progress_label  = { fg = "${fg_dark}", bold = true }
progress_normal = { fg = "${bg}" }
progress_error  = { fg = "${red}" }

# Permissions
perm_type  = { fg = "${blue}" }
perm_read  = { fg = "${yellow}" }
perm_write = { fg = "${red}" }
perm_exec  = { fg = "${green}" }
perm_sep   = { fg = "${comment}" }

[pick]
border   = { fg = "${border_highlight}" }
active   = { fg = "${fg}",  bg = "${bg_visual}" }
inactive = { fg = "${fg}" }

# Input
[input]
border   = { fg = "${blue_dark}" }
title    = { fg = "${blue_dark}" }
value    = { fg = "${purple}" }
selected = { bg = "${bg_visual}" }

# Completion
[completion]
border   = { fg = "${blue_dark}" }
active   = { fg = "${fg}", bg = "${bg_visual}" }
inactive = { fg = "${fg}" }

icon_file    = ""
icon_folder  = ""
icon_command = ""

# Tasks
[tasks]
border  = { fg = "${border_highlight}" }
title   = { fg = "${border_highlight}" }
hovered = { fg = "${fg}", bg="${bg_visual}" }

# Which
[which]
cols            = 3
mask            = { bg = "${bg_dark}" }
cand            = { fg = "${cyan}" }
rest            = { fg = "${blue}" }
desc            = { fg = "${magenta}" }
separator       = " ➜ "
separator_style = { fg = "${comment}" }

# Confirm
[confirm]
border  = { fg = "${blue_dark}" }
title   = { fg = "${border_highlight}" }
content = {}
list    = {}
btn_yes = { bg = "${bg_visual}" }
btn_no  = {}
btn_labels = [ "  [Y]es  ", "  (N)o  " ]

# Spot
[spot]
border  = { fg = "${border_highlight}" }
title   = { fg = "${border_highlight}" }

# Notify
[notify]
title_info  = { fg = "${info}" }
title_warn  = { fg = "${warning}" }
title_error = { fg = "${error}" }

icon_error = ""
icon_warn = ""
icon_info = ""

# Help
[help]
on      = { fg = "${green}" }
run     = { fg = "${magenta}" }
hovered = { bg = "${bg_highlight}" }
footer  = { fg = "${fg}", bg = "${bg}" }

[filetype]

rules = [
	# Images
	{ mime = "image/*", fg = "${yellow}" },

	# Media
	{ mime = "{audio,video}/*", fg = "${magenta}" },

	# Archives
	{ mime = "application/*zip", fg = "${red}" },
	{ mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}", fg = "${red}" },

	# Documents
	{ mime = "application/{pdf,doc,rtf,vnd.*}", fg = "${cyan}" },

	# Empty files
	# { mime = "inode/x-empty", fg = "${red}" },

	# Special files
	{ name = "*", is = "orphan", bg = "${red}" },
	{ name = "*", is = "exec"  , fg = "${green}" },

	# Fallback
	{ name = "*/", fg = "${blue}" }
]
    ]], colors)
  return yazi
end

return M
