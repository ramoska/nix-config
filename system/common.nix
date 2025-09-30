{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  time.timeZone = "Europe/Vilnius";

  nix.gc = {
    automatic = true;
    interval = [
      { Hour = 9; Minute = 45; Weekday = 1; }
    ];
  };

  programs.direnv = {
    enable = true;
    silent = true;
  };
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    fastfetch
    jujutsu
    openssh
    git
    fzf
    atuin
    spotify
    zoxide
    obsidian
  ];
}
