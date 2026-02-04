return {
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dim_inactive = true,
      overrides = function(colors)
        return {
          LazyButtonActive = { fg = colors.palette.sumiInk0, bg = colors.palette.carpYellow, bold = true },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-paper-ink",
    },
  },
}
