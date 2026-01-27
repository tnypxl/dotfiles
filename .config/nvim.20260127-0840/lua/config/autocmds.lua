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
    vim.b.autoformat = true
    vim.diagnostic.enable(false)

    -- Soft-wrap configuration for markdown files
    vim.opt_local.wrap = true           -- Enable visual line wrapping
    vim.opt_local.linebreak = true      -- Wrap at word boundaries (breakat chars)
    vim.opt_local.textwidth = 0         -- Don't auto-insert line breaks (soft-wrap only)
    vim.opt_local.colorcolumn = "100"   -- Visual guide at column 100
    vim.opt_local.breakindent = true    -- Preserve indentation on wrapped lines
    vim.opt_local.showbreak = "↪ "      -- Visual indicator for wrapped lines
  end,

  json = function()
    vim.b.autoformat = false
    vim.diagnostic.enable(false)
  end,

  yaml = function()
    vim.b.autoformat = false
  end,

  go = function()
    vim.b.autoformat = true
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.expandtab = true
  end,
}

for filetype, callback_func in pairs(filetype_settings) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetype,
    callback = callback_func,
  })
end
