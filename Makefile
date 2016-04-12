all: files brew pip ## Make it all!

files: ## Ensure files are up to date
	./manage

pip: ## Ensure only pip packages in requirements.in are installed
	pip freeze | xargs pip uninstall -y -q
	pip install -r requirements.in --upgrade -q
	pip freeze -r requirements.in > requirements.txt

brew: ## Install formulas in Brewfile
	./homebrew

npm_freeze: ## Freeze node packages into Nodefile
	npm ls -g --depth=0 > Nodefile

.DEFAULT_GOAL := help
.PHONY: help
help:
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
