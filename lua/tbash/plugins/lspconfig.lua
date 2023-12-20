return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- format & linting
    {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        local null_ls = require "null-ls"

        local b = null_ls.builtins

        local sources = {

          -- webdev stuff
          b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
          b.formatting.prettier.with {
            filetypes = { "html", "markdown", "css" },
          }, -- so prettier works only on these filetypes

          -- Lua
          b.formatting.stylua,

          -- cpp
          b.formatting.clang_format,

          -- elm
          b.formatting.elm_format,

          -- elixir
          b.formatting.mix,
        }

        -- Autoformatting
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup {
          debug = false,
          sources = sources,
          on_attach = function(client, bufnr)
            if client.supports_method "textDocument/formatting" then
              vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format { async = false }
                end,
              })
            end
          end,
        }
      end,
    },

    -- Sorta hack to reuse on_attach defined in config field below
    {
      "elixir-tools/elixir-tools.nvim",
      version = "*",
      event = { "BufReadPre", "BufNewFile" },
    },
  },
  config = function()
    local lspconfig = require "lspconfig"

    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)

      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      if client.supports_method "textDocument/semanticTokens" then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    -- if you just want default config for the servers then put them in a table
    local servers = { "html", "tsserver", "clangd", "elmls", "ruby_ls" }

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end

    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,

      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    }

    lspconfig.cssls.setup {
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    }

    lspconfig.tailwindcss.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        tailwindCSS = {
          validate = true,
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidScreen = "error",
            invalidVariant = "error",
            invalidConfigPath = "error",
            invalidTailwindDirective = "error",
            recommendedVariantOrder = "warning",
          },
          includeLanguages = {
            elm = "html",
            html = "html",
          },
          classAttributes = { "class", "className", "classList" },
          experimental = {
            classRegex = {
              '\\bclass[\\s(<|]+"([^"]*)"',
              '\\bclass[\\s(]+"[^"]*"[\\s+]+"([^"]*)"',
              '\\bclass[\\s<|]+"[^"]*"\\s*\\+{2}\\s*" ([^"]*)"',
              '\\bclass[\\s<|]+"[^"]*"\\s*\\+{2}\\s*" [^"]*"\\s*\\+{2}\\s*" ([^"]*)"',
              '\\bclass[\\s<|]+"[^"]*"\\s*\\+{2}\\s*" [^"]*"\\s*\\+{2}\\s*" [^"]*"\\s*\\+{2}\\s*" ([^"]*)"',
              '\\bclassList[\\s\\[\\(]+"([^"]*)"',
              '\\bclassList[\\s\\[\\(]+"[^"]*",\\s[^\\)]+\\)[\\s\\[\\(,]+"([^"]*)"',
              '\\bclassList[\\s\\[\\(]+"[^"]*",\\s[^\\)]+\\)[\\s\\[\\(,]+"[^"]*",\\s[^\\)]+\\)[\\s\\[\\(,]+"([^"]*)"',
              [[class: "([^"]*)]],
            },
          },
        },
      },
      filetypes = {
        "eelixir",
        "elm",
        "html",
        "html-eex",
        "heex",
        "css",
        "postcss",
        "javascript",
        "javascriptreact",
        "reason",
        "rescript",
        "typescript",
        "typescriptreact",
      },
      init_options = {
        userLanguages = {
          eelixir = "html-eex",
          eruby = "erb",
          elm = "html",
          html = "html",
        },
      },
    }

    local elixir = require "elixir"
    local elixirls = require "elixir.elixirls"

    elixir.setup {
      nextls = { enable = true },
      credo = {},
      elixirls = {
        enable = true,
        settings = elixirls.settings {
          dialyzerEnabled = false,
          enableTestLenses = true,
        },
        on_attach = on_attach,
      },
    }
  end,
}
