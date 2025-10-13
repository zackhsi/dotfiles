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

nix_dir="/Users/zackhsi/dotfiles/nix"

cd "$nix_dir"
nix build "$nix_dir#homeConfigurations.zackhsi.activationPackage"
./result/activate