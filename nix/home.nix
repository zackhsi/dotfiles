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
  ];
  home.file = {
    ".gitconfig" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/gitconfig"; };
    ".gitignore" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/gitignore"; };
    ".tmux.conf" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/tmux.conf"; };
    "Library/Application Support/Cursor/User/settings.json" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/cursor_settings.json"; };
    ".zshrc" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/zshrc"; };
  };
  programs.home-manager.enable = true;
}