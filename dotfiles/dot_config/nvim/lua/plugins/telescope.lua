return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
		end,
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
}
