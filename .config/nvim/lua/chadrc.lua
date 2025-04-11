-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  integrations = { "avante", "nvimtree", "telescope" },
  hl_add = {
    ["AvanteSidebarWinSeparator"] = {
      fg = "one_bg2",
      bg = "black",
    },
    -- ["AvanteVertSplit"] = {
    --   fg = "darker_black",
    --   bg = "darker_black",
    -- },
    ["AvanteSidebarNormal"] = {
      bg = "black",
    },
    ["AvanteSidebarWinHorizontalSeparator"] = {
      fg = "black",
    },
  },
  hl_override = {
    NvimTreeWinSeparator = {
      fg = "black",
      bg = "black",
    },
  },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  tabufline = {
    lazyload = false,
  },

  statusline = {
    theme = "default",
    separator_style = "round",
  },
}

-- M.lsp = { signature = false }

return M
