#!/bin/bash

PROJECT_ROOTS=(~ /run/media/meng/Data/Programming)

find_projects() {
  for root in "${PROJECT_ROOTS[@]}"; do
    expanded_path=$(eval echo "$root")
    find "$expanded_path" -mindepth 1 -maxdepth 3 \
      -type d \( -name ".git" -o -name ".tmuxinator" \) -printf '%h\n' 2>/dev/null
  done | sort -u | while read -r dir; do
    has_frontend=0
    has_backend=0
    for child in "$dir"/*; do
      [[ -d "$child" ]] || continue
      case "$child" in
        *frontend*) has_frontend=1 ;;
        *backend*) has_backend=1 ;;
      esac
    done
    [[ $has_frontend -eq 1 && $has_backend -eq 1 ]] || continue
    if [[ -f "$dir/.hypr_last_opened" ]]; then
      timestamp=$(stat -c '%Y' "$dir/.hypr_last_opened")
    else
      timestamp=$(stat -c '%Y' "$dir")
    fi
    echo "$timestamp $dir"
  done | sort -rn | cut -d' ' -f2-
}

selected_project=$(find_projects | fzf --preview="ls -F {}" --cycle --header "Select a project directory")
[[ -z "$selected_project" ]] && exit 0

configs=$(tmuxinator list | tail -n +2 | awk '{$1=$1;print}')
[[ -z "$configs" ]] && { echo "No tmuxinator configs found" >&2; exit 1; }

selected_config=$(printf "%s\n" $configs | fzf --header "Select a tmuxinator config")
[[ -z "$selected_config" ]] && exit 0

cd "$selected_project" || exit 1
touch "$selected_project/.hypr_last_opened"
export PROJECT_DIR="$selected_project"

tmuxinator start "$selected_config"
