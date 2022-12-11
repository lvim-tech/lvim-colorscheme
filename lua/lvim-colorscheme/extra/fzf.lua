local utils = require("lvim-colorscheme.utils")

local M = {}

function M.generate(colors)
    local kitty = utils.template(
        [[
# Lvim FZF Colors


export FZF_DEFAULT_OPTS="
--preview='bat --style numbers,changes --color=always {}'
--preview-window=noborder
--border=none
--separator=""
--info inline
--color=fg:${fg_03},bg:${bg_statusline},hl:${orange_02},fg+:${fg_05},bg+:${bg_statusline},hl+:${orange_02} 
--color=pointer:${red_02},info:${orange_02},spinner:${orange_02},header:${orange_02},prompt:${green_02},marker:${red_02}
"
  ]],
        colors
    )
    return kitty
end

return M
