{ config, pkgs, ... }:
{
  home.username = "zackhsi";
  home.homeDirectory = /Users/zackhsi;
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  home.packages = [
    pkgs.nixfmt-rfc-style
    pkgs.tmux
  ];
  home.file = {
    ".tmux.conf" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/tmux.conf"; };
    ".gitignore" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/gitignore"; };
    ".gitconfig" = { source = config.lib.file.mkOutOfStoreSymlink "/Users/zackhsi/dotfiles/nix/sources/gitconfig"; };
  };
}