return {
  {
		"ccaglak/namespace.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
    config = function()
      vim.keymap.set("n", "<leader>pc", "<cmd>GetClass<cr>", { desc = "Import [C]lass under cursor" })
      vim.keymap.set("n", "<leader>pn", "<cmd>Namespace<cr>", { desc = "Import [N]amespace" })
    end
	},
}
