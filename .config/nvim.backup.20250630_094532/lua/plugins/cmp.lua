return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    return require("custom.configs.cmp").setup(opts)
  end,
}
