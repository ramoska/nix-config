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

  outputs = inputs@{ self, nix-darwin, nixpkgs,  nixos-hardware }:
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
        ];
      };
    };
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/common.nix
          ./system/nixos-common.nix
          ./system/desktop.nix
        ];
      };
      mbp16 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
         nixos-hardware.nixosModules.apple-t2
         ./system/common.nix
         ./system/nixos-common.nix
         ./system/mbp16.nix
        ];
      };
    };
  };
}
