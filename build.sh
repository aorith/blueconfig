#!/bin/bash

set -eux -o pipefail

RELEASE=$(rpm -E %fedora)

# Fonts
bash /tmp/install-nerd-font.sh 3.1.1 Hack
bash /tmp/install-nerd-font.sh 3.1.1 JetBrainsMono
bash /tmp/install-nerd-font.sh 3.1.1 IosevkaTerm
bash /tmp/install-nerd-font.sh 3.1.1 0xProto
rm -f /tmp/install-nerd-font.sh
fc-cache -sf

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
systemctl enable rpm-ostree-countme.timer

# Disable suspend & hibernate
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

# Cleanup
rm -rf /tmp/*
rm -rf /var/*
mkdir -p /var/tmp
chmod -R 1777 /var/tmp
