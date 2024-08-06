return {
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			local wk = require("which-key")
			wk.add({
				{ "<leader>c", expr = false, group = "[C]ode", mode = "n", nowait = false, remap = false },
				{ "<leader>d", expr = false, group = "[D]iagnostic", mode = "n", nowait = false, remap = false },
				{ "<leader>f", expr = false, group = "[F]ile", mode = "n", nowait = false, remap = false },
				{ "<leader>g", expr = false, group = "[G]it", mode = "n", nowait = false, remap = false },
				{ "<leader>h", expr = false, group = "[H]arpoon", mode = "n", nowait = false, remap = false },
				{ "<leader>i", expr = false, group = "[I]import", mode = "n", nowait = false, remap = false },
				{ "<leader>ip", expr = false, group = "[P]HP", mode = "n", nowait = false, remap = false },
				{ "<leader>l", expr = false, group = "[L]azy", mode = "n", nowait = false, remap = false },
				{ "<leader>r", expr = false, group = "[R]ename", mode = "n", nowait = false, remap = false },
				{ "<leader>s", expr = false, group = "[S]earch", mode = "n", nowait = false, remap = false },
			})
		end,
	},
}
