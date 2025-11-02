{
  description = "ramoska nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixos-hardware }:
  {
    inherit nix-darwin;

    commonModules = {
      all = ./modules/common/all.nix;
    };

    darwinModules = {
      all = ./modules/darwin/all.nix;
      work = ./modules/darwin/work.nix;
    };

    nixosModules = {
      all = ./modules/nixos;
    };
  };
}
