#!/usr/bin/env bats

load test_helper

export EXPECTED_HELP_INFO=$(cat <<'EOF'
Usage: pyenv up [OPTIONS]

Options:
	--help/-h	Show help information.
	--renew/-r	Destroy the virtualenv and re-create it.
	--list/-l	List all existent virtualenvs.
EOF
)

@test "should show help" {
    run pyenv up --help
    [ "$status" -eq 0 ]
    assert_equal "$output" "$EXPECTED_HELP_INFO"
}

@test "should show virtualenvs" {
    rm -rf "$PYENV_ROOT/virtualenvs/foo"
    run pyenv up --list
    [ "$status" -eq 0 ]
    assert_equal "${lines[0]}" "There is nothing :("

    mkdir -p "$PYENV_ROOT/virtualenvs/foo/bin"
    touch "$PYENV_ROOT/virtualenvs/foo/bin/activate"
    run pyenv up --list
    [ "$status" -eq 0 ]
    assert_equal "${lines[0]}" "Existent virtualenvs:"
    assert_equal "${lines[1]}" " * foo ($PYENV_ROOT/virtualenvs/foo)"
    rm -rf "$PYENV_ROOT/virtualenvs/foo"
}
