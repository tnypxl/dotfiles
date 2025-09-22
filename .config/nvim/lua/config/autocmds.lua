-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

local filetype_settings = {
  md = function()
    vim.g.autoformat = true
  end,

  json = function()
    vim.g.autoformat = false
    vim.diagnostic.enable(false)
  end,

  yaml = function()
    vim.g.autoformat = false
  end,

  go = function()
    vim.b.autoformat = true
  end,
}

for filetype, callback_func in pairs(filetype_settings) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetype,
    callback = callback_func,
  })
end

