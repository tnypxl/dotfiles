-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "catppuccin",
  statusline = {
    theme = "minimal",
    separator_style = "round",
    overriden_modules = nil,
  },
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.sg = {
--   enable = true,
--   cody = {
--     enable = true,
--     completions = {
--       enable = true,
--       -- Optional: customize completion settings
--       -- delay = 150,
--       -- debug = false,
--     },
--   },
-- }

return M
