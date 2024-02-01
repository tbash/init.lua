return {
  "numToStr/Comment.nvim",
  keys = {
    {
      "<leader>/",
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      mode = "n",
      desc = "Comment toggle current line",
    },
    {
      "<leader>/",
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      mode = "v",
      desc = "Comment toggle current line",
    },
  },
}
