#!/usr/bin/env bash
set -eux
cd "$(dirname -- "$0")" || exit 1

[[ $(id -u) -ne 0 ]] || {
    echo "Do not run as root."
    exit 1
}

[[ -f "${PWD}/configs/${HOSTNAME}.yml" ]] || {
    echo "Configuration file for '${HOSTNAME}' not found at: '$(pwd)/configs/${HOSTNAME}.yml'."
    exit 1
}

_activate_venv() {
    set +x
    echo "Activating the venv with 'source .venv/bin/activate' ..."
    source .venv/bin/activate || return 1
    set -x
}

if [[ ! -d .venv ]]; then
    python3 -m venv .venv
    _activate_venv
    python3 -m ensurepip
    python3 -m pip install --upgrade pip
    pip3 install ansible psutil
else
    _activate_venv
fi

#ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml
