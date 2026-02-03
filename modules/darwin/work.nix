{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    docker-credential-helpers
    colima
    kubectl
    kubelogin-oidc
    google-cloud-sdk
    s3cmd
    k3d
    k9s
    telepresence2
    kubernetes-helm
    hyperfine

    # Language servers
    gopls # Go LSP
    typescript-language-server # TypeScript/JavaScript LSP
    phpactor # PHP LSP

    # Tree-sitter parsers
    vimPlugins.nvim-treesitter-parsers.go
    vimPlugins.nvim-treesitter-parsers.javascript
    vimPlugins.nvim-treesitter-parsers.php
    vimPlugins.nvim-treesitter-parsers.typescript
    vimPlugins.nvim-treesitter-parsers.twig
    vimPlugins.nvim-treesitter-parsers.html
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
      {
        name = "claude-code";
        greedy = true;
      }
    ];
  };
}
