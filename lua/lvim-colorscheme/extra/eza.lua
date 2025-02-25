local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    local eza = util.template(
        [[colourful: true

filekinds:
  normal: { foreground: "${fg_light}" }
  directory: { foreground: "${blue}" }
  symlink: { foreground: "${cyan}" }
  pipe: { foreground: "${bg_highlight}" }
  block_device: { foreground: "${yellow_dark}" }
  char_device: { foreground: "${yellow_dark}" }
  socket: { foreground: "${bg_highlight}" }
  special: { foreground: "${magenta}" }
  executable: { foreground: "${green}" }
  mount_point: { foreground: "${teal}" }

perms:
  user_read: { foreground: "${cyan}" }
  user_write: { foreground: "${magenta_dark}" }
  user_execute_file: { foreground: "${green}" }
  user_execute_other: { foreground: "${green}" }
  group_read: { foreground: "${cyan}" }
  group_write: { foreground: "${orange}" }
  group_execute: { foreground: "${green}" }
  other_read: { foreground: "${cyan}" }
  other_write: { foreground: "${red_dark}" }
  other_execute: { foreground: "${green}" }
  special_user_file: { foreground: "${red_dark}" }
  special_other: { foreground: "${red}" }
  attribute: { foreground: "${comment}" }

size:
  major: { foreground: "${cyan}" }
  minor: { foreground: "${magenta}" }
  number_byte: { foreground: "${fg_soft_light}" }
  number_kilo: { foreground: "${blue_dark}" }
  number_mega: { foreground: "${cyan}" }
  number_giga: { foreground: "${orange}" }
  number_huge: { foreground: "${red_dark}" }
  unit_byte: { foreground: "${fg_soft_light}" }
  unit_kilo: { foreground: "${blue_dark}" }
  unit_mega: { foreground: "${cyan}" }
  unit_giga: { foreground: "${orange}" }
  unit_huge: { foreground: "${red_dark}" }

users:
  user_you: { foreground: "${purple}" }
  user_root: { foreground: "${magenta_dark}" }
  user_other: { foreground: "${cyan}" }
  group_yours: { foreground: "${blue_dark}" }
  group_root: { foreground: "${magenta_dark}" }
  group_other: { foreground: "${fg_light}" }

links:
  normal: { foreground: "${blue_dark}" }
  multi_link_file: { foreground: "${cyan}" }

git:
  new: { foreground: "${green}" }
  modified: { foreground: "${magenta_dark}" }
  deleted: { foreground: "${red}" }
  renamed: { foreground: "${cyan}" }
  typechange: { foreground: "${cyan}" }
  ignored: { foreground: "${comment}" }
  conflicted: { foreground: "${orange}" }

git_repo:
  branch_main: { foreground: "${comment}" }
  branch_other: { foreground: "${teal}" }
  git_clean: { foreground: "${bg_dark}" }
  git_dirty: { foreground: "${magenta_dark}" }

security_context:
  colon: { foreground: "${comment}" }
  user: { foreground: "${comment}" }
  role: { foreground: "${cyan}" }
  typ: { foreground: "${purple}" }
  range: { foreground: "${magenta}" }

file_type:
  image: { foreground: "${blue_dark}" }
  video: { foreground: "${teal}" }
  music: { foreground: "${green_dark}" }
  lossless: { foreground: "${teal_dark}" }
  crypto: { foreground: "${red}" }
  document: { foreground: "${fg_soft_light}" }
  compressed: { foreground: "${orange}" }
  temp: { foreground: "${comment}" }
  compiled: { foreground: "${comment}" }
  build: { foreground: "${green_dark}" }
  source: { foreground: "${magenta_dark}" }

punctuation: { foreground: "${bg_dark}" }
date: { foreground: "${yellow_dark}" }
inode: { foreground: "${comment}" }
blocks: { foreground: "${comment}" }
header: { foreground: "${fg_soft_light}" }
octal: { foreground: "${orange}" }
flags: { foreground: "${magenta}" }

symlink_path: { foreground: "${blue_dark}" }
control_char: { foreground: "${orange}" }
broken_symlink: { foreground: "${red_dark}" }
broken_path_overlay: { foreground: "${red_dark}" }]],
        colors
    )
    return eza
end

return M
