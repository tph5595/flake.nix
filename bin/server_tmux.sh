#!/bin/bash

session="Monitor2"

if ! tmux ls | grep --quiet $session; then
      echo Creating tmux

      tmux new-session -d -s $session

      tmux rename-window -t $session "Server Monitor"
      tmux send-keys -t $session:$window "vtop" Enter
      tmux split-window -v
      tmux send-keys -t $session:$window "glances" Enter
fi
tmux attach -t $session
