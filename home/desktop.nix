{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";
  home.homeDirectory = "/home/ramoska";
  home.username = "ramoska";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    obsidian
    kakoune
  ];
}
