return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git" },
    keys = {
      { "<leader>gs", "<cmd> vert Git <CR>", desc = "Open Git Status" },
      { "<leader>gb", "<cmd> Git blame <CR>", desc = "Open Git Blame" },
    },
  },
}
