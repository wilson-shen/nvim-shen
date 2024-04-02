return {
  {
    'loctvl842/monokai-pro.nvim',
    config = function ()
      require('monokai-pro').setup({
        background_clear = {
          'float_win',
          'telescope'
        },
        devicons = true,
        filter = 'pro',
        plugins = {
          indent_blankline = {
            context_highlight = 'pro',
            context_start_underline = false,
          }
        },
        transparent_background = true,
      })

      vim.cmd.colorscheme('monokai-pro')
    end,
  },
}
