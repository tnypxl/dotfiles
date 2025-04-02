vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.autoindent = true

-- Special indentation for YAML
vim.opt_local.foldmethod = "indent"
vim.opt_local.foldenable = false -- Start with folds open

-- Set max line length marker
-- vim.opt_local.colorcolumn = "80"

-- Helpful for Kubernetes YAML files
vim.keymap.set("n", "<leader>yk", "<cmd>YAMLView<CR>", { buffer = true, desc = "YAML preview" })
