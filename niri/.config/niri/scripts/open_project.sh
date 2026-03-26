#!/bin/bash

PROJECT_ROOTS=(~ /run/media/meng/Data/Programming)

configs=$(tmuxinator list | tail -n +2 | awk '{$1=$1;print}')
[[ -z "$configs" ]] && { echo "No tmuxinator configs found" >&2; exit 1; }

selected_config=$(printf "%s\n" $configs | fzf --header "Select a tmuxinator config")
[[ -z "$selected_config" ]] && exit 0

find_all_projects() {
  for root in "${PROJECT_ROOTS[@]}"; do
    expanded_path=$(eval echo "$root")
    find "$expanded_path" -mindepth 1 -maxdepth 3 \
      -type d \( -name ".git" -o -name ".tmuxinator" \) -printf '%h\n' 2>/dev/null
  done | sort -u | while read -r dir; do
    timestamp=$(stat -c '%Y' "$dir")
    echo "$timestamp $dir"
  done | sort -rn | cut -d' ' -f2-
}

has_mono_repo_structure() {
  local dir="$1"
  local has_frontend=0
  local has_backend=0
  local has_client=0
  local has_server=0

  for child in "$dir"/*; do
    [[ -d "$child" ]] || continue
    case "$child" in
      *frontend*) has_frontend=1 ;;
      *backend*) has_backend=1 ;;
      *client*) has_client=1 ;;
      *server*) has_server=1 ;;
    esac
  done

  [[ $has_frontend -eq 1 && $has_backend -eq 1 ]] && return 0
  [[ $has_client -eq 1 && $has_server -eq 1 ]] && return 0
  return 1
}

find_mono_repo_projects() {
  for root in "${PROJECT_ROOTS[@]}"; do
    expanded_path=$(eval echo "$root")
    find "$expanded_path" -mindepth 1 -maxdepth 3 \
      -type d \( -name ".git" -o -name ".tmuxinator" \) -printf '%h\n' 2>/dev/null
  done | sort -u | while read -r dir; do
    has_mono_repo_structure "$dir" || continue
    timestamp=$(stat -c '%Y' "$dir")
    echo "$timestamp $dir"
  done | sort -rn | cut -d' ' -f2-
}

find_web_projects() {
  local web_path="/run/media/meng/Data/Programming/Web"
  [[ -d "$web_path" ]] || return
  find "$web_path" -mindepth 1 -maxdepth 2 \
    -type d \( -name ".git" -o -name ".tmuxinator" \) -printf '%h\n' 2>/dev/null | sort -u | while read -r dir; do
    has_mono_repo_structure "$dir" && continue
    timestamp=$(stat -c '%Y' "$dir")
    echo "$timestamp $dir"
  done | sort -rn | cut -d' ' -f2-
}

if [[ "$selected_config" == "mono_repo_web_dev" ]]; then
  project_list=$(find_mono_repo_projects)
elif [[ "$selected_config" == "single_project_web_dev" ]]; then
  project_list=$(find_web_projects)
else
  project_list=$(find_all_projects)
fi

selected_project=$(echo "$project_list" | fzf --preview="ls -F {}" --cycle --header "Select a project directory")
[[ -z "$selected_project" ]] && exit 0

cd "$selected_project" || exit 1
export PROJECT_DIR="$selected_project"

tmuxinator start "$selected_config"
