#!/usr/bin/env bash
set -eux -o pipefail

# Enable services
systemctl enable systemd-timesyncd
systemctl enable systemd-resolved.service

systemctl enable dconf-update.service
systemctl enable flatpak-add-flathub-repo.service
systemctl enable flatpak-replace-fedora-apps.service
systemctl enable flatpak-system-update.timer

sed -i 's|^ExecStart=.*|ExecStart=/usr/bin/bootc update --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service
sed -i 's|^OnUnitInactiveSec=.*|OnUnitInactiveSec=7d\nPersistent=true|' /usr/lib/systemd/system/bootc-fetch-apply-updates.timer
sed -i 's|#AutomaticUpdatePolicy.*|AutomaticUpdatePolicy=stage|' /etc/rpm-ostreed.conf
sed -i 's|#LockLayering.*|LockLayering=true|' /etc/rpm-ostreed.conf

systemctl enable bootc-fetch-apply-updates

# Enable sockets
systemctl enable docker.socket libvirtd.socket

systemctl preset systemd-resolved.service
systemctl enable --global ssh-agent

# Required only when installing new system fonts
# fc-cache --system-only --really-force --verbose

# Disable repos (the sed command replaces the first match only)
sed -i '0,/enabled=.*/s//enabled=0/' /etc/yum.repos.d/fedora-cisco-openh264.repo
find /etc/yum.repos.d/ -type f -name "*fusion*.repo" -exec sed -i '0,/enabled=.*/s//enabled=0/' {} \;

# Remove fedora flatpak repository
rm -rf /usr/lib/systemd/system/flatpak-add-fedora-repos.service
