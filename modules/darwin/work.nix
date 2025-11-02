{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    podman
    podman-compose
    kubectl
    kubelogin-oidc
    google-cloud-sdk
    tig
    s3cmd
    tree
  ];
  homebrew = {
    casks = [
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
      {
        name = "slack";
        greedy = true;
      }
      {
        name = "bruno";
        greedy = true;
      }
      {
        name = "sequel-ace";
        greedy = true;
      }
    ];
  };
}
