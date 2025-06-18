# { config, pkgs, ... }:

# {
#   nix.enable = false;

#   # Create /etc/zshrc that loads the nix-darwin environment.
#   programs.zsh.enable = true;

#   # Used for backwards compatibility, please read the changelog before changing.
#   system.stateVersion = 4;

#   # You should generally set this to the total number of logical cores in your system.
#   nix.settings.max-jobs = 8;

#   # Enable nix flakes
#   nix.settings.experimental-features = [ "nix-command" "flakes" ];
# } 