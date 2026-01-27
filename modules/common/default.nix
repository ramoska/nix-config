{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  time.timeZone = "Europe/Vilnius";

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    fastfetch
    gemini-cli

    btop
    jujutsu
    openssh
    git
    fzf
    atuin # replece history
    zoxide # replace cd
    nushell
    tree
    chezmoi
    ripgrep
    glow # markdown render in CLI
    fd # replace find
    eza # replace ls
    yq
    jq
    proton-vpn-cli

    beam28Packages.erlang
    beam28Packages.elixir_1_19
    python3

    # for lazyvim
    stdenv.cc
    gnumake
    cmake
    tree-sitter

    # for editing nix and lua files
    nil
    nixpkgs-fmt
    lua-language-server
    stylua

    # Language servers
    python314Packages.python-lsp-server # Python LSP
    yaml-language-server # YAML LSP
    erlang-language-platform
    lexical

    # Tree-sitter parsers
    vimPlugins.nvim-treesitter-parsers.fish
    vimPlugins.nvim-treesitter-parsers.json
    vimPlugins.nvim-treesitter-parsers.nix
    vimPlugins.nvim-treesitter-parsers.python
    vimPlugins.nvim-treesitter-parsers.yaml
    vimPlugins.nvim-treesitter-parsers.lua
    vimPlugins.nvim-treesitter-parsers.erlang
    vimPlugins.nvim-treesitter-parsers.elixir
  ];
}
