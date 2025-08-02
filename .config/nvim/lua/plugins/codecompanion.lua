return {
  {
    "olimorris/codecompanion.nvim",
    config = function()
      local default_model = "google/gemini-2.5-flash"
      local available_models = {
        "google/gemini-2.5-flash",
        "google/gemini-2.5-pro",
        "anthropic/claude-4-sonnet",
      }
      local current_model = default_model

      local function select_model()
        vim.ui.select(available_models, {
          prompt = "Select Model:",
        }, function(choice)
          if choice then
            current_model = choice
            vim.notify("Selected model: " .. current_model)
          end
        end)
      end

      require("codecompanion").setup({
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
        },
        strategies = {
          chat = {
            adapter = "openrouter",
          },
          inline = {
            adapter = "openrouter",
          },
        },
        adapters = {
          openrouter = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = current_model,
                },
              },
            })
          end,
        },
      })

      vim.keymap.set({ "n", "v" }, "<C-a>a", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.keymap.set({ "n", "v" }, "<C-a>t", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
      vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

      vim.keymap.set("n", "<C-a>m", select_model, { desc = "Select Model" })
      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cab cc CodeCompanion]])
    end,

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
      },
      {
        "HakonHarnes/img-clip.nvim",
        opts = {
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = "[Image]($FILE_PATH)",
              use_absolute_path = true,
            },
          },
        },
      },
      {
        "echasnovski/mini.diff",
        config = function()
          local diff = require("mini.diff")
          diff.setup({
            -- Disabled by default
            source = diff.gen_source.none(),
          })
        end,
      },
    },
  },
}
