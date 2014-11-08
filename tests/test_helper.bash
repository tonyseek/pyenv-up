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
}

teardown() {
    rm -rf "${WORKING_DIR}"
}
