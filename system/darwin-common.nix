{ config, pkgs, ... }:

{
  services.nix-daemon.enable = true;
  security.pam.enableSudoTouchIdAuth = true;

  # Set Git commit hash for darwin-version.
  system.stateVersion = 5;

  environment.systemPackages = with pkgs; [
    raycast
  ];

  homebrew = {
    enable = true;
    taps = [
      "nikitabobko/tap"
    ];
    casks = [
      {
        name = "aerospace";
        greedy = true;
      }
      {
        name = "kitty";
        greedy = true;
      }
      {
        name = "firefox";
        greedy = true;
      }
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };

  power.sleep.display = 5;

  system.defaults = {
    ".GlobalPreferences"."com.apple.mouse.scaling" = 0.6875;
    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    NSGlobalDomain.AppleShowAllFiles = true;
    NSGlobalDomain."com.apple.springing.delay" = 0.5;
    NSGlobalDomain."com.apple.springing.enabled" = true;
    NSGlobalDomain."com.apple.trackpad.forceClick" = true;
    dock.autohide = true;
    dock.launchanim = false;
    dock.mineffect = "scale";
    dock.minimize-to-application = true;
    dock.mru-spaces = false;
    dock.orientation = "left";
    dock.show-recents = false;
    dock.tilesize = 32;
    finder.ShowPathbar = true;
    loginwindow.LoginwindowText = "ramoska";
  };
}
