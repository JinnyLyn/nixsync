{
  description = "shared nixos config (excluding hardware settings) for desktop and laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }: 
    let
      baseConfig = import ./configuration.nix {
        config = { };
        pkgs = nixpkgs;
        lib = nixpkgs.lib;
      };
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
