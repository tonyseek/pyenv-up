#!/usr/bin/env bats

load test_helper

@test "ask for creating .python-virtualenv" {
    rm -f .python-virtualenv  # ensure it does not exist
    run capture-and-term.py -- pyenv up  # take one line only
    [ "${lines[0]}" = "pyenv: Please name the project's virtualenv." ]
}

@test "accept the .python-virtualenv which existed" {
    echo '_lumpy' > .python-virtualenv  # ensure it does exist
    run capture-and-term.py -- pyenv up  # take one line only
    [ "${lines[0]}" = "pyenv: The virtualenv '_lumpy' has not been created yet." ]
}

@test "pick the .python-virtualenv in sub-directory." {
    echo '_lumpy' > .python-virtualenv
    mkdir trees
    cd trees
    run capture-and-term.py -- pyenv up
    [ "${lines[0]}" = "pyenv: The virtualenv '_lumpy' has not been created yet." ]

    rm -f ../.python-virtualenv
    run capture-and-term.py -- pyenv up
    [ "${lines[0]}" = "pyenv: Please name the project's virtualenv." ]
}
