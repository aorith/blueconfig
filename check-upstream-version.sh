#!/usr/bin/env bash

set -x

current_image="$1"
upstream_image="$2"

if [[ -z "$current_image" ]] || [[ -z "$upstream_image" ]]; then
    echo "Missing required parameters, this won't work." >&2
fi

check_version() {
    local image="$1"
    skopeo inspect "docker://${image}" | jq -r '.Labels."org.opencontainers.image.version"'
}

current_version=$(check_version "$current_image")
upstream_version=$(check_version "$upstream_image")

if [[ "$current_version" != "$upstream_version" ]]; then
    echo "Upstream has a new version. (current: $current_version, upstream: $upstream_version)"
    exit 0
else
    echo "Rebuild not required. (current: $current_version, upstream: $upstream_version)"
    exit 1
fi
