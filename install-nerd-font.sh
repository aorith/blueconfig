#!/usr/bin/env bash
set -eu -o pipefail

VER="$1" # 3.1.1
FN="$2"  # Hack

BASE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v${VER}/${FN}.tar.xz"

curl -s -L -o "/tmp/${FN}.tar.xz" "$BASE_URL"
mkdir -p "/usr/share/fonts/${FN}"
tar -xJf "/tmp/${FN}.tar.xz" -C "/usr/share/fonts/${FN}/"
rm -f "/tmp/${FN}.tar.xz"
rm -f "/usr/share/fonts/${FN}"/*Windows*
