.PHONY: all
all: ensure_symlinks install freeze

.PHONY: ensure_symlinks  # Ensure dotfiles are properly symlinked
ensure_symlinks:
	./ensure_symlinks.sh

.PHONY: install  # Install packages via pip and brew
install:
	sudo pip-sync
	brew bundle cleanup --force
	brew bundle check || brew bundle

.PHONY: freeze  # Save installed packages to file
freeze:
	pip-compile > /dev/null
	brew bundle dump --force
