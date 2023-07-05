# Lvim Tmux Colors

set -g status-bg "#FFFFFF"
set -g message-style fg='#6B8444'
set -g status-style fg='#6B8444'
set -g status-interval 1

set -g status-right ''
set -g status-right-length 0
set -g status-left-length 0

set-option -g pane-border-style fg='#6B8444'
set-option -ag pane-active-border-style fg='#6B8444'

set -g status-justify left

set-option -g status-left "\
#[fg=#FFFFFF, bg=#6B8444, bold]  #S\
#[fg=#FFFFFF, bg=#6B8444] #{?window_zoomed_flag,  ,}"

set-window-option -g window-status-current-format "\
#[bg=#FFFFFF, fg=#B52E1F, bold] #I: #W "

set-window-option -g window-status-format "\
#[bg=#FFFFFF, fg=#6B8444, bold] #I: #W "
  