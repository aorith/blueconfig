#!/usr/bin/env bash

set -eux -o pipefail

RELEASE="$(rpm -E %fedora)"

# Rpm Fusion
wget -P /tmp/rpms/ \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${RELEASE}.noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${RELEASE}.noarch.rpm"
rpm-ostree install /tmp/rpms/*.rpm fedora-repos-archive

# Docker
wget -P /etc/yum.repos.d/ \
    "https://download.docker.com/linux/fedora/docker-ce.repo"
wget -P /tmp/ \
    "https://download.docker.com/linux/fedora/gpg"
install -o 0 -g 0 -m644 "/tmp/gpg" "/etc/pki/rpm-gpg/docker-ce.gpg"

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

# Enable automatic updates
sed -i 's,.*AutomaticUpdatePolicy=.*,AutomaticUpdatePolicy=stage,g' /etc/rpm-ostreed.conf
systemctl enable rpm-ostreed-automatic.timer
systemctl enable rpm-ostree-countme.timer

# Enable sockets
systemctl enable docker.socket
systemctl enable libvirtd.socket

# Disable suspend & hibernate
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

# Cleanup
fc-cache -sf
rm -rf /tmp/*
mkdir -p /var/tmp
chmod -R 1777 /var/tmp

ostree container commit
