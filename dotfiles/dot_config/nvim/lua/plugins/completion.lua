return {
	{
		"saghen/blink.cmp",
		version = "*",
		opts = {
			keymap = {
				preset = "default",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
			},
			sources = {
				default = { "lsp", "buffer", "path", "snippets" },
			},
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				menu = { auto_show = true },
				ghost_text = { enabled = false },
			},
		},
	},
}
