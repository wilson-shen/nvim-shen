return {
	{
		"ccaglak/namespace.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			bind("n", "<leader>pf", "<cmd>Php classes<cr>", "[F]ind All Classes")
			bind("n", "<leader>pc", "<cmd>Php class<cr>", "Import [C]lass under cursor")
			bind("n", "<leader>pn", "<cmd>Php namespace<cr>", "Import [N]amespace")
			bind("n", "<leader>ps", "<cmd>Php sort<cr>", "[S]ort Classes")
		end,
	},
}
