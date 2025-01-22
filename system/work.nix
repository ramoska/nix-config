{ config, pkgs, ... }:

{
  users.users."irmantas.ramoska".home = "/Users/irmantas.ramoska";

  environment.systemPackages = with pkgs; [
    php
  ];
  homebrew = {
    brews = ["minikube"];
    casks = [
      {
        name = "docker";
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
