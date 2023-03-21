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

# Fonts
wget -P /tmp/fonts "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/NerdFontsSymbolsOnly.zip"
( cd /tmp/fonts/ && unzip -o NerdFontsSymbolsOnly.zip; )
find /tmp/fonts -type f -name "*Windows*" -delete
find /tmp/fonts -type f -not -name "*Complete.ttf" -delete
mkdir -p /usr/share/fonts/NerdFonts
cp /tmp/fonts/*.ttf /usr/share/fonts/NerdFonts/

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
