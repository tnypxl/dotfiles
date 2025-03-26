-- ~/.config/nvim/after/ftplugin/json.lua
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

-- JSON-specific settings
vim.opt_local.conceallevel = 0 -- Don't hide quotes in JSON files

-- Format JSON with jq if available
vim.keymap.set("n", "<leader>jq", ":%!jq .<CR>", { buffer = true, desc = "Format JSON with jq" })

-- JSON validation keymap
vim.keymap.set("n", "<leader>jv", "<cmd>!jq empty %<CR>", { buffer = true, desc = "Validate JSON" })
