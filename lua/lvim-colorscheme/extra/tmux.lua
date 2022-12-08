local utils = require("lvim-colorscheme.utils")

local M = {}

function M.generate(colors)
    local tmux = utils.template(
        [[
# Lvim Tmux Colors

set -g status-bg "${bg_01}"
set -g message-style fg='${green_02}'
set -g status-style fg='${green_02}'
set -g status-interval 1

set -g status-right ''
set -g status-right-length 0
set -g status-left-length 0

set-option -g pane-border-style fg='${green_02}'
set-option -ag pane-active-border-style fg='${green_02}'

set -g status-justify left

set-option -g status-left "\
#[fg=${bg_01}, bg=${green_02}, bold]  #S\
#[fg=${bg_01}, bg=${green_02}] #{?window_zoomed_flag,  ,}"

set-window-option -g window-status-current-format "\
#[bg=${bg_01}, fg=${red_02}, bold] #I: #W "

set-window-option -g window-status-format "\
#[bg=${bg_01}, fg=${green_02}, bold] #I: #W "
  ]],
        colors
    )
    return tmux
end

return M
