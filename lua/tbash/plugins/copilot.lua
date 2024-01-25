return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup {
      filetypes = {
        javascript = true,
        typescript = true,
        ["*"] = false,
      },
    }
  end,
}
