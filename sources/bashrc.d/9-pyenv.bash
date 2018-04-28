eval "$(pyenv init -)"

# https://github.com/pyenv/pyenv/wiki#how-to-build-cpython-with-framework-support-on-os-x
export PYTHON_CONFIGURE_OPTS="--enable-framework"
