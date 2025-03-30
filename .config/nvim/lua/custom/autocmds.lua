local autocmd = vim.api.nvim_create_autocmd

-- KDL filetype detection
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.kdl",
  callback = function()
    vim.bo.filetype = "kdl"
  end,
})
