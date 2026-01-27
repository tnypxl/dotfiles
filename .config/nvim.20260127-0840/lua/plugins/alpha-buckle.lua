-- lua/plugins/alpha.lua
-- Replace LazyVim's default Alpha banner with your custom ASCII art.
-- This keeps the standard LazyVim buttons/highlights but swaps the header.

return {
  {
    "goolord/alpha-nvim",
    enabled = true,
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#E46876", bold = true })
      vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#E6C384", bold = true })
      vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#677FAE" })
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#54546D" })


      -- Put your ASCII art here. You can paste output from patorjk.com (ANSI Shadow, etc.)
      -- Example uses the “BUCKLE” art from the page you’re on; replace with your own.
      local logo = [[
██████╗ ██╗   ██╗ ██████╗██╗  ██╗██╗     ███████╗
██╔══██╗██║   ██║██╔════╝██║ ██╔╝██║     ██╔════╝
██████╔╝██║   ██║██║     █████╔╝ ██║     █████╗  
██╔══██╗██║   ██║██║     ██╔═██╗ ██║     ██╔══╝  
██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗███████╗
╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝
]]

      -- Assign header
      dashboard.section.header.val = vim.split(logo, "\n")

      -- Keep LazyVim-style buttons (you can customize or remove any)
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", "<cmd> lua LazyVim.pick()() <cr>"),
        dashboard.button("n", "  New file", [[<cmd> ene <BAR> startinsert <cr>]]),
        dashboard.button("r", "  Recent files", [[<cmd> lua LazyVim.pick("oldfiles")() <cr>]]),
        dashboard.button("g", "  Find text", [[<cmd> lua LazyVim.pick("live_grep")() <cr>]]),
        dashboard.button("c", "  Config", "<cmd> lua LazyVim.pick.config_files()() <cr>"),
        dashboard.button("s", "  Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button("x", "  Lazy Extras", "<cmd> LazyExtras <cr>"),
        dashboard.button("l", "󰒲  Lazy", "<cmd> Lazy <cr>"),
        dashboard.button("q", "  Quit", "<cmd> qa <cr>"),
      }

      -- Ensure highlights match LazyVim’s theme classes
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      -- dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      -- Adjust top padding for your logo height if needed
      dashboard.opts.layout[1].val = 8

      return dashboard
    end,
  },
}

