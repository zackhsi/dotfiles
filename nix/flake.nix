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
        # System is very important!
        pkgs = import nixpkgs { system = "aarch64-darwin"; };

        modules = [ ./home.nix ]; # Defined later
      };
    };
  };
}




# {
#   description = "My macOS Nix Configuration";

#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
#     home-manager = {
#       url = "github:nix-community/home-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#     darwin = {
#       url = "github:lnl7/nix-darwin";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#   };

#   outputs = { self, nixpkgs, home-manager, darwin }:
#     let
#       system = "aarch64-darwin";
#       username = "zackhsi";
#       configuration = { pkgs, config, ... }: {
#         users = {
#             users.${username} = {
#               home = "/Users/${username}";
#               name = "${username}";
#             };
#           };
#       };  
#     in {
#       darwinConfigurations.${username} = darwin.lib.darwinSystem {
#         inherit system;
#         modules = [
#           configuration
#           ./darwin.nix
#           home-manager.darwinModules.home-manager
#           {
#             home-manager = {
#               useGlobalPkgs = true;
#               useUserPackages = true;
#               users.${username} = import ./home.nix;
#             };
#           }
#         ];
#       };
#     };
# } 