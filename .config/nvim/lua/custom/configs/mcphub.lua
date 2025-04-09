local M = {}

M.setup = function()
  require("mcphub").setup {
    cmd = "MCPHub",
    build = "npm install -g mcp-hub@latest",
  }
end

return M
