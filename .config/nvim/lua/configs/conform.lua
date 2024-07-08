local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    go = { "gofmt", "goimports" },
    json = { "prettier" },
    ruby = { "rubocop" },
    sh = { "shfmt" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    markdown = { "prettier" },
    python = { "black" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
