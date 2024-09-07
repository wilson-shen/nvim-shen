---@diagnostic disable: missing-fields

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "windwp/nvim-ts-autotag",
      "windwp/nvim-autopairs",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("nvim-autopairs").setup()

      -- Integrate nvim-autopairs with cmp
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      cmp.setup({
        formatting = {
          expandable_indicator = true,
          fields = { "abbr", "kind", "menu" },
          format = require("lspkind").cmp_format({
            with_text = true,
            menu = {
              buffer = "[buf]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[api]",
              path = "[path]",
              cargo = "[cargo]",
              luasnip = "[snip]",
              codeium = "{…}",
            },
          }),
        },
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext item
          ["<C-n>"] = cmp.mapping.select_next_item(),

          -- Select the [p]revious item
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          -- Manually trigger a completion from nvim-cmp.
          ["<C-Space>"] = cmp.mapping.complete({}),

          -- Move to the right of each of the expansion locations.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),

          -- Similar, except moving you backwards.
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),

          ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible_docs() then
              cmp.close_docs()
            elseif cmp.visible() then
              cmp.open_docs()
            else
              fallback()
            end
          end),
        }),
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "luasnip", max_item_count = 3 }, -- snippets
          { name = "nvim_lsp" },               -- lsp
          { name = "buffer",  max_item_count = 5 }, -- text within current buffer
          { name = "path",    max_item_count = 3 }, -- file system paths
        },
        view = {
          docs = {
            auto_open = true,
          },
        },
        visible_docs = true,
        window = {
          completion = {
            border = "rounded",
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:CmpDoc",
          },
        },
      })
    end,
  },
}
