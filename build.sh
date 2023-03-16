#!/bin/bash

set -eux -o pipefail

RELEASE=$(rpm -E %fedora)

# Rpm Fusion
wget -P /tmp/rpms \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${RELEASE}.noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${RELEASE}.noarch.rpm"
rpm-ostree install /tmp/rpms/*.rpm fedora-repos-archive

# Experimental: https://coreos.github.io/rpm-ostree/ex-rebuild/
rpm-ostree ex rebuild

# Enable automatic updates
sed -i 's,.*AutomaticUpdatePolicy=.*,AutomaticUpdatePolicy=stage,g' /etc/rpm-ostreed.conf
systemctl enable rpm-ostreed-automatic.timer
systemctl enable flatpak-system-update.timer
systemctl --global enable flatpak-user-update.timer
