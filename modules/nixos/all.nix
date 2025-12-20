{ pkgs, inputs, ... }:

{
#  imports = [
#    ./zen.nix
#  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.consoleLogLevel = 3;

  networking.networkmanager.enable = true;
  
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

  systemd.user.services = {
    swayidle = {
      description = "Idle service";
      after = [ "niri.service" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.swayidle}/bin/swayidle";
        Restart = "on-failure";
      };
    };
    swww-deamon = {
      description = "Deamon to manage wallpapers";
      after = [ "niri.service" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "on-failure";
      };
    };
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
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.monaspace
  ];

  environment.systemPackages = with pkgs; [
    dunst  # notification system
    waybar
    fuzzel  # launcher
    hyprlock  # more customizable compared to swaylock
    swayidle  # use of standard protocols compared t hypridle
    swww  # deamon, will be 
    pavucontrol
    brightnessctl
    
    ghostty
    _1password-cli
    _1password-gui
  ];
  environment.localBinInPath = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };

  programs.firefox.enable = true;

  users.defaultUserShell = pkgs.fish;
  users.users.ramoska = {
    isNormalUser = true;
    description = "ramoska";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
