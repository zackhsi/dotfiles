{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, home-manager, ...}: {
    homeConfigurations = {
      zackhsi = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [ ./home.nix ];
      };
    };
  };
}