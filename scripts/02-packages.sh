#!/usr/bin/env bash
set -eux -o pipefail

# Multimedia & Drivers
dnf install --allowerasing -y openh264 \
    ffmpeg \
    ffmpegthumbnailer \
    gstreamer1-plugin-libav \
    gstreamer1-plugins-bad-free-extras \
    gstreamer1-plugins-bad-freeworld \
    gstreamer1-plugins-ugly \
    gstreamer1-vaapi

dnf install --allowerasing -y \
    mesa-va-drivers-freeworld \
    mesa-vdpau-drivers-freeworld

# Package installation
PACKAGES_TO_INSTALL=(
    # Desktop
    "alacritty"
    "wl-clipboard"

    # Utils
    "android-tools"
    "make"
    "netcat"
    "nvme-cli"
    "nvtop"
    "smartmontools"
    "vim"
    "wireguard-tools"

    # Drivers & misc
    "alsa-firmware"
    "iwd"
    "libva-utils"
    "pipewire-codec-aptx"
    "vulkan"
    "intel-media-driver"
    "libva-intel-driver"

    # Virtualisation & containers
    "cloud-utils"
    "libvirt"
    "libvirt-daemon-config-network"
    "libvirt-daemon-kvm"
    "qemu-kvm"
    # Sometimes used as a vm
    "qemu-guest-agent"
    "virt-install"
    "virt-manager"
    "virt-top"
    "virt-viewer"

    # Gnome
    "gnome-shell-extension-appindicator"
    "gnome-tweaks"

    # Extras
    "python3-psutil"
    "steam-devices"

    # Logitech unifying
    "solaar"
    "solaar-udev"
)

dnf install --allowerasing -y "${PACKAGES_TO_INSTALL[@]}"
