#!/bin/sh

: "${TARGET:=1.1.1.1}"
: "${INTERVAL:=5}"

NSE="/nsenter --target 1 --mount --uts --ipc --net --pid"

nsexec() {
    $NSE sh -c "$*"
}

while true
do
    if ping -c 1 "$TARGET" >/dev/null 2>&1
    then
        echo "$(date): Ping successful."
    else
        echo "$(date): Ping failed."

        if nsexec "systemctl is-active connman.service" >/dev/null 2>&1; then
            nsexec "systemctl restart connman.service"
        elif nsexec "systemctl is-active NetworkManager.service" >/dev/null 2>&1; then
            nsexec "systemctl restart NetworkManager.service"
        fi

        if nsexec "systemctl is-active wpa_supplicant.service" >/dev/null 2>&1; then
            nsexec "systemctl restart wpa_supplicant.service"
        fi
    fi

    sleep $(($INTERVAL * 60))
done
