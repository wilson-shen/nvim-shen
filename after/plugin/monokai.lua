local monokai = require("monokai-pro")

monokai.setup({
	transparent_background = true,
	devicons = true,
	filter = "pro",
	background_clear = {
		"float_win",
		"telescope",
	},
	plugins = {
		indent_blankline = {
			context_highlight = "pro",
			context_start_underline = false,
		},
	},
})

monokai.load()

function InitTheme(theme)
	theme = theme or "monokai-pro"
	vim.cmd.colorscheme(theme)
end

InitTheme()
