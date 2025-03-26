require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "i", "v", "n" }, "<C-s>", "<cmd>w<cr>")
map({ "n", "v" }, "<Leader>q", "<cmd>qa<cr>")

-- NvimTree
map("n", "<Leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- CodeCompanion
map({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
map({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

vim.cmd [[cab cc CodeCompanion]]
