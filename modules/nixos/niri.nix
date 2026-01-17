{ pkgs, ... }:

{
  programs.niri.enable = true;
  programs.thunar.enable = true;

  environment.systemPackages = with pkgs; [
    swaynotificationcenter # notifications daemon
    libnotify
    waybar
    fuzzel  # launcher
    hyprlock  # more customizable compared to swaylock
    swayidle  # use of standard protocols compared t hypridle
    swww  # deamon, will be used to change wallpaper on theme change
    brightnessctl
    gammastep  # color temp switch

    librsvg  # render svg
    adwaita-icon-theme
    papirus-icon-theme
  ];

  systemd.user.services = {
    swaync = {
      description = "Notifications service";
      after = [ "niri.service" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
        Restart = "on-failure";
      };
    };
    swayidle = {
      description = "Idle service";
      after = [ "niri.service" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.swayidle}/bin/swayidle";
        Restart = "on-failure";
      };
    };
    swww-daemon = {
      description = "Daemon to manage wallpapers";
      after = [ "niri.service" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "on-failure";
      };
    };
  };
}

