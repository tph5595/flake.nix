#!/bin/bash

session="Monitor"

if ! tmux ls | grep --quiet $session; then
      echo Creating tmux

      tmux new-session -d -s $session

      tmux rename-window -t $session "Monitor1"
      tmux send-keys -t $session:$window "poetry run python3 main.py" Enter
      tmux split-window -v
      tmux send-keys -t $session:$window "glances" Enter
fi
tmux attach -t $session
