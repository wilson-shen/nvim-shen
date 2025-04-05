return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local blink = require("blink.cmp")

      blink.setup({
        completion = {
          keyword = {
            range = "prefix",
          },
          trigger = {
            prefetch_on_insert = true,
            show_in_snippet = true,
            show_on_keyword = true,
            show_on_trigger_character = true,
            show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
            show_on_accept_on_trigger_character = true,
            show_on_insert_on_trigger_character = true,
            show_on_x_blocked_trigger_characters = { "'", '"', '(' },
          },
          list = {
            max_items = 100,
            selection = {
              preselect = true,
              auto_insert = false,
            },
            cycle = {
              from_bottom = false,
              from_top = false,
            },
          },
          accept = {
            dot_repeat = true,
            create_undo_point = true,
            resolve_timeout_ms = 100,
            auto_brackets = {
              enabled = true,
              default_brackets = { '(', ')' },
              override_brackets_for_filetypes = {},
              kind_resolution = {
                enabled = true,
                blocked_filetypes = { 'typescriptreact', 'javascriptreact', 'vue' },
              },
              semantic_token_resolution = {
                enabled = true,
                blocked_filetypes = { 'java' },
                timeout_ms = 400,
              },
            },
          },
          menu = {
            enabled = true,
            min_width = 15,
            max_height = 10,
            border = "rounded",
            winblend = 0,
            winhighlight =
            'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
            scrolloff = 2,
            scrollbar = true,
            direction_priority = { 's', 'n' },
            auto_show = true,
            cmdline_position = function()
              if vim.g.ui_cmdline_pos ~= nil then
                local pos = vim.g.ui_cmdline_pos
                return { pos[1] - 1, pos[2] }
              end
              local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
              return { vim.o.lines - height, 0 }
            end,
            draw = {
              align_to = 'label',
              padding = 1,
              gap = 1,
              treesitter = { 'lsp' },
              columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
              components = {
                kind_icon = {
                  ellipsis = false,
                  text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
                  highlight = function(ctx) return { { group = ctx.kind_hl, priority = 20000 } } end,
                },

                kind = {
                  ellipsis = false,
                  width = { fill = true },
                  text = function(ctx) return ctx.kind end,
                  highlight = function(ctx) return ctx.kind_hl end,
                },

                label = {
                  width = { fill = true, max = 60 },
                  text = function(ctx) return ctx.label .. ctx.label_detail end,
                  highlight = function(ctx)
                    local highlights = {
                      { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
                    }
                    if ctx.label_detail then
                      table.insert(highlights,
                        { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' })
                    end

                    for _, idx in ipairs(ctx.label_matched_indices) do
                      table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                    end

                    return highlights
                  end,
                },

                label_description = {
                  width = { max = 30 },
                  text = function(ctx) return ctx.label_description end,
                  highlight = 'BlinkCmpLabelDescription',
                },

                source_name = {
                  width = { max = 30 },
                  text = function(ctx) return ctx.source_name end,
                  highlight = 'BlinkCmpSource',
                },

                source_id = {
                  width = { max = 30 },
                  text = function(ctx) return ctx.source_id end,
                  highlight = 'BlinkCmpSource',
                },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
            update_delay_ms = 50,
            treesitter_highlighting = true,
            draw = function(opts) opts.default_implementation() end,
            window = {
              min_width = 10,
              max_width = 80,
              max_height = 20,
              border = "rounded",
              winblend = 0,
              winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
              scrollbar = true,
              direction_priority = {
                menu_north = { 'e', 'w', 'n', 's' },
                menu_south = { 'e', 'w', 's', 'n' },
              },
            },
          },
          ghost_text = {
            enabled = true,
            show_with_selection = true,
            show_without_selection = false,
            show_with_menu = true,
            show_without_menu = true,
          },
        },
        keymap = {
          preset = "none",

          ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
          ['<C-e>'] = { 'hide' },
          ['<CR>'] = { 'select_and_accept' },

          ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
          ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
          ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
          ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

          ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        sources = {
          default = { "snippets", "lsp", "path", "buffer" },
        },
        snippets = {
          preset = "luasnip",
        },
        signature = {
          enabled = true,
        }
      })
    end
  }
}
