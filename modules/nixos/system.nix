{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.consoleLogLevel = 3;

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    tuigreet  # login manager

    ghostty
    _1password-cli
    _1password-gui
  ];
  environment.localBinInPath = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.gvfs.enable = true;  # gnome virtual filesystem to handle external storage
  services.udisks2.enable = true;  # handles mounting USB drives
  services.devmon.enable = true;  # auto-mount USB drives

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet " +
          "--time --remember --remember-session --asterisks " +
          "--container-padding 2 " +
          "--greeting 'Welcome to NixOS' " +
          "--theme 'container=black;border=red;text=white;prompt=magenta;action=red;button=white;input=white'";
        user = "greeter";
      };
    };
  };

  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.monaspace
    nerd-fonts.jetbrains-mono
  ];
}
