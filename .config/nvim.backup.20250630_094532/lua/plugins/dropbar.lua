return {
  {
    "Bekaboo/dropbar.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons", -- Optional but recommended for icons
    },
    config = function()
      require("dropbar").setup {
        -- Your configuration options here
        -- Default settings work well out of the box
      }
    end,
  },
}
