require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "i", "v", "n" }, "<C-s>", "<CMD>w<CR><ESC>")
map({ "i", "v", "n" }, "<Leader>W", ":noautocmd w<CR><ESC>")
map({ "n", "v" }, "<Leader>q", "<cmd>qa<cr>")

-- Line Manipulation
map({ "n", "v" }, "<A-j>", "<cmd>m .+1<cr>==", { noremap = true, silent = true })
map({ "n", "v" }, "<A-k>", "<cmd>m .-2<cr>==", { noremap = true, silent = true })
map({ "n", "v" }, "<A-Up>", "<cmd>m .-2<cr>==", { noremap = true, silent = true })
map({ "n", "v" }, "<A-Down>", "<cmd>m .+1<cr>==", { noremap = true, silent = true })

-- NvimTree
map("n", "<Leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
map({ "n", "v" }, "<Leader>o", ":NvimTreeFocus<CR>", { noremap = true, silent = true })

-- Split right and move current buffer to the right
map("n", "<Leader>r", ":sp<CR>", { noremap = true, silent = true })
map("n", "<Leader>R", ":vsp<CR>", { noremap = true, silent = true })

-- LSP-related
map("n", "<Leader>d", ":lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
map("n", "<Leader>ca", ":lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

-- CodeCompanion
-- map({ "n", "v" }, "<Leader>cA", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
-- map({ "n", "v" }, "<Leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
-- map({ "n", "v" }, "<Leader>ci", "<cmd>CodeCompanion<cr>")
