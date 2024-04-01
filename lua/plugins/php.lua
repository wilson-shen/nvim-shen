return {
  {
		"ccaglak/namespace.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
    config = function()
      vim.keymap.set("n", "<leader>ipc", "<cmd>GetClass<cr>", { desc = "[I]mport [P]HP [C]lass under cursor" })
      vim.keymap.set("n", "<leader>ipn", "<cmd>Namespace<cr>", { desc = "[I]nsert [P]HP [N]amespace" })
    end
	},
}
