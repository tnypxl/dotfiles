require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>s", "<cmd>w<CR>", { desc = "file save" })
map("n", "<leader>q", "<cmd>qa<CR>", { desc = "quit all buffers" })
