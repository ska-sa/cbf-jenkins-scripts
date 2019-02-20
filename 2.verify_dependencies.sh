#!/usr/bin/env bash
# This script verifies if the necessary packages where installed in your virtualenv.

set -e pipeline #Abort on errors
# shellcheck disable=SC1091
source .bash_configs

if [ -f ".venv/bin/activate" ]; then
    declare -a PYTHON_SRC_PACKAGES="(casperfpga corr2 spead2 katcp)"
    # shellcheck disable=SC1091
    . .venv/bin/activate
    gecho "Package Installation Verification...";
    if [[ "$(command -v corr2_dsim_control.py)" != *".venv"* ]]; then
        recho "CORR2 scripts missing in your virtualenv.";
        exit 1;
    fi

    for pkg in "${PYTHON_SRC_PACKAGES[@]}"; do
        if ! $(command -v python) -c """import ${pkg}; print ${pkg}.__file__;"""; then
            recho "${pkg} IS NOT INSTALLED IN VIRTUALENV!"
            exit $?;
        fi
    done
else
    recho "virtualenv not installed correctly."
    recho "If this persist contact: ${AUTHOR}."
    exit 1
fi