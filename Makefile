all: files brew pip pip3 ## Make it all!

files: ## Ensure files are up to date
	./manage

pip: ## Ensure pip packages in requirements.in are installed
	pip install -r requirements.in --upgrade -q
	pip freeze -r requirements.in > requirements.txt

pip_clean: ## Uninstall all pip modules
	pip freeze | xargs pip uninstall -y -q

pip3: ## Ensure pip3 packages in requirements.in are installed
	pip3 install -r requirements3.in --upgrade -q
	pip3 freeze -r requirements3.in > requirements3.txt

pip3_clean: ## Uninstall all pip3 modules
	pip3 freeze | xargs pip3 uninstall -y -q

brew: ## Install formulas in Brewfile
	./homebrew

npm_freeze: ## Freeze node packages into Nodefile
	npm ls -g --depth=0 > Nodefile

.DEFAULT_GOAL := help
.PHONY: help
help:
	@perl -nle'print $& if m{^[a-zA-Z0-9_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
