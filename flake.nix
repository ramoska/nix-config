{
  description = "ramoska nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#O-MVHJ6XDR
    darwinConfigurations = {
      "O-MVHJ6XDR" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        system = "aarch64-darwin";
        modules = [
          ./system/common.nix
          ./system/darwin-common.nix
          ./system/work.nix
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."irmantas.ramoska" = import ./home/work.nix;
          }
        ];
      };
    };
  };
}
