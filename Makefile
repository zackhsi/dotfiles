all: files brew pip2 pip3 tmux_plugins ## Make it all!

files: ## Ensure files are up to date
	./manage

PYTHON2=PYENV_VERSION=2.7.14 python
PIP2=PYENV_VERSION=2.7.14 pip

pip2: ## Ensure pip packages in requirements.in are installed
	$(PIP2) install --upgrade pip-tools
	$(PYTHON2) -m piptools compile --output-file requirements.txt requirements.in
	$(PIP2) install --requirement requirements.txt

pip2_clean: ## Uninstall all pip modules
	$(PIP2) freeze | grep -v "^-e " | xargs $(PIP2) uninstall -y -q

PYTHON3=PYENV_VERSION=3.6.5 python
PIP3=PYENV_VERSION=3.6.5 pip

pip3: ## Ensure pip3 packages in requirements.in are installed
	$(PIP3) install --upgrade pip-tools
	$(PYTHON3) -m piptools compile --output-file requirements3.txt requirements3.in
	$(PIP3) install \
		--requirement requirements3.txt \
		--src ~/oss \
		--exists-action s

pip3_clean: ## Uninstall all pip3 modules
	$(PIP3) freeze | xargs $(PIP3) uninstall -y -q

rust: ## Install rust ecosystem
	@command -v rustc &> /dev/null || (echo "Installing rust..." && curl https://sh.rustup.rs -sSf | sh)

brew: ## Install formulas in Brewfile
	brew bundle

node: ## Install local npm packages
	npm install

.DEFAULT_GOAL := help
.PHONY: help
help:
	@perl -nle'print $& if m{^[a-zA-Z0-9_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
