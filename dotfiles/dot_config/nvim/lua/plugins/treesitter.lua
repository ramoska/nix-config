return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end,
			},
		},
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
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["ai"] = "@conditional.outer",
							["ii"] = "@conditional.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>nm"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>pm"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},
}
