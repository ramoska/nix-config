{ config, pkgs, ... }:

{
  users.users."irmantas.ramoska".home = "/Users/irmantas.ramoska";
  system.primaryUser = "irmantas.ramoska";

  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    bruno
    podman
    podman-compose
    kubectl
    kubelogin-oidc
    podman-desktop
    slack
  ];
  homebrew = {
    casks = [
      {
        name = "gcloud-cli";
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
      {
        name = "goland";
        greedy = true;
      }
    ];
  };
}
