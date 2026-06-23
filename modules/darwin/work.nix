{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    docker-credential-helpers
    colima
    kubectl
    kubelogin-oidc
    google-cloud-sdk
    rclone
    k3d
    k9s
    telepresence2
    kubernetes-helm
    hyperfine
    lazydocker

    # Language servers
    gopls # Go LSP
    typescript-language-server # TypeScript/JavaScript LSP
    phpactor # PHP LSP
    intelephense # PHP LSP used by claude-code oficial PHP LSP plugin

    # Tree-sitter parsers
    vimPlugins.nvim-treesitter-parsers.go
    vimPlugins.nvim-treesitter-parsers.javascript
    vimPlugins.nvim-treesitter-parsers.php
    vimPlugins.nvim-treesitter-parsers.typescript
    vimPlugins.nvim-treesitter-parsers.twig
    vimPlugins.nvim-treesitter-parsers.html

    inputs.hunk.packages.${pkgs.stdenv.hostPlatform.system}.hunk
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
