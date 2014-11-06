#!/bin/sh
# Usage: PREFIX=/usr/local ./install.sh
#
# Installs pyenv-up under $PREFIX.

set -e

cd `dirname "$0"`

if [ -z "${PREFIX}" ]; then
    PREFIX="/usr/local"
fi

BIN_PATH="${PREFIX}/bin"

mkdir -p "$BIN_PATH"

install -p bin/pyenv-up "$BIN_PATH"
