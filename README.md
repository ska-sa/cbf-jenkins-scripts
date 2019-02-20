# Jenkins Scripts

<!-- [![Build Status](https://travis-ci.org/ska-sa/cbf-jenkins-scripts.svg?branch=master)](https://travis-ci.org/mmphego/cbf-jenkins-scripts) -->
[![GitHub](https://img.shields.io/github/license/ska-sa/cbf-jenkins-scripts.svg)](LICENCE)

This directory contains all the scripts needed, when running a Jenkins build.
This could be simplified by just running a `JENKINSFILE`, that would be tedious hence the simplification of just using the shell scripts, Namely:

* `1.install_dependencies.sh`
    - Script is self-explanatory, it resets any changes made to corr template, and creates a virtual environment with all dependencies.
* `2.verify_dependencies.sh`
    - This script verifies if the necessary packages where installed in your virtualenv.
* `3.initialise_instrument.sh`
    - This script modifies the test config file for site assuming you are running Jenkins on site system, and then tries to initialise a predefined instrument
* `4.corr2rx_test.sh`
    - Assuming an instrument is running, this script will verify if X-Engines are spewing out data.
* `5.run_tests.sh`
    - This script, depending on the boolean var `RUN_TESTS`, it will execute tests for specified instrument.
* `.bash_configs`
    - Contains functions and vars required by scripts.

## Note

Ideally this script should be ran whilst in [cbf_tests](https://github.com/ska-sa/mkat_fpga_tests/tree/devel) directory, as it dependent on most of the files in that directory.

## Usage

A simple kickstart and software configuration tool thingy.

```shell
# Bootstrap-y
bash -c "$(curl -L https://git.io/cbf_bootstrap)"
```

or run everything manually sequentially as detailed above.

## Feedback

Feel free to fork it or send me PR to improve it.

## License

This project is licensed under the [MIT license](LICENSE).

### TODO

* Add this repo as a [git submodule](https://git-scm.com/docs/git-submodule) on [cbf_tests](https://github.com/ska-sa/mkat_fpga_tests/tree/devel)
* Port shell scripts to Python
* Add tests for [travis ci](http://travis-ci.com/)
