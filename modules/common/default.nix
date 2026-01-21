{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  time.timeZone = "Europe/Vilnius";

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
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
    chezmoi
    ripgrep
    glow
    fd
    eza

    # for lazyvim
    stdenv.cc
    gnumake
    cmake

    # for editing nix and lua files
    nil
    nixpkgs-fmt
    lua-language-server
    stylua
  ];
}
