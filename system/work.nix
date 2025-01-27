{ config, pkgs, ... }:

{
  users.users."irmantas.ramoska".home = "/Users/irmantas.ramoska";

  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
  ];
  homebrew = {
    brews = ["minikube" "podman" "podman-compose"];
    casks = [
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
