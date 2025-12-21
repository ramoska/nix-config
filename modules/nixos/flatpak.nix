{ pkgs, ... }:

{
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  services.flatpak = {
    enable = true;
    update.onActivation = true;
    uninstallUnmanaged = true;
    
    remotes = [{
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }];

    packages = [
      "app.zen_browser.zen"
    ];
  };
}
