#!/usr/bin/env bash

TARGET="workspace"
CURRENT="$(tmux display-message -p '#S')"

if [[ "$CURRENT" == "$TARGET" ]]; then exit 0; fi

# Создать workspace, если её нет
if ! tmux has-session -t "$TARGET" 2>/dev/null; then
    tmux new-session -ds "$TARGET" -c "$HOME"
    tmux select-window -t "$selected_name"
fi

tmux switch-client -t "$TARGET"

tmux kill-session -t "$CURRENT"
