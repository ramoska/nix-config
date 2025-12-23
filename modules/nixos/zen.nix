{ inputs, pkgs, ... }:
{

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        .zen-wrapped
      ''; # or just "zen" if you use unwrapped package
      mode = "0755";
    };
  };

  home-manager.users.ramoska = {
    imports = [ inputs.zen-browser.homeModules.beta ];

    programs.zen-browser = {
      enable = true;
      nativeMessagingHosts = [ pkgs.firefoxpwa ];
      policies = {
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        Containers.Enabled = true;
        ExtensionSettings = {
          "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4607619/1password_x_password_manager.xpi";
            installation_mode = "force_installed";
          };
          "@testpilot-containers" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
            installation_mode = "force_installed";
          };
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
        };
        Preferences = {
          browser = {
            tabs.warnOnClose = false;
            download.panel.shown = false;
          };
        };
      };
      profiles.default = let
        spaces = {
          Personal = {
            id = "019b4bc4-3aa1-743f-83d8-76078f2a3879";
            icon = "✉️";
            position = 1000;
            container = containers.Personal.id;
          };
          Video = {
            id = "019b4bd5-a30d-73fb-9f7e-c6cdcbc58e57";
            icon = "▶️";
            position = 2000;
          };
        };
        containers = {
          Personal = {
            id = 1;
            color = "blue";
            icon = "fingerprint";
          };
          Banking = {
            id = 2;
            color = "green";
            icon = "dollar";
          };
          Shopping = {
            id = 3;
            color = "yellow";
            icon = "cart";
          };
        };
        pins = {
          "Proton mail" = {
            id = "019b4bf6-42f5-764e-9044-c2f40956642a";
            workspace = spaces.Personal.id;
            container = containers.Personal.id;
            url = "https://mail.proton.me/u/0/inbox";
            position = 100;
          };
          Gmail = {
            id = "019b4bf1-fefa-7763-845e-2472080ca66b";
            workspace = spaces.Personal.id;
            container = containers.Personal.id;
            url = "https://mail.google.com/mail/u/0/#inbox";
            position = 110;
          };
          Youtube = {
            id = "019b4ca1-909f-738a-a25c-d84358adfe2b";
            workspace = spaces.Video.id;
            container = containers.Personal.id;
            url = "https://youtube.com";
            position = 200;
          };
        };
      in {
        containersForce = true;
        pinsForce = true;
        spacesForce = true;
        inherit spaces containers pins;

        extensions.packages = [];
        search = {
          force = true;
          default = "ddg";
        };
        settings = {
          "zen.tabs.show-newtab-vertical" = false;
          "zen.theme.accent-color" = "#8aadf4";
          "zen.urlbar.behavior" = "float";
          "zen.view.compact.enable-at-startup" = true;
          "zen.view.compact.hide-toolbar" = true;
          "zen.view.compact.toolbar-flash-popup" = true;
          "zen.view.show-newtab-button-top" = false;
          "zen.view.window.scheme" = 0;
          "zen.welcome-screen.seen" = true;
          "zen.workspaces.continue-where-left-off" = true;
        };
      };
    };

    home.stateVersion = "25.05";
  };
}
