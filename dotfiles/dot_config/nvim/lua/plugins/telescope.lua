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
			{ "<leader>fs", "<cmd>Telescope resession<cr>", desc = "Sessions" },
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
			detection_methods = { "pattern", "lsp" },
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

			vim.api.nvim_create_autocmd("DirChanged", {
				callback = function()
					local ok, persistence = pcall(require, "persistence")
					if ok then
						persistence.load()
					end
				end,
			})
		end,
	},
	{
		"stevearc/resession.nvim",
		dependencies = {
			"scottmckendry/pick-resession.nvim",
		},
		keys = {
			{
				"<leader>ss",
				function()
					require("resession").save()
				end,
				desc = "Save Session (Quick)",
			},
			{
				"<leader>sl",
				function()
					require("resession").load()
				end,
				desc = "Load Session",
			},
			{
				"<leader>sd",
				function()
					require("resession").delete()
				end,
				desc = "Delete Session",
			},
			{
				"<leader>se",
				function()
					require("resession").edit()
				end,
				desc = "Edit Session",
			},
			{
				"<leader>sS",
				function()
					require("resession").save(nil, { attach = false })
				end,
				desc = "Save Session (Prompt)",
			},
		},
		event = "VeryLazy",
		opts = {
			buf_filter = function(bufnr)
				local buftype = vim.bo[bufnr].buftype
				if buftype ~= "" then
					return false
				end
				return true
			end,
			dir = "session",
			options = {
				"cursorline",
				"cursorcolumn",
				"list",
				"number",
				"relativenumber",
				"spell",
			},
		},
		config = function(_, opts)
			local resession = require("resession")
			resession.setup(opts)

			pcall(require("telescope").load_extension, "resession")

			vim.api.nvim_create_autocmd("User", {
				pattern = "ResessionLoadPost",
				callback = function()
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "" then
							vim.api.nvim_buf_call(buf, function()
								vim.cmd("filetype detect")
								vim.cmd("LspStart")
							end)
						end
					end
					vim.defer_fn(function()
						vim.cmd("normal! zR")
					end, 150)
				end,
			})
		end,
	},
}
