#!/usr/bin/env bash

# Lvim Tmux Colors

set -g mode-style "fg=#70A9A8,bg=#364249"

set -g message-style "fg=#70A9A8,bg=#364249"
set -g message-command-style "fg=#70A9A8,bg=#364249"

set -g pane-border-style "fg=#364249"
set -g pane-active-border-style "fg=#70A9A8"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#70A9A8,bg=#20262A"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#E6C068,bg=#70A9A8,bold] #S #[fg=#70A9A8,bg=#20262A,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#20262A,bg=#20262A,nobold,nounderscore,noitalics]#[fg=#70A9A8,bg=#20262A] #{prefix_highlight} #[fg=#364249,bg=#20262A,nobold,nounderscore,noitalics]#[fg=#70A9A8,bg=#364249] %Y-%m-%d  %I:%M %p #[fg=#70A9A8,bg=#364249,nobold,nounderscore,noitalics]#[fg=#E6C068,bg=#70A9A8,bold] #h "

setw -g window-status-activity-style "underscore,fg=#F2AF5C,bg=#20262A"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#F2AF5C,bg=#20262A"
setw -g window-status-format "#[fg=#20262A,bg=#20262A,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#20262A,bg=#20262A,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#20262A,bg=#364249,nobold,nounderscore,noitalics]#[fg=#70A9A8,bg=#364249,bold] #I  #W #F #[fg=#364249,bg=#20262A,nobold,nounderscore,noitalics]"
  