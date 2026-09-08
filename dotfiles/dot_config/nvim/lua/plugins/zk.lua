return {
	{
		"dkarter/bullets.vim",
		ft = { "markdown", "text" },
		config = function()
			vim.g.bullets_enabled_file_types = { "markdown", "text" }
			vim.g.bullets_enable_in_empty_buffers = 0
			vim.g.bullets_set_mappings = 1
			vim.g.bullets_checkbox_defaults = { " ", "-", "x" }
		end,
	},

	{
		"zk-org/zk-nvim",
		ft = { "markdown" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local zk = require("zk")

			zk.setup({
				picker = "telescope",
				lsp = {
					config = {
						cmd = { "zk", "lsp" },
						name = "zk",
						on_attach = function(client, bufnr)
							local opts = { buffer = bufnr, silent = true }

							vim.keymap.set(
								"n",
								"<leader>zn",
								"<cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
								opts
							)
							vim.keymap.set("n", "<leader>zo", "<cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
							vim.keymap.set("n", "<leader>zb", "<cmd>ZkBacklinks<CR>", opts)
							vim.keymap.set("n", "<leader>zf", "<cmd>ZkLinks<CR>", opts)

							vim.keymap.set("n", "gf", function()
								local line = vim.api.nvim_get_current_line()
								local link = line:match("%[%[(.-)%]%]") or vim.fn.expand("<cfile>")

								link = vim.split(link, "|")[1]

								local logseq_name = link:gsub("/", "___")

								local root = client.config.root_dir or vim.fn.expand("~/Documents/logseq")
								local page_path = root .. "/pages/" .. logseq_name .. ".md"
								local journal_path = root .. "/journals/" .. logseq_name .. ".md"

								if vim.fn.filereadable(page_path) == 1 then
									vim.cmd("edit " .. vim.fn.fnameescape(page_path))
									return
								end

								if vim.fn.filereadable(journal_path) == 1 then
									vim.cmd("edit " .. vim.fn.fnameescape(journal_path))
									return
								end

								local confirm = vim.fn.confirm(
									"Note '" .. logseq_name .. ".md' does not exist. Create it?",
									"&Yes\n&No",
									1
								)
								if confirm == 1 then
									vim.cmd("edit " .. vim.fn.fnameescape(page_path))
									vim.api.nvim_buf_set_lines(0, 0, -1, false, { "- title:: " .. link, "" })
								end
							end, { buffer = bufnr, desc = "Logseq Zk gf Jump" })
						end,
					},
				},
			})
		end,
	},
}
