return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local configs = require "nvim-treesitter.configs"

      configs.setup {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true, enable_close_on_slash = false },
      }
    end,
  },
}
