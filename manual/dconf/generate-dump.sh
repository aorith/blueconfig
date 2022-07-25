#!/usr/bin/env bash
set -eu
cd "$(dirname -- "$0")" || exit 1

# INSTRUCTIONS
# 
# Firstly, check which path or paths do you want to dump, for example, gnome settings live
# in '/org/gnome/', you can run 'dconf dump /org/gnome/' to see the output, the last '/' is important.
# To check those paths you can use 'dconf watch /', and configure Gnome manually, saving the interesting paths.

# Then, put the paths in the variable 'paths_to_dump' and run this script.
# Files with the extension .conf and proper name will be generated for the current gnome-shell version.

paths_to_dump=(
    "/org/gnome/desktop/input-sources"
    "/org/gnome/desktop/interface"
    "/org/gnome/desktop/peripherals/touchpad"
    "/org/gnome/desktop/peripherals/mouse"
    "/org/gnome/desktop/peripherals/trackball"
    "/org/gnome/desktop/privacy"
    "/org/gnome/desktop/sound"
    "/org/gnome/desktop/wm/preferences"
    "/org/gnome/mutter"
    "/org/gnome/shell"
    "/org/gnome/nautilus"
    "/org/gnome/settings-daemon/plugins/media-keys"
    "/org/gnome/terminal/legacy"
)

gnome_shell_ver=$(gnome-shell --version | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | xargs)
dump_folder="./dumps/${gnome_shell_ver}"
mkdir -p "${dump_folder}"
for _path in "${paths_to_dump[@]}"; do
    if [[ ${_path: -1} != "/" ]]; then
        _path="${_path}/"
    fi
    _content=$(dconf dump "$_path")
    echo "$_content" > "./${dump_folder}/${_path//\//,}.conf"
    ls "./${dump_folder}/${_path//\//,}.conf"
done
