#!/usr/bin/bash
# SPDX-License-Identifier: LGPL-2.1-or-later

set -x

podman build -f ./containers/$CONTAINER_USED -t $BLUECHI_IMAGE_NAME .

if [[ $? -ne 0 ]]; then
    exit 1
fi

if [ "$(systemctl --user is-active podman.socket)" != "active" ]; then
    echo "Integration tests requires access to podman using user socket"
    systemctl --user enable podman.socket
    systemctl --user start podman.socket
fi
