local comment = require("ts_context_commentstring")

comment.setup({
	enable_autocmd = false,
})

vim.g.skip_ts_context_commentstring_module = true

require("mini.comment").setup({
	options = {
		custom_commentstring = function()
			return comment.calculate_commentstring() or vim.bo.commentstring
		end,
	},
})
