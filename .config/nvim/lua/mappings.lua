require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<D-s>", "<cmd>w<cr>")
map({"n","v"}, "<Leader>q", "<cmd>qa<cr>")

