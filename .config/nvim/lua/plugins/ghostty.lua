return {
  "isak102/ghostty.nvim",
  event = "BufReadPre",
  ft = "ghostty-config", -- Optional: only load for Ghostty config files
  config = function()
    require("ghostty").setup {
      -- Default options are fine for most users
    }
  end,
}
