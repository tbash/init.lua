return {
  "tpope/vim-sleuth",
  { "tpope/vim-surround", lazy = false },

  {
    "tpope/vim-fugitive",
    cmd = { "Git" },
    keys = {
      { "<leader>gs", vim.cmd.Git, desc = "Open Git Status" },
    },
  },
}
