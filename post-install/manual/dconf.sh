#!/usr/bin/env bash
set -xeuo pipefail

dconf write /org/gnome/desktop/wm/preferences/resize-with-right-button true
dconf write /org/gnome/desktop/privacy/remember-recent-files false
dconf write /org/gnome/desktop/privacy/remove-old-temp-files true
dconf write /org/gnome/desktop/privacy/remove-old-trash-files true
dconf write /org/gnome/desktop/privacy/old-files-age 'uint32 30'

# Caps as ctrl
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"

gsettings set org.gnome.desktop.peripherals.keyboard delay 300
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 25

#gsettings set org.gnome.desktop.wm.preferences num-workspaces 9
#gsettings set org.gnome.mutter dynamic-workspaces false
gsettings reset org.gnome.desktop.wm.preferences num-workspaces
gsettings set org.gnome.mutter dynamic-workspaces true
gsettings set org.gnome.mutter edge-tiling true

# fractional scaling
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

# remove default keybindings for fav apps
# gsettings set org.gnome.shell.keybindings switch-to-application-1 '[""]'
# gsettings set org.gnome.shell.keybindings switch-to-application-2 '[""]'
# gsettings set org.gnome.shell.keybindings switch-to-application-3 '[""]'
# gsettings set org.gnome.shell.keybindings switch-to-application-4 '[""]'
# gsettings set org.gnome.shell.keybindings switch-to-application-5 '[""]'
# gsettings set org.gnome.shell.keybindings switch-to-application-6 '[""]'
# gsettings set org.gnome.shell.keybindings switch-to-application-7 '[""]'
# gsettings set org.gnome.shell.keybindings switch-to-application-8 '[""]'
# gsettings set org.gnome.shell.keybindings switch-to-application-9 '[""]'
gsettings reset org.gnome.shell.keybindings switch-to-application-1
gsettings reset org.gnome.shell.keybindings switch-to-application-2
gsettings reset org.gnome.shell.keybindings switch-to-application-3
gsettings reset org.gnome.shell.keybindings switch-to-application-4
gsettings reset org.gnome.shell.keybindings switch-to-application-5
gsettings reset org.gnome.shell.keybindings switch-to-application-6
gsettings reset org.gnome.shell.keybindings switch-to-application-7
gsettings reset org.gnome.shell.keybindings switch-to-application-8
gsettings reset org.gnome.shell.keybindings switch-to-application-9

# Switch to workspaces
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 '["<Super>1"]'
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 '["<Super>2"]'
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 '["<Super>3"]'
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 '["<Super>4"]'
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 '["<Super>5"]'
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 '["<Super>6"]'
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 '["<Super>7"]'
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 '["<Super>8"]'
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 '["<Super>9"]'
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-1
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-2
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-3
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-4
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-5
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-6
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-7
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-8
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-9

# Move windows between workspaces
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 '["<Shift><Super>1"]'
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 '["<Shift><Super>2"]'
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 '["<Shift><Super>3"]'
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 '["<Shift><Super>4"]'
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 '["<Shift><Super>5"]'
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 '["<Shift><Super>6"]'
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 '["<Shift><Super>7"]'
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 '["<Shift><Super>8"]'
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 '["<Shift><Super>9"]'
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-1
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-2
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-3
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-4
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-5
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-6
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-7
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-8
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-9
