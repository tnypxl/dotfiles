-- ~/.config/nvim/after/ftplugin/javascript.lua
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
-- vim.opt_local.textwidth = 80
-- vim.opt_local.colorcolumn = "80"

-- JS-specific keymaps
vim.keymap.set("n", "<leader>nr", "<cmd>!node %<CR>", { buffer = true, desc = "Run current JS file" })
