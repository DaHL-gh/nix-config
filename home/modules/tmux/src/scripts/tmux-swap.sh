#!/usr/bin/env bash
selected="$1"

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t "$selected_name" 2> /dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name"
fi

tmux switch-client -t "$selected_name"
