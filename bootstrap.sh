#!/usr/bin/env bash
# Bootstrap script

if [ -f ".bash_configs" ]; then
    wget --quiet https://raw.githubusercontent.com/ska-sa/cbf-jenkins-scripts/master/.bash_configs
    wget --quiet https://raw.githubusercontent.com/ska-sa/cbf-jenkins-scripts/master/1.install_dependencies.sh
    wget --quiet https://raw.githubusercontent.com/ska-sa/cbf-jenkins-scripts/master/2.verify_dependencies.sh
    wget --quiet https://raw.githubusercontent.com/ska-sa/cbf-jenkins-scripts/master/3.initialise_instrument.sh
    wget --quiet https://raw.githubusercontent.com/ska-sa/cbf-jenkins-scripts/master/4.corr2rx_test.sh
    wget --quiet https://raw.githubusercontent.com/ska-sa/cbf-jenkins-scripts/master/5.run_tests.sh
fi
# shellcheck disable=SC1091
source .bash_configs
bash 1.install_dependencies.sh && \
bash 2.verify_dependencies.sh && \
bash 3.initialise_instrument.sh && \
bash 4.corr2rx_test.sh && \
bash 5.run_tests.sh
