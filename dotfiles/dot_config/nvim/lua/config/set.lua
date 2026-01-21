vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.fixeol = false
vim.opt.eol = true
vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("OpenFolds", { clear = true }),
	pattern = "*",
	callback = function()
		vim.defer_fn(function()
			if vim.api.nvim_buf_is_valid(0) then
				pcall(vim.cmd, "normal! zR")
			end
		end, 10)
	end,
})
