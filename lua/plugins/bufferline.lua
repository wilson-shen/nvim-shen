return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      'moll/vim-bbye',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local bufferline = require('bufferline')

      bufferline.setup({
        options = {
          mode = 'buffers',
          themable = true,
          numbers = 'none',
          close_command = 'bdelete! %d',
          buffer_close_icon = '✗',
          close_icon = '✗',
          path_components = 2,
          modified_icon = '●',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 30,
          max_prefix_length = 30,
          tab_size = 25,
          diagnostics = false,
          diagnostics_update_in_insert = false,
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          persist_buffer_sort = true,
          separator_style = { '│', '│' },
          enforce_regular_tabs = true,
          always_show_bufferline = true,
          show_tab_indicators = false,
          indicator = {
            style = 'none',
          },
          icon_pinned = '󰐃',
          minimum_padding = 1,
          maximum_padding = 5,
          maximum_length = 15,
          sort_by = 'insert_at_end',
        },
        highlights = {
          separator = {
            fg = '#434C5E',
          },
          buffer_selected = {
            bold = true,
            italic = false,
          },
        },
      })

      vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = "Next Tab", noremap = true, silent = true })
      vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = "Previous Tab", noremap = true, silent = true })
      vim.keymap.set('n', '<C-w>', ':bdelete!<CR>', { desc = "Close Tab", noremap = true, silent = true })
      vim.keymap.set('n', '<C-T>', '<cmd> enew <CR>', { desc = "New Tab", noremap = true, silent = true })

      -- Remap to delete buffer tab before back to previous tag stack
      vim.keymap.set('n', '<C-t>', function()
        local stacks = vim.fn.gettagstack()

        if stacks.length == 0 then
          print('Tag stack is empty.')
          return
        end

        if stacks.curidx == 1 then
          print('Tag stack is at the bottom.')
          return
        end

        local current_file = vim.fn.expand('%:p')
        local prev_file = vim.fn.bufname(stacks.items[stacks.curidx - 1].from[1])

        prev_file = prev_file and vim.fn.fnamemodify(prev_file, ':p')

        if prev_file == current_file then
          vim.cmd(':1po')
          return
        end

        -- detatch lsp to this buffer
        for _, client in pairs(vim.lsp.get_clients()) do
          vim.lsp.buf_detach_client(0, client.id)
        end

        vim.cmd(':1po | bd #')
      end, { noremap = true, silent = true });
    end
  }
}
