#!/usr/bin/env bats

load test_helper

@test "ask for creating .python-virtualenv" {
    rm -f .python-virtualenv  # ensure it does not exist
    run capture-and-term.py -- pyenv up  # take one line only
    assert_equal "${lines[0]}" "pyenv: Please name the project's virtualenv."
}

@test "accept the .python-virtualenv which existed" {
    echo "${TESTING_VENV_NAME}" > .python-virtualenv  # ensure it does exist
    run capture-and-term.py -- pyenv up  # take one line only
    assert_equal "${lines[0]}" "pyenv: The virtualenv '${TESTING_VENV_NAME}' has not been created yet."
}

@test "pick the .python-virtualenv in sub-directory." {
    echo "${TESTING_VENV_NAME}" > .python-virtualenv
    mkdir trees
    cd trees
    run capture-and-term.py -- pyenv up
    assert_equal "${lines[0]}" "pyenv: The virtualenv '${TESTING_VENV_NAME}' has not been created yet."

    rm -f ../.python-virtualenv
    run capture-and-term.py -- pyenv up
    assert_equal "${lines[0]}" "pyenv: Please name the project's virtualenv."
}
