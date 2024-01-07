return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  keys = {
    { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    {
      "<leader>;",
      function()
        require("telescope.builtin").buffers {
          sort_mru = true,
          sort_lastused = true,
          ignore_current_buffer = true,
        }
      end,
      desc = "Find in buffers",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
      },
    },
  },
}
