return {
  {
    "ravitemer/mcphub.nvim",
    event = "VeryLazy",
    cmd = "MCPHub",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    config = function()
      require("custom.configs.mcphub").setup()
    end,
  },
}
