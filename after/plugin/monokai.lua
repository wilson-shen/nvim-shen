require('monokai-pro').setup({
  transparent_background = true,
})

function InitTheme(theme)
  theme = theme or "monokai-pro"
  vim.cmd.colorscheme(theme)
end

InitTheme()
