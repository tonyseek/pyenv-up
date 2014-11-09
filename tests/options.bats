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
    run pyenv up --list
    [ "$status" -eq 0 ]
}
