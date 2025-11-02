{ config, pkgs, nixos-hardware }:

{
  modules = [
    nixos-hardware.nixosModules.apple-t2
  ];
}
