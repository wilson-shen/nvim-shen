return {
	{
		"echasnovski/mini.indentscope",
		version = "*",
		config = function()
      local indent = require("mini.indentscope")

      indent.setup({
				draw = {
					delay = 100,
					priority = 2,
				},
				mappings = {
					object_scope = "ii",
					object_scope_with_border = "ai",
					goto_top = "[i",
					goto_bottom = "]i",
				},

				options = {
					border = "both",
					indent_at_cursor = true,
					try_as_border = false,
				},

				symbol = "▏",
			})
		end,
	},
}
