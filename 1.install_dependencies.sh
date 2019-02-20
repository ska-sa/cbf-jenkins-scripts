#!/usr/bin/env bash
# This scripts resets any changes made to corr template, and creates a virtual environment
# with all dependencies

# To run: bash ./1.install_dependencies.sh

set -e pipeline #Abort on errors
# shellcheck disable=SC1091
source .bash_configs

if [ -z "${RUN_INSTRUMENT}" ]; then
    recho "INSTRUMENT WAS NOT SPECIFIED."
    exit 1;
fi

if [ -z "${WORKSPACE}" ]; then
    recho "Not currently running on Jenkins"
    recho "Using $(pwd) as WORKSPACE for testing purposes!"
    WORKSPACE=$(pwd)
fi

if [ -d "/etc/corr/templates" ]; then
    cd /etc/corr/templates || true;
    gecho "Resetting any changes made on templaces in /etc/corr"
    git diff --exit-code "${RUN_INSTRUMENT}" || git checkout -- "${RUN_INSTRUMENT}";
    cd - || true;
fi

if [ ! -f "setup_virtualenv.sh" ]; then
    wget https://raw.githubusercontent.com/ska-sa/mkat_fpga_tests/devel/scripts/setup_virtualenv.sh
else
    recho "Failed to download setup_virtualenv.sh"
    recho "Contact: ${AUTHOR}"
    exit 1;
fi

if [ -f "setup_virtualenv.sh" ]; then
    gecho "Installing virtualenv and all dependencies"
    bash setup_virtualenv.sh
    export PATH=$PATH:$WORKSPACE/scripts:$WORKSPACE/.venv/bin;
    gecho "Working in a virtualenv."
    # shellcheck disable=SC1091
    . .venv/bin/activate
else
    recho "Failed to create virtualenv and install dependencies"
    recho "Contact: ${AUTHOR}"
    exit 1;
fi