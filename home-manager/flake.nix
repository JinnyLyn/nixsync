let
  system = "x86_64-linux";
in

{
  description = "Standalone home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    {
      homeConfigurations = {
        jin = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home.nix
            {
              home.username = "jin";
              home.homeDirectory = "/home/jin";
              home.stateVersion = "24.11";
            }
          ];
        };
      };
    };
}
