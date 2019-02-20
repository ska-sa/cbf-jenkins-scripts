#!/usr/bin/env bash
# X-Engine output verification.

set -e pipeline #Abort on errors
# shellcheck disable=SC1091
source .bash_configs

if [ -f ".venv/bin/activate" ]; then
    # shellcheck disable=SC1091
    . .venv/bin/activate
    gecho "Issuing a Capture start for baseline-correlation-products."
    if ! cmd_exists kcpcmd; then
        recho "kcpcmd is not installed."
        recho "If this issue persists contact: ${AUTHOR}"
        exit 1
    fi
    kcpcmd -t 60 -s localhost:"$(kcpcmd subordinate-list "${ARRAY_NAME}" | grep -a subordinate-list | cut -f3 -d ' ' | cut -f1 -d',')" capture-start baseline-correlation-products
    if [ -f ".venv/bin/corr2_rx.py" ]; then
        timeout 60s .venv/bin/python .venv/bin/corr2_rx.py --loglevel error \
           --config "/etc/corr/${ARRAY_NAME}-${RUN_INSTRUMENT}" --print --baseline 4 --channels 0,500
    else
        recho "CORR2 was not properly installed in your virtualenv";
        exit 1;
    fi
else
    recho "virtualenv not installed"
    recho "If this issue persists contact: ${AUTHOR}"
    exit 1
fi

