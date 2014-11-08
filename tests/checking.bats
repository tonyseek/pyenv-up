#!/usr/bin/env bats

load test_helper

@test "checking for PYENV_ROOT" {
    unset PYENV_ROOT
    run pyenv-up
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "PYENV_ROOT is undefined." ]
}

@test "checking for pyenv" {
    export PATH="${PYENV_UP_PATH}:/bin"
    run pyenv-up
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "pyenv is not found in your PATH." ]
}
