return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
      picker = {
        grep = {
          hidden = true
        },
        files = {
          hidden = true,
          ignored = true,
          follow = true,
        },
        sources = {
          explorer = {
            hidden = true,
            ignored = false,
            follow = true,
          },
        },
      },
    },
  },
}
