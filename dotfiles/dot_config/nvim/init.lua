-- ========================================================================== --
-- ==                           BASIC SETTINGS                             == --
-- ========================================================================== --
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus" -- Sync with wl-clipboard

-- ========================================================================== --
-- ==                         LAZY.NVIM SETUP                              == --
-- ========================================================================== --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- 1. Direnv integration (Crucial for Nix workflow)
    { 'direnv/direnv.vim' },

    -- 2. Treesitter (Syntax highlighting)
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup({
          ensure_installed = {
            -- work languages
            "lua", "nix", "php", "python", "go",
            -- web dev
            "html", "css", "javascript", "typescript", "tsx", "json", "yaml",
            -- interesting languages
            "elixir", "erlang"
          },
          highlight = { enable = true },
        })
      end
    },

    -- 3. LSP Config (Purely configuration, NO MASON)
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
      },
      config = function()
        local lspconfig = require('lspconfig')
        
        -- Helper to only start LSPs if Nix/Direnv provided the binary
        local function setup_server(server, cmd_name)
          if vim.fn.executable(cmd_name) == 1 then
            lspconfig[server].setup{}
          end
        end

        -- Map of LSPs to their binary names
        setup_server('nil_ls', 'nil')
        setup_server('gopls', 'gopls')
        setup_server('pyright', 'pyright-langserver')
        setup_server('phpactor', 'phpactor')
        setup_server('elixirls', 'elixir-ls')
        setup_server('ts_ls', 'typescript-language-server')
        setup_server('html', 'vscode-html-language-server')
        setup_server('cssls', 'vscode-css-language-server')
        setup_server('jsonls', 'vscode-json-language-server')
      end
    },
  },
  -- SECURITY & STABILITY SETTINGS
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- Pinned versions
  checker = { enabled = false }, -- Do not auto-check for updates from the web
  change_detection = { notify = false },
})
