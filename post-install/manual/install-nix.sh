#!/usr/bin/env bash
# based on: https://github.com/dnkmmr69420/nix-with-selinux/blob/main/silverblue-installer.sh
set -euo pipefail

Log() { printf '[%s] %s\n' "$(date +'%Y-%m-%d %H:%M:%S')" "$*" >&2; }
Err() {
    printf '[%s] ERROR: %s\n' "$(date +'%Y-%m-%d %H:%M:%S')" "$*" >&2
    exit 1
}

if [[ "$UID" != 0 ]]; then
    Err "Run with sudo or as root."
fi

Log "Setting SELinux context to /nix and /var/lib/nix"
mkdir -p /var/lib/nix
for _dir in "/nix" "/var/lib/nix"; do
    semanage fcontext -a -t etc_t "${_dir}/store/[^/]+/etc(/.*)?"
    semanage fcontext -a -t lib_t "${_dir}/store/[^/]+/lib(/.*)?"
    semanage fcontext -a -t systemd_unit_file_t "${_dir}/store/[^/]+/lib/systemd/system(/.*)?"
    semanage fcontext -a -t man_t "${_dir}/store/[^/]+/man(/.*)?"
    semanage fcontext -a -t bin_t "${_dir}/store/[^/]+/s?bin(/.*)?"
    semanage fcontext -a -t usr_t "${_dir}/store/[^/]+/share(/.*)?"
    semanage fcontext -a -t var_run_t "${_dir}/var/nix/daemon-socket(/.*)?"
    semanage fcontext -a -t usr_t "${_dir}/var/nix/profiles(/per-user/[^/]+)?/[^/]+"
done
unset _dir
sleep 1

Log "Creating service files"
mkdir -p /etc/systemd/system/nix-daemon.service.d
tee /etc/systemd/system/nix-daemon.service.d/override.conf <<EOF
[Service]
Environment="NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt"
EOF

Log "Creating /nix mount point service"
tee /etc/systemd/system/mkdir-nix-rootfs.service <<EOF
[Unit]
Description=Enable /nix mount point for ostree
ConditionPathExists=!/nix
DefaultDependencies=no
Requires=local-fs-pre.target
After=local-fs-pre.target
[Service]
Type=oneshot
ExecStartPre=chattr -i /
ExecStart=mkdir -p '/nix'
ExecStopPost=chattr +i /
EOF

sleep 1
Log "Creating nix.mount"
tee /etc/systemd/system/nix.mount <<EOF
[Unit]
Description=Nix Package Manager
DefaultDependencies=no
After=mkdir-nix-rootfs.service
Wants=mkdir-nix-rootfs.service
Before=sockets.target
After=ostree-remount.service
BindsTo=var.mount
[Mount]
What=/var/lib/nix
Where=/nix
Options=bind
Type=none
EOF
sleep 1

Log "Enabling mounting of /var/lib/nix to /nix and resetting SELinux context"
systemctl daemon-reload
systemctl enable --now nix.mount
restorecon -RF /nix
sleep 1

Log "Temorarly setting SELinux to permissive"
setenforce Permissive
sleep 1

Log "Downloading the official nix install script ..."
curl --fail -Ls -o /tmp/nix-installer 'https://nixos.org/nix/install'
Log 'Nix installer has been downloaded to /tmp/nix-installer'
read -r -p 'Execute it now? (y/N): '
if [[ ! "${REPLY:-}" =~ ^(y|yes|Y|YES)$ ]]; then
    setenforce Enforcing
    Log "Bye ..."
    exit 0
fi

Log "Running the nix installer ..."
sleep 1
sh /tmp/nix-installer --daemon --yes

Log "Nix install script finished running."
sleep 1

Log "Copying service and enabling nix-daemon service files..."
rm -f /etc/systemd/system/nix-daemon.{service,socket}
cp /nix/var/nix/profiles/default/lib/systemd/system/nix-daemon.{service,socket} /etc/systemd/system/
restorecon -RF /nix
systemctl daemon-reload
systemctl enable --now nix-daemon.socket
sleep 1

Log "Setting SELinux back to Enforcing"
setenforce Enforcing
sleep 1

Log "Reboot your system by typing"
Log "systemctl reboot"
