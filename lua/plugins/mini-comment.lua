return {
	{
		"echasnovski/mini.comment",
		version = "*",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			local comment = require("ts_context_commentstring")

			comment.setup({
				enable_autocmd = false,
			})

			vim.g.skip_ts_context_commentstring_module = true

			require("mini.comment").setup({
				options = {
					-- Function to compute custom 'commentstring' (optional)
					custom_commentstring = function()
            if vim.bo.filetype == "php" or vim.bo.filetype == "cs" then
              vim.bo.commentstring = "// %s"
            end

            if vim.bo.filetype == "blade" then
              vim.bo.commentstring = "{-- %s --}"
            end

						return comment.calculate_commentstring() or vim.bo.commentstring
					end,

					-- Whether to ignore blank lines when commenting
					ignore_blank_line = true,

					-- Whether to recognize as comment only lines without indent
					start_of_line = false,

					-- Whether to force single space inner padding for comment parts
					pad_comment_parts = true,
				},
			})
		end,
	},
}
