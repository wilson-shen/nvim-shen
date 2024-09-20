return {
  {
    'loctvl842/monokai-pro.nvim',
    config = function()
      require('monokai-pro').setup({
        background_clear = {
          'float_win',
          'telescope',
          'notify',
        },
        filter = 'pro',
        plugins = {
          indent_blankline = {
            context_highlight = 'pro',
            context_start_underline = false,
          },
          bufferline = {
            underline_selected = true,
            underline_visible = true,
          },
        },
        terminal_colors = true,
        transparent_background = true,
      })

      vim.cmd.colorscheme('monokai-pro')
    end,
  },
}
