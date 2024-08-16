#!/usr/bin/env bash
set -eux -o pipefail

# Package removal
rpm-ostree override remove noopenh264 --install openh264
rpm-ostree override remove \
    ffmpeg-free \
    libavcodec-free \
    libavdevice-free \
    libavfilter-free \
    libavformat-free \
    libavutil-free \
    libpostproc-free \
    libswresample-free \
    libswscale-free \
    mesa-va-drivers

# Package installation
PACKAGES_TO_INSTALL=(
    # Desktop
    "alacritty"
    "wl-clipboard"
    "xclip"

    # Media
    "mpv"
    "vlc"

    # Utils
    "android-tools"
    "bootc"
    "make"
    "net-tools"
    "netcat"
    "nvme-cli"
    "nvtop"
    "ripgrep"
    "smartmontools"
    "vim"
    "wireguard-tools"
    "zstd"

    # Drivers & misc
    "alsa-firmware"
    "ffmpeg"
    "ffmpeg-libs"
    "ffmpegthumbnailer"
    "intel-media-driver"
    "libva-intel-driver"
    "libva-utils"
    "mesa-va-drivers-freeworld"
    "pipewire-codec-aptx"

    # Virtualisation & containers
    "buildah"
    "cloud-utils"
    "distrobox"
    "libvirt"
    "libvirt-daemon-config-network"
    "libvirt-daemon-kvm"
    "qemu-kvm"
    "virt-install"
    "virt-manager"
    "virt-top"
    "virt-viewer"

    # Docker
    "docker-ce"
    "docker-ce-cli"
    "containerd.io"
    "docker-buildx-plugin"
    "docker-compose-plugin"

    # Gnome
    "gnome-shell-extension-appindicator"
    "gnome-tweaks"

    # Extras
    "flameshot"
    "haveged"
    "openssl"
    "python3-psutil"
    "syncthing"

    # Gaming
    "steam-devices"

    # Logitech unifying
    "solaar"
    "solaar-udev"
)

rpm-ostree install "${PACKAGES_TO_INSTALL[@]}"
