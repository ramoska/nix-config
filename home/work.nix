{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";
  home.homeDirectory = "/Users/irmantas.ramoska";
  home.username = "irmantas.ramoska";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    tig
    s3cmd
  ];
}
