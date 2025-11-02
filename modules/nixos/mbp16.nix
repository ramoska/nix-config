{ config, pkgs, ... }:

{
  modules = [
    nixos-hardware.nixosModules.apple-t2
  ];
}
