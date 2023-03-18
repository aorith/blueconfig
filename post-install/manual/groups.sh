#!/usr/bin/env bash

if [[ -f /run/.containerenv ]]; then
    echo "Run outside of the container."
    exit 1
fi

if ! grep -q libvirt /etc/group; then
    grep -E '^libvirt:' /usr/lib/group | sudo tee -a /etc/group
fi

if grep -q docker /etc/group && ! grep -q docker < <(groups); then
    sudo usermod -aG docker aorith
fi

if ! grep -q libvirt < <(groups); then
    sudo usermod -aG libvirt aorith
fi
