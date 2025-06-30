local M = {}

M.setup = function()
  require("mcphub").setup {
    port = 37373,
    auto_approve = true,
    extensions = {
      avante = {},
    },
  }
end

return M
