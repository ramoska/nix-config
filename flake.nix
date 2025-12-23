{
  description = "ramoska nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixos-hardware, zen-browser, home-manager }:
  {
    inherit nixpkgs;

    mbp = {
      imports = [
        nixos-hardware.nixosModules.apple-t2
        home-manager.nixosModules.home-manager
        ./modules/common/all.nix
        ./modules/nixos/all.nix
        ./modules/nixos/zen.nix
      ];
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs; };
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

