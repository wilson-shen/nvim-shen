return {
	{
		"mbbill/undotree",
		event = "VeryLazy",
		config = function()
			bind(
				"n",
				"<leader>u",
				vim.cmd.UndotreeToggle,
				"[U]ndoTree Toggle"
			)
		end,
	},
}
