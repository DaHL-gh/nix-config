#!/usr/bin/env bash

DIRS=(
    "$HOME/projects"
)

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected="$(for d in "${DIRS[@]}"; do find "$d" -mindepth 1 -maxdepth 1 -type d 2>/dev/null; done \
        | sed "s|^$HOME/||" \
        | sk --margin 10% --color="bw")"

    if [[ $selected ]] then
        selected="$HOME/$selected"
    else
        exit 0
    fi
fi

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name"
fi

tmux switch-client -t "$selected_name"
