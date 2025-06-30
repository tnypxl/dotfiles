local M = {}

M.setup = function(opts)
  local cmp = require "cmp"

  -- Get the current sources table
  local sources = opts.sources or {}

  -- Create a new sources table with SuperMaven as the first item
  local new_sources = {
    { name = "supermaven", priority = 1000 }, -- Highest priority
  }

  -- Add all existing sources to the new table
  for _, source in ipairs(sources) do
    if source.name ~= "supermaven" then -- Avoid duplicates
      -- You can optionally assign lower priorities to existing sources
      -- source.priority = (source.priority or 500) -- Lower priority than SuperMaven
      table.insert(new_sources, source)
    end
  end

  -- Update the sources in the options
  opts.sources = new_sources

  opts.mapping["<CR>"] = cmp.mapping {
    i = function(fallback)
      if cmp.visible() then
        fallback()
      else
        fallback()
      end
    end,
  }

  opts.mapping["<M-CR>"] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Insert,
    select = true,
  }

  return opts
end

return M
