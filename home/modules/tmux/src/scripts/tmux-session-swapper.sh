#!/usr/bin/env bash

DIRS=(
    "projects"
    "projects/cpp"
    "projects/python"
    "projects/nix"
    "projects/web-programming"
    "Documents"
    "Documents/projects"
)

EXTRA=(
    ".config"
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

~/.config/tmux/scripts/tmux-swap.sh $selected
