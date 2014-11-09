unset PYENV_DIR
unset PYENV_VERSION

WORKING_DIR="${BATS_TMPDIR}/pyenv-up"
PROJECT_DIR="${WORKING_DIR}/project"

PYENV_UP_PATH="${BATS_TEST_DIRNAME}/../bin:${BATS_TEST_DIRNAME}/bin"
PYENV_PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin"

export HOME="${WORKING_DIR}/home"
export PATH="${PYENV_UP_PATH}:${PYENV_PATH}:/bin:/usr/bin:/usr/local/bin"

setup() {
    mkdir -p "${PROJECT_DIR}"
    cd "${PROJECT_DIR}"
    export TESTING_VENV_NAME="_lumpy"
}

teardown() {
    rm -rf "${WORKING_DIR}"
    rm -rf "${PYENV_ROOT}/virtualenvs/${TESTING_VENV_NAME}"
}

flunk() {
  { if [ "$#" -eq 0 ]; then cat -
    else echo "$@"
    fi
  } | sed "s:${WORKING_DIR}:TEST_DIR:g" >&2
  return 1
}

assert_equal() {
  if [ "$1" != "$2" ]; then
    { echo "expected: $1"
      echo "actual:   $2"
    } | flunk
  fi
}
