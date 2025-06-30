vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
-- vim.opt_local.textwidth = 80
-- vim.opt_local.colorcolumn = "80"

-- Ruby-specific settings
vim.opt_local.smartindent = true
vim.opt_local.autoindent = true

-- Ruby-specific keymaps
vim.keymap.set("n", "<leader>rr", "<cmd>!ruby %<CR>", { buffer = true, desc = "Run current Ruby file" })
