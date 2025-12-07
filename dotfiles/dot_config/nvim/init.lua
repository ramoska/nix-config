-- SETTINGS: Relative Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- SETTINGS: Basic Quality of Life
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8

vim.cmd("highlight StatusLineFileType guifg=#aaffaa guibg=#222222")

vim.opt.statusline = 
  -- Left side
  "%#StatusLineFileType# %y " ..   -- Highlighted File Type [lua] followed by a space
  "%#StatusLine# " ..                -- Switch back to standard highlight
  "%F " ..                           -- Full Path
  "%M%r" ..                          -- Modified and Read-Only flags (no space between)
  -- Alignment and Right side
  "%=" ..                            -- Right alignment marker
  "%l:%c" ..                         -- Line:Column (e.g., 10:5)
  " | " ..                           -- A pipe separator
  "%P"                               -- Percentage through file (e.g., 50%)

vim.opt.laststatus = 2

