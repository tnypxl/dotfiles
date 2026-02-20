return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
      picker = {
        -- grep = {
        --   hidden = true,
        -- },
        -- files = {
        --   hidden = true,
        --   ignored = true,
        --   follow = true,
        -- },
        sources = {
          explorer = {
            hidden = true,
            ignored = false,
            follow = true,
            actions = {
              recursive_toggle = function(picker, item)
                local Actions = require("snacks.explorer.actions")
                local Tree = require("snacks.explorer.tree")

                local get_children = function(node)
                  local children = {}
                  for _, child in pairs(node.children) do
                    table.insert(children, child)
                  end
                  return children
                end

                local refresh = function()
                  Actions.update(picker, { refresh = true })
                end

                ---@param node snacks.picker.explorer.Node
                local function toggle_recursive(node)
                  Tree:toggle(node.path)
                  refresh()
                  vim.schedule(function()
                    local children = get_children(node)
                    if #children ~= 1 then
                      return
                    end
                    local child = children[1]
                    if not child.dir then
                      return
                    end
                    toggle_recursive(child)
                  end)
                end

                --

                local node = Tree:node(item.file)
                if not node then
                  return
                end

                if node.dir then
                  toggle_recursive(node)
                else
                  picker:action("confirm")
                end
              end,
            },
            win = {
              list = {
                keys = {
                  ["<CR>"] = "recursive_toggle",
                },
              },
            },
          },
          grep = {
            hidden = true,
          },
          files = {
            hidden = true,
          },
        },
      },
    },
  },
}
