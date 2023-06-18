#!/usr/bin/env bash
set -xeuo pipefail

dconf write /org/gnome/desktop/wm/preferences/resize-with-right-button true
dconf write /org/gnome/desktop/privacy/remember-recent-files false
dconf write /org/gnome/desktop/privacy/remove-old-temp-files true
dconf write /org/gnome/desktop/privacy/remove-old-trash-files true
dconf write /org/gnome/desktop/privacy/old-files-age 'uint32 30'
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"

gsettings set org.gnome.desktop.peripherals.keyboard delay 300
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 25
