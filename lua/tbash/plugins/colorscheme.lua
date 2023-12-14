return {
  "catppuccin/nvim",
  priority = 1000,
  name = "catppuccin",
  config = function()
    require("catppuccin").setup {
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        treesitter_context = true,
      },
    }
    vim.cmd.colorscheme "catppuccin"
  end,
}
