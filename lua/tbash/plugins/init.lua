local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  "tpope/vim-sleuth",
  "tpope/vim-surround",

  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
    },
    keys = {
      { "<leader>gs", vim.cmd.Git, desc = "Open Git Status" },
    },
  },
  {
    "tpope/vim-rhubarb",
    dependencies = {
      "tpope/vim-fugitive",
    },
  },

  require "tbash.plugins.cmp",
  require "tbash.plugins.autotag",
  require "tbash.plugins.colorscheme",
  require "tbash.plugins.comment",
  require "tbash.plugins.dadbod",
  require "tbash.plugins.gitsigns",
  require "tbash.plugins.lspconfig",
  require "tbash.plugins.mason",
  require "tbash.plugins.telescope",
  require "tbash.plugins.tree",
  require "tbash.plugins.treesitter",
  require "tbash.plugins.treesitter-context",
}
