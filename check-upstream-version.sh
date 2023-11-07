#!/usr/bin/env bash

set -x

current_image="$1"
upstream_image="$2"

if [[ -z "$current_image" ]] || [[ -z "$upstream_image" ]]; then
    echo "Missing required parameters, this won't work." >&2
fi

# This doesn't work anymore since they're not including the date with the version
# current_version=$(skopeo inspect "docker://${current_image}" | jq -r '.Labels.version')
# upstream_version=$(skopeo inspect "docker://${upstream_image}" | jq -r '.Labels.version')
#
# if [[ "$current_version" == "$upstream_version" ]]; then
#     echo "Rebuild not required. (current: $current_version, upstream: $upstream_version"
#     exit 1
# else
#     echo "Upstream has a new version. (current: $current_version, upstream: $upstream_version"
#     exit 0
# fi

current_date=$(skopeo inspect "docker://${current_image}" | jq -r '.Created')
upstream_date=$(skopeo inspect "docker://${upstream_image}" | jq -r '.Created')
current_timestamp=$(date --date "$current_date" +%s)
upstream_timestamp=$(date --date "$upstream_date" +%s)

if ((current_timestamp < upstream_timestamp)); then
    echo "Upstream has a new version. (current: $current_date, upstream: $upstream_date"
    exit 0
else
    echo "Rebuild not required. (current: $current_date, upstream: $upstream_date"
    exit 1
fi
