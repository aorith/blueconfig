#!/usr/bin/env bash
cd "$(dirname -- "$0")" || exit 1

# from nixos on /run/current-system/sw/share/wireplumber/main.lua.d/50-alsa-config.lua
# disable sound suspend to avoid missing sounds on idle or pop noises
# pactl list sinks | grep -A1 'State:'
#
# /etc/wireplumber/main.lua.d/51-alsa-custom.lua

case $HOSTNAME in
trantor) ;;
*)
    echo "Hostname doesn't match"
    exit 1
    ;;
esac

sudo mkdir -p /etc/wireplumber/main.lua.d
sudo cp ./etc/51-alsa-custom.lua /etc/wireplumber/main.lua.d/
