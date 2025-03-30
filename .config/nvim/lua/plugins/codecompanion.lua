return {
  {
    "olimorris/codecompanion.nvim",
    lazy = false,
    config = require "configs.codecompanion",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
