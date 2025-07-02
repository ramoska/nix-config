{ config, pkgs, ... }:

{
  users.users."irmantas.ramoska".home = "/Users/irmantas.ramoska";
  system.primaryUser = "irmantas.ramoska";

  programs.direnv.enable = true;

  homebrew = {
    brews = [ "podman" "podman-compose" "kubelogin" "kubectl" ];

    casks = [
      {
        name = "google-cloud-sdk";
        greedy = true;
      }
      {
        name = "podman-desktop";
        greedy = true;
      }
      {
        name = "slack";
        greedy = true;
      }
      {
        name = "google-chrome";
        greedy = true;
      }
      {
        name = "bruno";
        greedy = true;
      }
      {
        name = "phpstorm";
        greedy = true;
      }
      {
        name = "pycharm";
        greedy = true;
      }
    ];
  };
}
