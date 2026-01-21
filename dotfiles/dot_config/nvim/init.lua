vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ "direnv/direnv.vim" },
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				local status, ts_configs = pcall(require, "nvim-treesitter.configs")
				if not status then
					return
				end

				ts_configs.setup({
					ensure_installed = {
						"lua",
						"nix",
						"php",
						"python",
						"go",
						"html",
						"css",
						"javascript",
						"typescript",
						"tsx",
						"json",
						"yaml",
						"elixir",
						"erlang",
					},
					highlight = { enable = true },
				})
			end,
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"hrsh7th/nvim-cmp",
				"hrsh7th/cmp-nvim-lsp",
			},
			config = function()
				local function setup_server(server_name, cmd_name)
					if vim.fn.executable(cmd_name) == 1 then
						if vim.lsp.config then
							vim.lsp.config(server_name, {})
							vim.lsp.enable(server_name)
						else
							require("lspconfig")[server_name].setup({})
						end
					end
				end

				setup_server("nil_ls", "nil")
				setup_server("gopls", "gopls")
				setup_server("pyright", "pyright-langserver")
				setup_server("phpactor", "phpactor")
				setup_server("elixirls", "lexical")
				setup_server("ts_ls", "typescript-language-server")
				setup_server("html", "vscode-html-language-server")
				setup_server("cssls", "vscode-css-language-server")
				setup_server("jsonls", "vscode-json-language-server")
				setup_server("lua_ls", "lua-language-server")
			end,
		},
		{
			"nvimdev/dashboard-nvim",
			event = "VimEnter",
			config = function()
				require("dashboard").setup({
					theme = "hyper",
					config = {
						week_header = { enable = true },
						shortcut = {
							{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
							{ desc = " Files", group = "Label", action = "Telescope find_files", key = "f" },
							{
								desc = "󰄉 Projects",
								group = "DiagnosticHint",
								action = function()
									require("telescope").extensions.projects.projects()
								end,
								key = "p",
							},
						},
					},
				})
			end,
			dependencies = { { "nvim-tree/nvim-web-devicons" } },
		},
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			cmd = "Telescope",
			keys = {
				{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
				{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
				{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
			},
			opts = {},
		},
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
			},
			keys = {
				{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
			},
			opts = {
				filesystem = {
					filtered_items = { visible = true },
					follow_current_file = { enabled = true },
				},
			},
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {
				options = {
					theme = "auto",
					component_separators = "|",
					section_separators = "",
				},
			},
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					php = { "php-cs-fixer" },
					go = { "gofmt", "goimports" },
					python = { "black" },
					nix = { "nixpkgs-fmt" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			},
		},
		{
			"folke/flash.nvim",
			event = "VeryLazy",
			opts = {},
			keys = {
				{
					"s",
					mode = { "n", "x", "o" },
					function()
						require("flash").jump()
					end,
					desc = "Flash",
				},
				{
					"S",
					mode = { "n", "x", "o" },
					function()
						require("flash").treesitter()
					end,
					desc = "Flash Treesitter",
				},
			},
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		{
			"folke/persistence.nvim",
			event = "BufReadPre",
			opts = {},
		},
		{
			"ahmedkhalf/project.nvim",
			event = "VeryLazy",
			opts = {
				manual_mode = false,
				patterns = { ".jj" },
				detection_methods = { "lsp", "pattern" },
			},
			config = function(_, opts)
				require("project_nvim").setup(opts)

				local history = require("project_nvim.utils.history")
				history.delete_project = function(project)
					for k, v in pairs(history.recent_projects) do
						if v == project.value then
							history.recent_projects[k] = nil
							return
						end
					end
				end

				pcall(require("telescope").load_extension, "projects")
			end,
		},
	},
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
	checker = { enabled = false },
	change_detection = { notify = false },
})
