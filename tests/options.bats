#!/usr/bin/env bats

load test_helper

export EXPECTED_HELP_INFO=$(cat <<'EOF'
Usage: pyenv up [OPTIONS]

Options:
	--help/-h	Show help information.
	--renew/-r	Destroy the virtualenv and re-create it.
	--rm/-d 	Remove the virtualenv but not re-create it.
	--list/-l	List all existent virtualenvs.
EOF
)

@test "should show help" {
    run pyenv up --help
    [ "$status" -eq 0 ]
    assert_equal "$output" "$EXPECTED_HELP_INFO"
}

@test "should show virtualenvs" {
    rm -rf "$PYENV_ROOT/virtualenvs"
    mkdir -p "$PYENV_ROOT/virtualenvs"

    run pyenv up --list
    [ "$status" -eq 0 ]
    assert_equal "${lines[0]}" "There is nothing :("

    mkdir -p "$PYENV_ROOT/virtualenvs/foo/bin"
    mkdir -p "$PYENV_ROOT/virtualenvs/bar/bin"
    touch "$PYENV_ROOT/virtualenvs/foo/bin/activate"
    touch "$PYENV_ROOT/virtualenvs/bar/bin/activate"

    run pyenv up --list
    [ "$status" -eq 0 ]
    assert_equal "${lines[0]}" "Existing virtualenvs:"
    assert_equal "${lines[1]}" " - bar ($PYENV_ROOT/virtualenvs/bar)"
    assert_equal "${lines[2]}" " - foo ($PYENV_ROOT/virtualenvs/foo)"
}

@test "should remove virtualenv" {
    rm -rf "$PYENV_ROOT/virtualenvs"
    mkdir -p "$PYENV_ROOT/virtualenvs"

    echo "2.7.8" > .python-version
    echo "${TESTING_VENV_NAME}" > .python-virtualenv
    run pyenv up

    run pyenv up --list
    [ "$status" -eq 0 ]
    assert_equal "${lines[0]}" "There is nothing :("
}
