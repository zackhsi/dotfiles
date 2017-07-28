all: files brew pip pip3 tmux_plugins ## Make it all!

files: ## Ensure files are up to date
	./manage

pip: ## Ensure pip packages in requirements.in are installed
	python2.7 -m piptools compile --output-file requirements.txt requirements.in
	pip2 install -r requirements.txt

pip_clean: ## Uninstall all pip modules
	pip2 freeze | xargs pip2 uninstall -y -q

pip3: ## Ensure pip3 packages in requirements.in are installed
	python3.6 -m piptools compile --output-file requirements3.txt requirements3.in
	pip3 install -r requirements3.txt

pip3_clean: ## Uninstall all pip3 modules
	pip3 freeze | xargs pip3 uninstall -y -q

cargo: ## Install crates in Cargofile
	./rustcargo

brew: ## Install formulas in Brewfile
	brew bundle

npm_freeze: ## Freeze node packages into Nodefile
	npm ls -g --depth=0 > Nodefile

tmux_plugins: ## Install and update tmux plugins
	~/.tmux/plugins/tpm/bin/install_plugins
	~/.tmux/plugins/tpm/bin/update_plugins all

.DEFAULT_GOAL := help
.PHONY: help
help:
	@perl -nle'print $& if m{^[a-zA-Z0-9_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
