# Lvim Tmux Colors

set -g status-bg "#1E2624"
set -g message-style fg='#8AA55F'
set -g status-style fg='#8AA55F'
set -g status-interval 1

set -g status-right ''
set -g status-right-length 0
set -g status-left-length 0

set-option -g pane-border-style fg='#8AA55F'
set-option -ag pane-active-border-style fg='#8AA55F'

set -g status-justify left

set-option -g status-left "\
#[fg=#1E2624, bg=#8AA55F, bold]  #S\
#[fg=#1E2624, bg=#8AA55F] #{?window_zoomed_flag,  ,}"

set-window-option -g window-status-current-format "\
#[bg=#1E2624, fg=#D64636, bold] #I: #W "

set-window-option -g window-status-format "\
#[bg=#1E2624, fg=#8AA55F, bold] #I: #W "
  