{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  time.timeZone = "Europe/Vilnius";

  programs.direnv = {
    enable = true;
    silent = true;
  };
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    fastfetch
    btop
    jujutsu
    openssh
    git
    fzf
    atuin
    zoxide
    nushell
    tree
    stow
  ];
}
