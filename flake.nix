{
  description = "ramoska nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixos-hardware }:
    {
      inherit nixpkgs nix-darwin;

      mbp-nixos = {
        imports = [
          nixos-hardware.nixosModules.apple-t2
          ./modules/common
          ./modules/nixos
          ./modules/nixos/mbp.nix
        ];
      };

      mbp-darwin = {
        imports = [
          ./modules/common
          ./modules/darwin
          ./modules/darwin/personal.nix
        ];
      };

      desktop = {
        imports = [
          ./modules/common
          ./modules/nixos
        ];
      };

      work = {
        imports = [
          ./modules/common
          ./modules/darwin
          ./modules/darwin/work.nix
        ];
      };
    };
}

