#!/usr/bin/env bash
set -eu -o pipefail

install_nerd_font() {
    local VER="$1" # 3.1.1
    local FN="$2"  # Hack
    echo "Installing '$FN' on version '$VER'..."

    BASE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v${VER}/${FN}.tar.xz"

    curl -s -L -o "/tmp/${FN}.tar.xz" "$BASE_URL"
    mkdir -p ~/.local/share/fonts/nerd-"$FN"
    tar --no-same-owner -xJf "/tmp/${FN}.tar.xz" -C ~/.local/share/fonts/nerd-"$FN"/
    rm -f "/tmp/${FN}.tar.xz"
    rm -f ~/.local/share/fonts/nerd-"${FN}"/*Windows*
    echo "Done."
}

install_iosevka_font() {
    local ver="$1" # 28.0.7
    local fn="$2"  # IosevkaAile
    URL="https://github.com/be5invis/Iosevka/releases/download/v${ver}/PkgTTF-${fn}-${ver}.zip"
    curl -s -L -o "/tmp/${fn}.zip" "$URL"
    mkdir -p ~/.local/share/fonts/"$fn"
    unzip -u -o "/tmp/${fn}.zip" -d ~/.local/share/fonts/"$fn"/
    rm -f "/tmp/${fn}.zip"
}

install_from_url() {
    local fn="$1"  # Ubuntu
    local url="$2" # https://...
    curl -s -L -o "/tmp/${fn}.zip" "$url"
    mkdir -p ~/.local/share/fonts/"$fn"
    unzip -u -o "/tmp/${fn}.zip" -d ~/.local/share/fonts/"$fn"/
    rm -f "/tmp/${fn}.zip"
}

NERD_VER=3.3.0

install_nerd_font "$NERD_VER" Hack
install_nerd_font "$NERD_VER" JetBrainsMono
install_nerd_font "$NERD_VER" Monaspace
install_nerd_font "$NERD_VER" NerdFontsSymbolsOnly
install_nerd_font "$NERD_VER" SourceCodePro
install_nerd_font "$NERD_VER" Recursive
install_nerd_font "$NERD_VER" Meslo
install_nerd_font "$NERD_VER" IosevkaTerm

# install_iosevka_font 31.6.1 Iosevka
# install_iosevka_font 31.6.1 IosevkaFixed

# install_from_url Ubuntu "https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip"
