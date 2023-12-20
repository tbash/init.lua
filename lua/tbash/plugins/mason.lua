vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. ":" .. vim.env.PATH

return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
  opts = {
    PATH = "skip",
    ensure_installed = {
      -- lua stuff
      "lua-language-server",
      "stylua",

      -- web dev stuff
      "css-lsp",
      "html-lsp",
      "typescript-language-server",
      "deno",
      "prettier",
      "ruby-lsp",
      "elm-language-server",
      "elm-format",

      -- c/cpp stuff
      "clangd",
      "clang-format",
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
    end, {})

    vim.g.mason_binaries_list = opts.ensure_installed
  end,
}
