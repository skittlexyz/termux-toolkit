#!/bin/bash

main_file="$HOME/.termux/termux.properties"
version_file_1="$HOME/.termux/termux_version_1.properties"
version_file_2="$HOME/.termux/termux_version_2.properties"
state_file="$HOME/.termux/toggle_state"

touch "$state_file"

current_version=$(cat "$state_file")

if [ -z "$current_version" ]; then
    current_version="1"
fi

switch_version() {
    local current_content=""
    local target_file=""
    local new_version=""

    if [ "$1" == "1" ]; then
        current_content=$(cat "$version_file_1")
        target_file="$main_file"
        new_version="2"
    elif [ "$1" == "2" ]; then
        current_content=$(cat "$version_file_2")
        target_file="$main_file"
        new_version="1"
    fi

    echo -e "$current_content" > "$target_file"
    echo "$new_version" > "$state_file"
}

switch_version "$current_version"
termux-reload-settings
