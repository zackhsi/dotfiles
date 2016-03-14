all: ensure_symlinks brew pip ## Make it all!

ensure_symlinks: ## Symlink files to where they belong
	./ensure_symlinks.sh

pip: ## Ensure only pip packages in requirements.in are installed
	pip freeze | xargs pip uninstall -y -q
	pip install -r requirements.in --upgrade -q
	pip freeze -r requirements.in > requirements.txt

brew: ## Ensure only formulas in Brewfile are installed
	brew update
	brew doctor
	brew bundle cleanup --force
	brew bundle check || brew bundle
	brew bundle dump --force

.DEFAULT_GOAL := help
.PHONY: help
help:
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
