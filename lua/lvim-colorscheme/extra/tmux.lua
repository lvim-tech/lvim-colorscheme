local util = require("lvim-colorscheme.util")

local M = {}

function M.generate(colors)
    local tmux = util.template(
        [[
#!/usr/bin/env bash

# Lvim Tmux Colors

set -g mode-style "fg=${color_13},bg=${color_04}"

set -g message-style "fg=${color_13},bg=${color_04}"
set -g message-command-style "fg=${color_13},bg=${color_04}"

set -g pane-border-style "fg=${color_04}"
set -g pane-active-border-style "fg=${color_13}"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=${color_13},bg=${bg_statusline}"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style ${none}
set -g status-right-style ${none}

set -g status-left "#[fg=${color_23},bg=${color_13},bold] #S #[fg=${color_13},bg=${bg_statusline},nobold,nounderscore,noitalics]"
set -g status-right "#[fg=${bg_statusline},bg=${bg_statusline},nobold,nounderscore,noitalics]#[fg=${color_13},bg=${bg_statusline}] #{prefix_highlight} #[fg=${color_04},bg=${bg_statusline},nobold,nounderscore,noitalics]#[fg=${color_13},bg=${color_04}] %Y-%m-%d  %I:%M %p #[fg=${color_13},bg=${color_04},nobold,nounderscore,noitalics]#[fg=${color_23},bg=${color_13},bold] #h "

setw -g window-status-activity-style "underscore,fg=${fg_sidebar},bg=${bg_statusline}"
setw -g window-status-separator ""
setw -g window-status-style "${none},fg=${fg_sidebar},bg=${bg_statusline}"
setw -g window-status-format "#[fg=${bg_statusline},bg=${bg_statusline},nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=${bg_statusline},bg=${bg_statusline},nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=${bg_statusline},bg=${color_04},nobold,nounderscore,noitalics]#[fg=${color_13},bg=${color_04},bold] #I  #W #F #[fg=${color_04},bg=${bg_statusline},nobold,nounderscore,noitalics]"
  ]],
        colors
    )
    return tmux
end

return M
