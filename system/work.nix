{ config, pkgs, ... }:

{
  users.users."irmantas.ramoska".home = "/Users/irmantas.ramoska";

  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
  ];
  homebrew = {
    brews = ["minikube" "podman" "podman-compose" "docker" "docker-compose"];
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
