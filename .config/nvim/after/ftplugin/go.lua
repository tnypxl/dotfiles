-- ~/.config/nvim/after/ftplugin/go.lua
vim.opt_local.expandtab = false -- Go uses tabs, not spaces
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
-- vim.opt_local.textwidth = 100
-- vim.opt_local.colorcolumn = "100"

-- Common Go-specific keymaps
vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<CR>", { buffer = true, desc = "Run Go tests" })
vim.keymap.set("n", "<leader>gi", "<cmd>GoImport<CR>", { buffer = true, desc = "Manage Go imports" })

-- Ensure gofmt is used on save if you have null-ls or conform.nvim
-- This is often handled by your LSP config, but as a fallback:
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.go",
--   callback = function()
--     vim.lsp.buf.format { async = false }
--   end,
--   buffer = 0,
-- })
