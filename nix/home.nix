{ pkgs, ... }:
{
  home.username = "zackhsi";
  home.homeDirectory = /Users/zackhsi;
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  home.packages = [
    pkgs.nixfmt-rfc-style
  ];
}