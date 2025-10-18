#!/usr/bin/env bash
set -eux -o pipefail

sed -i "s,^PRETTY_NAME=.*,PRETTY_NAME=\"Fedora Linux $(rpm -E %fedora) \(Blueconfig\)\"," /usr/lib/os-release

dnf -y install dnf-plugins-core 'dnf5-command(config-manager)'

# RPM Fusion
dnf install -y \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
dnf install -y rpmfusion-free-release rpmfusion-nonfree-release

# Docker
dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
dnf config-manager setopt docker-ce-stable.enabled=0
dnf -y install --enablerepo='docker-ce-stable' docker-ce docker-ce-cli docker-compose-plugin
