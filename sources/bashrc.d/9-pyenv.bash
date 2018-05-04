eval "$(pyenv init -)"

# https://github.com/pyenv/pyenv/wiki#how-to-build-cpython-with-framework-support-on-os-x
export PYTHON_CONFIGURE_OPTS="--enable-framework"
# https://github.com/pyenv/pyenv/issues/99#issuecomment-35045985
export CC=clang
