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
    s3cmd
    tree
    k3d
    k9s
    telepresence2
    kubernetes-helm
    yq
    jq
    hyperfine
    gemini-cli
    # Language servers
    gopls # Go LSP
    python3
    python314Packages.python-lsp-server # Python LSP
    yaml-language-server # YAML LSP
    typescript-language-server # TypeScript/JavaScript LSP
    phpactor # PHP LSP

    # Tree-sitter parsers
    vimPlugins.nvim-treesitter-parsers.bash
    vimPlugins.nvim-treesitter-parsers.fish
    vimPlugins.nvim-treesitter-parsers.go
    vimPlugins.nvim-treesitter-parsers.javascript
    vimPlugins.nvim-treesitter-parsers.json
    vimPlugins.nvim-treesitter-parsers.nix
    vimPlugins.nvim-treesitter-parsers.php
    vimPlugins.nvim-treesitter-parsers.python
    vimPlugins.nvim-treesitter-parsers.typescript
    vimPlugins.nvim-treesitter-parsers.yaml
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
