#!/usr/bin/env bash
set -eu -o pipefail
cd "$(dirname -- "$0")" || exit 1

gnome_shell_ver=$(gnome-shell --version | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | xargs)
dump_folder="./dumps/${gnome_shell_ver}"
if [[ ! -d "${dump_folder}" ]]; then
    1>&2 echo "There is no dump in '${dump_folder}'. Generate one with 'generate-dump.sh'."
    exit 1
fi

for _file in "./${dump_folder}/"*.conf; do
    filename=$(basename -- "$_file" .conf)
    _path="${filename//,/\/}"
    echo "Running: 'dconf load $_path < $_file'"
    dconf load "$_path" < "$_file"
done
