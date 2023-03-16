#!/usr/bin/env bash

if ! grep -q libvirt /etc/group; then
    grep -E '^libvirt:' /usr/lib/group | sudo tee -a /etc/group
    sudo usermod -aG libvirt aorith
fi
