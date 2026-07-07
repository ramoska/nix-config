return {
	{ "direnv/direnv.vim" },
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Updated helper to accept an optional configuration settings block
			local function setup_server(server_name, cmd_name, custom_opts)
				if vim.fn.executable(cmd_name) == 1 then
					local opts = custom_opts or {}
					if vim.lsp.config then
						vim.lsp.config(server_name, opts)
						vim.lsp.enable(server_name)
					else
						require("lspconfig")[server_name].setup(opts)
					end
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local opts = { buffer = args.buf }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})

			setup_server("nil_ls", "nil")
			setup_server("gopls", "gopls")
			setup_server("phpactor", "phpactor")
			setup_server("elixirls", "expert")
			setup_server("ts_ls", "typescript-language-server")
			setup_server("html", "vscode-html-language-server")
			setup_server("cssls", "vscode-css-language-server")
			setup_server("jsonls", "vscode-json-language-server")
			setup_server("lua_ls", "lua-language-server")
			setup_server("yamlls", "yaml-language-server")
			setup_server("marksman", "marksman")

			setup_server("pylsp", "pylsp", {
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = { enabled = false },
							pyflakes = { enabled = false },
							mccabe = { enabled = false },
							preload = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
						},
					},
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				php = { "php_cs_fixer" },
				go = { "gofmt", "goimports" },
				python = { "ruff_format" },
				nix = { "nixpkgs_fmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
}
