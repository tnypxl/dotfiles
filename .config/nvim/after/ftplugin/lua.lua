-- ~/.config/nvim/after/ftplugin/lua.lua

-- Indentation settings
vim.opt_local.expandtab = true -- Use spaces instead of tabs
vim.opt_local.tabstop = 2 -- A tab is 2 spaces
vim.opt_local.shiftwidth = 2 -- Number of spaces for auto-indent
vim.opt_local.softtabstop = 2 -- Edit as if tabs are 2 spaces
vim.opt_local.smartindent = true -- Smart auto-indenting

-- Line length and display
vim.opt_local.textwidth = 120 -- Lua can have longer lines than some languages
vim.opt_local.wrap = false -- Don't wrap lines

-- Lua-specific settings
vim.opt_local.formatoptions = vim.opt_local.formatoptions
  - "o" -- Don't continue comments on o/O
  + "r" -- Continue comments after Enter
  + "c" -- Auto-wrap comments using textwidth
  + "q" -- Allow formatting comments with gq
  + "l" -- Don't auto-format already long lines

-- Folding for Lua functions and blocks
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldenable = false -- Start with folds open

-- Lua-specific keymaps
vim.keymap.set("n", "<leader>lr", "<cmd>luafile %<CR>", {
  buffer = true,
  desc = "Run current Lua file",
})

-- For Neovim Lua files specifically
if vim.fn.expand("%:p"):match "nvim" then
  -- Keymap to reload the current config file
  vim.keymap.set("n", "<leader>ls", "<cmd>source %<CR>", {
    buffer = true,
    desc = "Source current Neovim config",
  })

  -- Keymap to open the corresponding config file
  vim.keymap.set("n", "<leader>lc", function()
    local file = vim.fn.expand "%:t"
    if file == "init.lua" then
      vim.cmd "edit ~/.config/nvim/init.lua"
    elseif file:match "%.lua$" then
      -- Try to find the file in common Neovim config locations
      local locations = {
        "~/.config/nvim/lua/",
        "~/.config/nvim/lua/custom/",
        "~/.config/nvim/lua/plugins/",
        "~/.config/nvim/lua/configs/",
      }

      for _, location in ipairs(locations) do
        local path = location .. file
        if vim.fn.filereadable(vim.fn.expand(path)) == 1 then
          vim.cmd("edit " .. path)
          return
        end
      end
    end
  end, { buffer = true, desc = "Open related config file" })
end

-- Improve Lua syntax highlighting for Neovim API
local lua_keywords = {
  "vim",
  "awesome",
  "client",
  "root",
  "string",
  "table",
  "math",
  "package",
  "require",
  "ipairs",
  "pairs",
  "print",
  "error",
  "debug",
  "assert",
  "tonumber",
  "tostring",
  "type",
  "select",
  "pcall",
  "xpcall",
  "next",
  "setmetatable",
  "getmetatable",
  "rawget",
  "rawset",
  "rawequal",
  "unpack",
}

for _, keyword in ipairs(lua_keywords) do
  vim.cmd("syntax keyword luaKeyword " .. keyword)
end

-- Add highlighting for Neovim API
vim.cmd [[
  syntax match luaFunc /vim\.\w\+\.\w\+/
  syntax match luaFunc /vim\.\w\+/
  hi def link luaFunc Function
]]

-- Set comment string for Lua
vim.opt_local.commentstring = "-- %s"

-- Enable spell checking in comments
vim.opt_local.spell = true
vim.opt_local.spellcapcheck = "" -- Don't check for capital letters at start of sentences
