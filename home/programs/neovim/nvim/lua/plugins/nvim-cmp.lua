return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          option = {
            markdown_oxide = {
              keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
            }
          }
        },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),

      -- mapping = cmp.mapping.preset.insert({
      --   ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      --   ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      --   ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
      --   ["<C-x>"] = cmp.mapping.complete(),
      --   ["<C-e>"] = cmp.mapping.abort(),
      --   ["<CR>"] = cmp.mapping.confirm({ select = true }),
      --
      --   ["<Tab>"] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       cmp.select_next_item()
      --     elseif luasnip.expand_or_jumpable() then
      --       luasnip.expand_or_jump()
      --     else
      --       fallback()
      --     end
      --   end, { "i", "s" }), -- i: 插入模式, s: 选择模式
      --   ["<S-Tab>"] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       cmp.select_prev_item()
      --     elseif luasnip.jumpable(-1) then
      --       luasnip.jump(-1)
      --     else
      --       fallback()
      --     end
      --   end, { "i", "s" }),
      -- }),

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = lspkind.presets.codicons[vim_item.kind] or "?"
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
