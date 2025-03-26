return {
  {
    "supermaven-inc/supermaven-nvim",
    lazy = false,
    config = function()
      require("supermaven-nvim").setup {
        -- your configuration comes here
        disable_keymaps = true,
        disable_inline_completion = true,
      }
    end,
  },
}
