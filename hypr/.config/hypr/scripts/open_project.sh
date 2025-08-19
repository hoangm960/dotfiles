#!/bin/bash

PROJECT_ROOTS=(~ /run/media/meng/Data/Programming)

find_projects() {
  for root in "${PROJECT_ROOTS[@]}"; do
    expanded_path=$(eval echo "$root")
    find "$expanded_path" -mindepth 1 -maxdepth 3 \
      -type d \( -name ".git" -o -name ".tmuxinator" \) -printf '%h\n' 2>/dev/null
  done | sort -u | xargs -r stat -c '%Y %n' | sort -rn | cut -d' ' -f2-
}

selected_project=$(find_projects | fzf --preview="ls -F {}" --cycle --header "Select a project directory")
[[ -z "$selected_project" ]] && exit 0

configs=$(tmuxinator list | tail -n +2 | awk '{$1=$1;print}')
[[ -z "$configs" ]] && { echo "No tmuxinator configs found" >&2; exit 1; }

selected_config=$(printf "%s\n" $configs | fzf --header "Select a tmuxinator config")
[[ -z "$selected_config" ]] && exit 0

cd "$selected_project" || exit 1
export PROJECT_DIR="$selected_project"

tmuxinator start "$selected_config"
