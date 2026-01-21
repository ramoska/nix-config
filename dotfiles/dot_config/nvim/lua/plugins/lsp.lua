return {
	{ "direnv/direnv.vim" },
	{
		"neovim/nvim-lspconfig",
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

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local opts = { buffer = args.buf }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})

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
		"saghen/blink.cmp",
		version = "*", -- Use a release tag to download pre-built binaries
		opts = {
			keymap = { preset = "default" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = { enabled = true },
			completion = {
				menu = { border = "rounded" },
				documentation = { auto_show = true, window = { border = "rounded" } },
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				php = { "php_cs_fixer" },
				go = { "gofmt", "goimports" },
				python = { "black" },
				nix = { "nixpkgs_fmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
}
