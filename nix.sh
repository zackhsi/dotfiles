#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status messages
log() {
    echo -e "${GREEN}[+]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[!]${NC} $1"
}

error() {
    echo -e "${RED}[x]${NC} $1"
    exit 1
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    error "This script is only for macOS"
fi

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    error "This script should not be run as root"
fi

# Check if Nix is installed
if ! command -v nix >/dev/null 2>&1; then
    error "`nix` is not installed"
fi

nix build ./nix#homeConfigurations.zackhsi.activationPackage
./result/activate

# sudo nix run nix-darwin \
#   --extra-experimental-features nix-command \
#   --extra-experimental-features flakes \
#   -- \
#   switch --flake ~/dotfiles/nix

# # Check if nix-darwin is installed
# if ! command -v darwin-rebuild >/dev/null 2>&1; then
#     log "Installing nix-darwin..."
#     darwin-rebuild switch --flake .#Mac
# else
#     log "nix-darwin is already installed"
# fi

# # Check if home-manager is installed
# if ! command -v home-manager >/dev/null 2>&1; then
#     log "Installing home-manager..."
#     nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
#     nix-channel --update
#     nix-shell '<home-manager>' -A install
# else
#     log "home-manager is already installed"
# fi

# Create necessary directories if they don't exist
# log "Setting up configuration directories..."
# mkdir -p ~/.config/nixpkgs
# mkdir -p ~/.config/home-manager

# # Link configuration files
# log "Linking configuration files..."
# if [[ ! -L ~/.config/nixpkgs/flake.nix ]]; then
#     ln -sf "$(pwd)/nix/flake.nix" ~/.config/nixpkgs/flake.nix
# fi

# if [[ ! -L ~/.config/nixpkgs/home.nix ]]; then
#     ln -sf "$(pwd)/nix/home.nix" ~/.config/nixpkgs/home.nix
# fi

# if [[ ! -L ~/.config/nixpkgs/darwin.nix ]]; then
#     ln -sf "$(pwd)/nix/darwin.nix" ~/.config/nixpkgs/darwin.nix
# fi

# # Build and switch to the new configuration
# log "Building and switching to the new configuration..."
# nix build ~/.config/nixpkgs#darwinConfigurations.$(hostname -s).system
# ./result/sw/bin/darwin-rebuild switch

# log "Configuration complete! Please restart your terminal." 