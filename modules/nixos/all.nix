{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.consoleLogLevel = 3;

  networking.networkManager.enable = true;
  
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "lt_LT.UTF-8";
    LC_IDENTIFICATION = "lt_LT.UTF-8";
    LC_MEASUREMENT = "lt_LT.UTF-8";
    LC_MONETARY = "lt_LT.UTF-8";
    LC_NAME = "lt_LT.UTF-8";
    LC_PAPER = "lt_LT.UTF-8";
    LC_TELEPHONE = "lt_LT.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  programs.niri.enable = true;
  programs.regreet.enable = true;
  programs.thunar.enable = true;
  services.gvfs.enable = true;

  fonts.fontconfig.enable = true;
  fonts.fontpackages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.monaspace
  ];

  environment.systemPackages = with pkgs; [
    dunst
    waybar
    fuzzel
    hyprlock
    hypridle
  ];

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };

  users.users.ramoska = {
    inNormalUser = true;
    desrciption = "ramoska";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
