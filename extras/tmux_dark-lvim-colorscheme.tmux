# Lvim Tmux Colors

set -g status-bg "#1a2126"
set -g message-style fg='#93ac6c'
set -g status-style fg='#93ac6c'
set -g status-interval 1

set -g status-right ''
set -g status-right-length 0
set -g status-left-length 0

set-option -g pane-border-style fg='#93ac6c'
set-option -ag pane-active-border-style fg='#93ac6c'

set -g status-justify left

set-option -g status-left "\
#[fg=#1a2126, bg=#93ac6c, bold]  #S\
#[fg=#1a2126, bg=#93ac6c] #{?window_zoomed_flag,  ,}"

set-window-option -g window-status-current-format "\
#[bg=#1a2126, fg=#dd5647, bold] #I: #W "

set-window-option -g window-status-format "\
#[bg=#1a2126, fg=#93ac6c, bold] #I: #W "
  