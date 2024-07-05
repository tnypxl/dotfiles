require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>q", "<CMD>qa<CR>", { desc = "quit all buffers" })
map("n", "<leader>Q", "<CMD>qa!<CR>", { desc = "quit all buffers without saving" })
map("n", "<leader>s", "<CMD>w<CR>", { desc = "file save" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
