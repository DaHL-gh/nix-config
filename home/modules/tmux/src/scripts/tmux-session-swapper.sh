#!/usr/bin/env bash

DIRS=(
    "Documents/projects"
    # "Documents/projects/pytorch"
)

EXTRA=(
    ".config"
    "Documents/nix-config"
    "Documents/Obsidian"
    "Documents/spell-cast"
)

selected="$( \
    {
    for d in "${DIRS[@]}"; do \
        find "$HOME/$d" -mindepth 1 -maxdepth 1 -type d 2>/dev/null; \
    done
    for d in "${EXTRA[@]}"; do \
        echo "$HOME/$d"; \
    done
    } \
    | sed "s|^$HOME/||" \
    | grep -Fvx -f <(printf '%s\n' "${DIRS[@]}") \
    | sort \
    | sk --margin 20% --color="bw" 
)"

if [[ $selected ]]; then
    selected="$HOME/$selected"
else
    exit 0
fi

tmux_swap() {
    local selected="$1"

    local selected_name
    selected_name=$(basename "$selected" | tr . _)

    if ! tmux has-session -t "$selected_name" 2>/dev/null; then
        tmux new-session -ds "$selected_name" -c "$selected"
        tmux select-window -t "$selected_name"
    fi

    tmux switch-client -t "$selected_name"
}

tmux_swap $selected
