-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Insert mode keybindings
vim.keymap.set({ "i", "v" }, "jk", "<ESC>", { noremap = true, silent = true, desc = "Exit insert mode" })

-- Terminal mode keybindings
vim.keymap.set("t", "<S-CR>", "<C-J>", { noremap = true, silent = true, desc = "Terminal: Literal Newline" })
