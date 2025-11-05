all: files brew pip2 pip3 tmux_plugins ## Make it all!

files: ## Ensure files are up to date
	./manage

intellij_backup: ## Back up IntelliJ settings.
	@rm -rf /tmp/intellij-settings
	@echo "Copying IntelliJ to /tmp/intellij-settings"
	@cp -r ~/Library/Preferences/IntelliJIdea2019.3/settingsRepository/repository /tmp/intellij-settings
	@rm -rf /tmp/intellij-settings/.git
	@rm -f /tmp/intellij-settings/vim_settings.xml
	@rm -f /tmp/intellij-settings/find.xml
	@echo "Nuking ${HOME}/dotfiles/intellij-settings"
	@rm -rf ~/dotfiles/intellij-settings
	@mv -v /tmp/intellij-settings/ ~/dotfiles/intellij-settings

nix: ## Nix home manager
	@bash nix.sh

rust: ## Install rust ecosystem
	@command -v rustc &> /dev/null || (echo "Installing rust..." && curl https://sh.rustup.rs -sSf | sh)

brew: ## Install formulas in Brewfile
	brew bundle

node: ## Install local npm packages
	npm install

.DEFAULT_GOAL := help
.PHONY: help nix
help:
	@perl -nle'print $& if m{^[a-zA-Z0-9_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
