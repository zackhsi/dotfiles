.PHONY: all
all: ensure_symlinks pip homebrew

.PHONY: ensure_symlinks
ensure_symlinks:
	./ensure_symlinks.sh

.PHONY: pip
pip:
	pip-compile requirements.in
	pip-sync

.PHONY: homebrew
homebrew:
	brew update
	brew doctor
	brew bundle cleanup --force
	brew bundle check || brew bundle
	brew bundle dump --force
