local M = {}

M.setup = function()
  require("avante").setup {
    provider = "claude",
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub:get_active_servers_prompt()
    end,
    -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
    disabled_tools = {
      "list_files",
      "search_files",
      "read_file",
      "create_file",
      "rename_file",
      "delete_file",
      "create_dir",
      "rename_dir",
      "delete_dir",
      "bash",
    },
  }

  M.set_keymaps()
end

M.set_keymaps = function()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- Main Avante commands
  keymap("n", "<leader>aa", "<cmd>AvanteAsk<CR>", { desc = "Avante Ask", noremap = true, silent = true })
  keymap("n", "<leader>ac", "<cmd>AvanteChat<CR>", { desc = "Avante Chat", noremap = true, silent = true })
  keymap("n", "<leader>ad", "<cmd>AvanteDiff<CR>", { desc = "Avante Diff", noremap = true, silent = true })
  keymap("n", "<leader>at", "<cmd>AvanteToggle<CR>", { desc = "Avante Toggle", noremap = true, silent = true })
  keymap("n", "<leader>ax", "<cmd>AvanteClear<CR>", { desc = "Avante Clear", noremap = true, silent = true })

  -- Visual mode commands
  keymap("v", "<leader>aa", ":<C-u>AvanteAsk<CR>", { desc = "Avante Ask selection", noremap = true, silent = true })
  keymap("v", "<leader>ac", ":<C-u>AvanteChat<CR>", { desc = "Avante Chat selection", noremap = true, silent = true })
  keymap("v", "<leader>ad", ":<C-u>AvanteDiff<CR>", { desc = "Avante Diff selection", noremap = true, silent = true })
end

return M
