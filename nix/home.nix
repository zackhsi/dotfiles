{ config, pkgs, ... }:
{
  home.username = "zackhsi";
  home.homeDirectory = /Users/zackhsi;
  home.stateVersion = "25.05";
  home.packages = [
    pkgs.neovim
    pkgs.nixfmt-rfc-style
    pkgs.starship
    pkgs.tmux
    pkgs.tree
    pkgs.zsh-autosuggestions
  ];
  home.file = {
    ".gitconfig" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/gitconfig"; };
    ".gitignore" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/gitignore"; };
    ".tmux.conf" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/tmux.conf"; };
    ".zshrc" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/zshrc"; };
    "Library/Application Support/Cursor/User/settings.json" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/cursor_settings.json"; };
    "Library/Application Support/com.mitchellh.ghostty/config" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/ghostty_config"; };
  };
  programs.home-manager.enable = true;
}