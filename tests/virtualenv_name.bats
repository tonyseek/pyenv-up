#!/usr/bin/env bats

load test_helper

@test "ask for creating .python-virtualenv" {
    rm -f .python-virtualenv  # ensure it does not exist
    run capture-and-term.py -- pyenv up  # take one line only
    assert_equal "${lines[0]}" "pyenv: Please name the project's virtualenv."
}

@test "acquire virtualenv command" {
    echo "2.7.8" > .python-version
    echo "${TESTING_VENV_NAME}" > .python-virtualenv
    pyenv exec pip uninstall -yq virtualenv || true
    run capture-and-term.py -- pyenv up
    assert_equal "${lines[0]}" "pyenv: The virtualenv command not found: 'virtualenv' or 'pyvenv'."
}

@test "accept the .python-virtualenv which existed" {
    echo "2.7.8" > .python-version
    echo "${TESTING_VENV_NAME}" > .python-virtualenv
    pyenv exec pip install -q virtualenv
    run capture-and-term.py -- pyenv up
    assert_equal "${lines[0]}" "pyenv: The virtualenv '${TESTING_VENV_NAME}' has not been created yet."
}

@test "pick the .python-virtualenv in sub-directory." {
    echo "2.7.8" > .python-version
    echo "${TESTING_VENV_NAME}" > .python-virtualenv
    mkdir trees
    cd trees
    pyenv exec pip install -q virtualenv
    run capture-and-term.py -- pyenv up
    assert_equal "${lines[0]}" "pyenv: The virtualenv '${TESTING_VENV_NAME}' has not been created yet."

    rm -f ../.python-virtualenv
    run capture-and-term.py -- pyenv up
    assert_equal "${lines[0]}" "pyenv: Please name the project's virtualenv."
}
