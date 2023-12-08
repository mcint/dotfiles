#!/bin/env bash

#tmux new-session -A -s spdf
# -s session  -> session
# -t session  -> session-0

tmux new-session -s spdf
tmux 
# rename-window -t 0 meta
# new-window -T ocf  # read; mosh ocf
# new-window -T ponzi  # read; mosh ponzi
