return {
  {
    "ravitemer/mcphub.nvim",
    event = "VeryLazy",
    cmd = "MCPHub", -- lazy load by default
    build = "npm install -g mcp-hub@latest",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    config = function()
      require("custom.configs.mcphub").setup()
    end,
  },
}
