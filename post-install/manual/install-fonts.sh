#!/usr/bin/env bash
set -eu -o pipefail

FONT_PATH="$HOME/.local/share/fonts/nerd"
TAG="v2.3.3"
FONTS=("Hack" "JetBrainsMono")

mkdir -p "$FONT_PATH"
cd "$FONT_PATH" || exit 1
rm -f "$FONT_PATH/*"

for font in "${FONTS[@]}"; do
    curl -sfL -o font.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/${TAG}/${font}.zip"
    unzip -o font.zip
done

find . -type f -name "*Windows*" -delete
find . -type f -not -name "*Complete.ttf" -delete
fc-cache -fv
