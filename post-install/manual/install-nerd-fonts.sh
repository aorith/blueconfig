#!/usr/bin/env bash
set -eu -o pipefail

install_font() {
    VER="$1" # 3.1.1
    FN="$2"  # Hack
    echo "Installing '$FN' on verson '$VER'..."

    BASE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v${VER}/${FN}.tar.xz"

    curl -s -L -o "/tmp/${FN}.tar.xz" "$BASE_URL"
    mkdir -p ~/.local/share/fonts/"$FN"
    tar --no-same-owner -xJf "/tmp/${FN}.tar.xz" -C ~/.local/share/fonts/"$FN"/
    rm -f "/tmp/${FN}.tar.xz"
    rm -f ~/.local/share/fonts/"${FN}"/*Windows*
    echo "Done."
}

install_font 3.1.1 Hack
install_font 3.1.1 JetBrainsMono
install_font 3.1.1 Iosevka
install_font 3.1.1 Monaspace
