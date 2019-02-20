#!/usr/bin/env bash
# This script, depending on the boolean var RUN_TESTS, it will execute tests for specified instrument.

set -e pipeline
source .bash_configs


if [ -f ".venv/bin/activate" ]; then
    . .venv/bin/activate

    if ! "${RUN_TESTS}"; then
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
if $(command -v pylint) > /dev/null; then
    pylint --rcfile .pylintrc mkat_fpga_tests > katreport/pylint-report.txt
fi
