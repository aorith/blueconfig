#!/usr/bin/env bash
cd "$(dirname -- "$0")" || exit 1

sudo cp ./etc/tca.pem /etc/pki/ca-trust/source/anchors/
sudo update-ca-trust
