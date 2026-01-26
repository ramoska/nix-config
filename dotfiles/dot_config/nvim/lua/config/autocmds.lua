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

-- Blink plugin would move cursor back by single characer wihout following lines
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.opt.virtualedit = "onemore"
	end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.opt.virtualedit = ""
	end,
})

-- resession autoloading/saving
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			local resession = require("resession")
			resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
		end
	end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		require("resession").save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
	end,
})
