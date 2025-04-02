vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
-- vim.opt_local.textwidth = 100
-- vim.opt_local.colorcolumn = "100"
vim.opt_local.smartindent = true
vim.opt_local.autoindent = true

-- Java-specific keymaps
vim.keymap.set("n", "<leader>jc", "<cmd>!javac %<CR>", { buffer = true, desc = "Compile Java file" })
vim.keymap.set("n", "<leader>jr", function()
  local file = vim.fn.expand "%:r"
  vim.cmd("!java " .. file)
end, { buffer = true, desc = "Run Java class" })
