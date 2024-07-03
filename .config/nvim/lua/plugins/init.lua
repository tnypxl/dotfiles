return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
  		    "terraform-ls", "lua-language-server", "stylua", "gopls",
            "solargraph", "bash-language-server", "pyright", "css-lsp",
            "html-lsp", "typescript-language-server", "eslint-lsp", "tflint", "tfsec",
            "sonarlint-language-server", "rubocop", "erb-lint", "erb-formatter",
            "standardrb", "stimulus-language-server",
  		},
  	},
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        require("null-ls").setup()
    end,
  },
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  		    "vim", "lua", "vimdoc",
            "html", "css", "go", "javascript",
            "python", "bash", "ruby", "bash", "kdl",
  		},
  	},
  },
}
