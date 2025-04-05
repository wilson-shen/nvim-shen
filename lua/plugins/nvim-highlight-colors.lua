return {
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      vim.opt.termguicolors = true

      local colors = require("nvim-highlight-colors")

      colors.setup ({
        render = 'virtual',
        virtual_symbol = '■',
        virtual_symbol_prefix = '',
        virtual_symbol_suffix = ' ',
        virtual_symbol_position = 'inline',
        enable_hex = true,
        enable_short_hex = true,
        enable_rgb = true,
        enable_hsl = true,
        enable_ansi = true,
        enable_hsl_without_function = false,
        enable_var_usage = true,
        enable_named_colors = true,
        enable_tailwind = true,
      })

      colors.turnOff()

      bind({"n", "i", "v", "o"}, "<leader>cc", colors.toggle, "[C]ode: Toggle [C]olor Preview")
    end
  }
}
