vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
-- vim.opt_local.textwidth = 88 -- Black formatter default
-- vim.opt_local.colorcolumn = "88"
vim.opt_local.smartindent = true
vim.opt_local.autoindent = true

-- Python-specific keymaps
vim.keymap.set("n", "<leader>pr", "<cmd>!python %<CR>", { buffer = true, desc = "Run Python file" })
vim.keymap.set("n", "<leader>pv", "<cmd>!python -m venv venv<CR>", { buffer = true, desc = "Create venv" })
