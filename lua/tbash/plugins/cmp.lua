return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      -- snippet plugin
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      opts = { history = true, updateevents = "TextChanged,TextChangedI" },
      config = function(_, opts)
        require("luasnip").config.set_config(opts)

        -- vscode format
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load {
          paths = vim.g.vscode_snippets_path or "",
        }

        -- snipmate format
        require("luasnip.loaders.from_snipmate").load()
        require("luasnip.loaders.from_snipmate").lazy_load {
          paths = vim.g.snipmate_snippets_path or "",
        }

        -- lua format
        require("luasnip.loaders.from_lua").load()
        require("luasnip.loaders.from_lua").lazy_load {
          paths = vim.g.lua_snippets_path or "",
        }

        vim.api.nvim_create_autocmd("InsertLeave", {
          callback = function()
            if
              require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
              and not require("luasnip").session.jump_active
            then
              require("luasnip").unlink_current()
            end
          end,
        })
      end,
    },
    {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
  },
  config = function()
    local luasnip = require "luasnip"
    local cmp = require "cmp"
    local lspkind = require "lspkind"

    cmp.setup {
      window = {
        completion = cmp.config.window.bordered {
          side_padding = 1,
          winhighlight = "Normal:CmpPmenu,Search:None",
          scrollbar = false,
        },
        documentation = cmp.config.window.bordered {
          winhighlight = "Normal:CmpDoc",
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      },
      formatting = {
        format = lspkind.cmp_format {
          mode = "symbol_text",
          maxwidth = 20,
          ellipsis_char = "...",

          before = function(_, vim_item)
            vim_item.menu = ""
            return vim_item
          end,
        },
      },
    }
  end,
}
