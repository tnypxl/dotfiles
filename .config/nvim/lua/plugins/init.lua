return {
    {
        "stevearc/conform.nvim",
        event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },
    {
        "sourcegraph/sg.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "nvim-telescope/telescope.nvim"
        },
        lazy = false,
        config = function()
            require("sg").setup()
        end
    },
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
                -- LSP
                "html-lsp",
                "css-lsp",
                "gopls",
                "solargraph",
                "pyright",
                "terraformls",
                "yaml-language-server",
                "tsserver",
                "json-lsp",
                "xmlformatter",
                "marksman",
                "bash-language-server",

                -- Formatters
                "gofmt",
                "rubocop",
                "black",
                "terraform-fmt",
                "prettier",
                "shfmt",
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "go",
                "ruby",
                "python",
                "hcl", -- for Terraform
                "yaml",
                "json",
                "xml",
                "markdown",
                "terraform",
                "javascript",
                "typescript",
                "bash",
                "kdl",
            },
        },
    },
}
