{
  description = "ramoska nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixos-hardware, nix-flatpak }:
  {
    inherit nixpkgs;

    mbp = {
      imports = [
        ./modules/common/all.nix
        nixos-hardware.nixosModules.apple-t2
        nix-flatpak.nixosModules.nix-flatpak
        ./modules/nixos/all.nix
        ./modules/nixos/flatpak.nix
      ];
    };

    work = {
      imports = [
        ./modules/common/all.nix
        ./modules/darwin/all.nix
        ./modules/darwin/work.nix
      ];
    };
  };
}
