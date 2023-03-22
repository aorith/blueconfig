#!/usr/bin/env bash

set -x

current_image="$1"
upstream_image="$2"

if [[ -z "$current_image" ]] || [[ -z "$upstream_image" ]]; then
    echo "Missing required parameters, this won't work." >&2
fi

current_version=$(skopeo inspect "docker://${current_image}" | jq -r '.Labels.version')
upstream_version=$(skopeo inspect "docker://${upstream_image}" | jq -r '.Labels.version')

if [[ "$current_version" == "$upstream_version" ]]; then
    echo "Rebuild not required. (current: $current_version, upstream: $upstream_version"
    exit 1
else
    echo "Upstream has a new version. (current: $current_version, upstream: $upstream_version"
    exit 0
fi
