{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    docker-credential-helpers
    colima
    kubectl
    kubelogin-oidc
    google-cloud-sdk
    tig
    s3cmd
    tree
    k3d
    k9s
    telepresence2
    kubernetes-helm
    yq
    jq
    hyperfine
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
