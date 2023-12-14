return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require "nvim-treesitter.configs"

    configs.setup {
      ensure_installed = {
        "eex",
        "elixir",
        "elm",
        "graphql",
        "heex",
        "ruby",
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "markdown",
        "markdown_inline",
      },
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true, enable_close_on_slash = false },
    }
  end,
}
