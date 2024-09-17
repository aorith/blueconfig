#!/usr/bin/env bash

touch /.dockerenv

dnf install -y xz --setopt=install_weak_deps=False

useradd nix && mkdir -m 0755 /nix && chown nix /nix

sudo -u nix -- bash -c \
    'curl -fLs https://nixos.org/nix/install | sh -s -- --no-daemon --yes'

cp -pr \
    /home/nix/.local/state/nix/profiles/profile-1-link \
    /nix/var/nix/profiles/default
