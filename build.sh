#!/usr/bin/env bash
set -eux -o pipefail

# RPM Fusion
rpm-ostree install \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
rpm-ostree install rpmfusion-free-release rpmfusion-nonfree-release \
    --uninstall rpmfusion-free-release \
    --uninstall rpmfusion-nonfree-release

# Docker
wget -P /etc/yum.repos.d/ "https://download.docker.com/linux/fedora/docker-ce.repo"
wget -P /tmp/ "https://download.docker.com/linux/fedora/gpg"
install -o 0 -g 0 -m644 "/tmp/gpg" "/etc/pki/rpm-gpg/docker-ce.gpg"
rpm-ostree install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Multimedia & Drivers
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
    --install ffmpeg \
    --install ffmpegthumbnailer \
    --install gstreamer1-plugin-libav \
    --install gstreamer1-plugins-bad-free-extras \
    --install gstreamer1-plugins-bad-freeworld \
    --install gstreamer1-plugins-ugly \
    --install gstreamer1-vaapi

rpm-ostree override remove \
    mesa-va-drivers \
    --install mesa-va-drivers-freeworld \
    --install mesa-vdpau-drivers-freeworld

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

rpm-ostree install "${PACKAGES_TO_INSTALL[@]}"

# Enable services
systemctl enable dconf-update.service
systemctl enable flatpak-add-flathub-repo.service
systemctl enable flatpak-replace-fedora-apps.service
systemctl enable flatpak-system-update.timer
systemctl enable rpm-ostreed-automatic.timer
systemctl enable rpm-ostree-countme.timer

# Enable sockets
systemctl enable docker.socket libvirtd.socket

# Required only when installing new system fonts
# fc-cache --system-only --really-force --verbose

# Disable repos (the sed command replaces the first match only)
sed -i '0,/enabled=.*/s//enabled=0/' /etc/yum.repos.d/fedora-cisco-openh264.repo
find /etc/yum.repos.d/ -type f -name "*fusion*.repo" -exec sed -i '0,/enabled=.*/s//enabled=0/' {} \;
