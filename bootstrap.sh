#!/usr/bin/env bash
# Bootstrap script

# shellcheck disable=SC1091
source .bash_configs
bash 1.install_dependencies.sh && \
bash 2.verify_dependencies.sh && \
bash 3.initialise_instrument.sh && \
bash 4.corr2rx_test.sh && \
bash 5.run_tests.sh
