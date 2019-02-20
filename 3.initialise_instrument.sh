#!/usr/bin/env bash
# This script modifies the test config file for site assuming you are running Jenkins on site system,
# and then tries to initialise a predefined instrument

set -e pipeline #Abort on errors
# shellcheck disable=SC1091
source .bash_configs

if [ -f ".venv/bin/activate" ]; then
    gecho "Instrument ${RUN_INSTRUMENT} initialisation"
    # shellcheck disable=SC1091
    . .venv/bin/activate
    echo "backend: agg" > matplotlibrc
    if [ -f "config/test_conf_site.ini" ]; then
        if [[ $(hostname) == "*cmc*" ]]; then
            sed -i -e "s/array0/${ARRAY_NAME}/g" config/test_conf_site.ini
        else
            sed -i -e "s/array0/${ARRAY_NAME}/g" config/test_conf_lab.ini
        fi
    fi

    if [ -f "scripts/instrument_activate" ]; then
        bash scripts/instrument_activate "${RUN_INSTRUMENT}" localhost "${ARRAY_NAME}" y
    else
        recho "Failed to initialise ${RUN_INSTRUMENT}, See logs"
        exit 1
    fi
else
    recho "virtualenv not installed"
    recho "If this issue persists contact: ${AUTHOR}"
    exit 1
fi