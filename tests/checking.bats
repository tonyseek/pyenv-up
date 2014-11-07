#!/usr/bin/env bats

@test "checking for PYENV_ROOT" {
    unset PYENV_ROOT
    run pyenv-up
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "PYENV_ROOT is undefined." ]
}

@test "checking for pyenv" {
    export PATH="/bin:/usr/bin:${PWD}/bin"
    run pyenv-up
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "pyenv is not found in your PATH." ]
}
