local util = require("lvim-colorscheme.util")

local M = {}

local function remove_hash(color)
    if type(color) == "string" then
        return color:gsub("#", "")
    end
    return color
end

--- @param colors ColorScheme
function M.generate(colors)
    local clean_colors = {}
    for k, v in pairs(colors) do
        clean_colors[k] = remove_hash(v)
    end
    local vivid = util.template(
        [[
colors:
  black: "${yellow_dark}"
  green: "${green}"
  purple: "${purple}"
  red: "${red}"
  yellow: "${yellow}"
  cyan: "${cyan}"
  pink: "${teal}"
  orange: "${orange}"
  white: "${fg_soft_dark}"
core:
  normal_text:
    foreground: white
  regular_file:
    foreground: white
  reset_to_normal:
    foreground: orange
  directory:
    foreground: purple
  symlink:
    foreground: cyan
  multi_hard_link: {}
  fifo:
    foreground: yellow
    background: black
  socket:
    foreground: pink
    background: black
    font-style: bold
  door:
    foreground: pink
    background: black
    font-style: bold
  block_device:
    foreground: yellow
    background: black
    font-style: bold
  character_device:
    foreground: yellow
    background: black
    font-style: bold
  broken_symlink:
    foreground: red
    background: black
    font-style: bold
  missing_symlink_target:
    foreground: red
    background: black
  setuid:
    foreground: white
    background: red
  setgid:
    foreground: black
    background: yellow
  file_with_capability: {}
  sticky_other_writable:
    foreground: black
    background: green
  other_writable:
    foreground: purple
    background: green
  sticky:
    foreground: white
    background: purple
  executable_file:
    foreground: green
text:
  special:
    foreground: orange
  todo:
    foreground: orange
    font-style: bold
  licenses:
    foreground: orange
  configuration:
    foreground: orange
  other:
    foreground: orange
markup:
  foreground: orange
programming:
  foreground: orange
media:
  image:
    foreground: pink
  audio:
    foreground: cyan
  video:
    foreground: orange
    font-style: bold
  fonts:
    foreground: orange
  3d:
    foreground: pink
office:
  foreground: orange
archives:
  foreground: red
  font-style: bold
executable:
  foreground: green
unimportant:
  foreground: yellow
]], clean_colors)
    return vivid
end

return M
