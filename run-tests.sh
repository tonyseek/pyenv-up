#!/usr/bin/env bash

set -e
cd "`dirname $0`"
[ -d "tests/pyenv" ] || git clone https://github.com/yyuu/pyenv.git tests/pyenv
export PYENV_ROOT="${PWD}/tests/pyenv"
mkdir -p "${PYENV_ROOT}/virtualenvs"
bats $@ tests
