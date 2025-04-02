-- TypeScript can inherit from JavaScript settings
vim.cmd "runtime! after/ftplugin/javascript.lua"

-- Add any TypeScript-specific overrides
vim.keymap.set("n", "<leader>tc", "<cmd>TypescriptCompile<CR>", { buffer = true, desc = "Compile TypeScript" })
