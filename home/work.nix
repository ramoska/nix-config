{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";
  home.homeDirectory = "/Users/irmantas.ramoska";
  home.username = "irmantas.ramoska";

  programs.home-manager.enable = true;
}
