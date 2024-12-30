{ config, pkgs, ... }:

{
  users.users."irmantas.ramoska".home = "/Users/irmantas.ramoska";

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
    ];
  };
}
