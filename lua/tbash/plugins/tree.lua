return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<C-n>", "<cmd> NvimTreeToggle <CR>", desc = "Toggle nvimtree" },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup()
  end,
}
