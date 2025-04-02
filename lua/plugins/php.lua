return {
	{
		"ccaglak/namespace.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.keymap.set("n", "<leader>pf", "<cmd>Php classes<cr>", { desc = "[F]ind All Classes", silent = true })
			vim.keymap.set("n", "<leader>pc", "<cmd>Php class<cr>", { desc = "Import [C]lass under cursor", silent = true })
			vim.keymap.set("n", "<leader>pn", "<cmd>Php namespace<cr>", { desc = "Import [N]amespace", silent = true })
			vim.keymap.set("n", "<leader>ps", "<cmd>Php sort<cr>", { desc = "[S]ort Classes", silent = true })
		end,
	},
}
