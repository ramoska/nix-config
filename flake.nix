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
    inherit nixpkgs;

    mbp = {
      imports = [
        nixos-hardware.nixosModules.apple-t2
        ./modules/common/all.nix
        ./modules/nixos/all.nix
        ./modules/nixos/mbp.nix
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

