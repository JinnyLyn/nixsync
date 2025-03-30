{
  description = "Shared NixOS configuration (excluding hardware settings) for laptop and desktop/WSL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      # Use the legacyPackages for a complete package set.
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      # Import your configuration.nix with the proper pkgs and lib.
      baseConfig = import ./configuration.nix {
        config = { };
        pkgs = pkgs;
        lib = nixpkgs.lib;
      };
      # Override the imports so hardware-specific configurations are not applied.
      finalConfig = baseConfig // { imports = []; };
    in {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ finalConfig ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ finalConfig ];
        };
      };
    };
}

