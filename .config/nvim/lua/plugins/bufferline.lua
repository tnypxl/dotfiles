return {
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      local bufferline = require("bufferline")
      opts.options = opts.options or {}
      opts.options.style_preset = bufferline.style_preset.minimal
    end,
  },
}
