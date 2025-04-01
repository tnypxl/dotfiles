local autocmd = vim.api.nvim_create_autocmd

-- KDL filetype detection
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.kdl",
  callback = function()
    vim.bo.filetype = "kdl"
  end,
})

autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})