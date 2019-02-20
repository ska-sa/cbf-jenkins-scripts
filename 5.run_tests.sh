#!/usr/bin/env bash
# This script, depending on the boolean var RUN_TESTS, it will execute tests for specified instrument.

set -e pipeline #Abort on errors
# shellcheck disable=SC1091
source .bash_configs

if [ -f ".venv/bin/activate" ]; then
    # shellcheck disable=SC1091
    . .venv/bin/activate

    if [ "${RUN_TESTS}" = false ]; then
        gecho "Running Sanity Test based on Baseline Product Test"
        make sanitytest;
    else
        gecho "Running Full Test Suite for ${RUN_INSTRUMENT}."
        make "tests${INSTRUMENT}";
    fi
else
    recho "virtualenv not installed"
    recho "If this issue persists contact: ${AUTHOR}"
    exit 1
fi
if cmd_exist pylint; then
    pylint --rcfile .pylintrc mkat_fpga_tests > katreport/pylint-report.txt
fi
