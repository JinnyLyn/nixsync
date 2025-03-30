{
  description = "Shared NixOS configuration (excluding hardware settings) for laptop and desktop/WSL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";  # Adjust as needed to match your system.stateVersion.
  };

  outputs = { self, nixpkgs, ... }:
    let
      # Use the full (legacy) package set to ensure attributes like pkgs.fish exist.
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
      # Import your configuration.nix using the proper pkgs and lib.
      baseConfig = import ./configuration.nix {
        config = { };
        pkgs = pkgs;
        lib = nixpkgs.lib;
      };
      # Remove hardware-configuration.nix from the imports.
      finalConfig = baseConfig // {
        imports = builtins.filter (i: i != ./hardware-configuration.nix) baseConfig.imports;
      };
    in {
      nixosConfigurations = {
        # Laptop configuration: it imports a local hardware file that you set up only on your laptop.
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            finalConfig
            (import ./hardware-configuration.laptop.nix)
          ];
        };
        # Desktop (or WSL) configuration: no hardware module is included.
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ finalConfig ];
        };
      };
    };
}

