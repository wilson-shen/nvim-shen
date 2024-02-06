local gitsigns = require("gitsigns")

gitsigns.setup({
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
})

vim.keymap.set("n", "<leader>gt", gitsigns.toggle_current_line_blame, { desc = "[G]it: [T]oggle git blame" })
vim.keymap.set("n", "<leader>gph", gitsigns.preview_hunk, { desc = "[G]it: [P]review [H]unk" })

--- Fungitive ---
vim.keymap.set("n", "<leader>gs", ":Git<cr>", { desc = "[G]it: [S]tatus" })
vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { desc = "[G]it: [B]lame" })
vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<cr>", { desc = "[G]it: [D]iff" })
vim.keymap.set("n", "<leader>gl", ":Git log<cr>", { desc = "[G]it: [L]og" })
vim.keymap.set("n", "<leader>gh", ":Git hist<cr>", { desc = "[G]it: [H]istory" })
vim.keymap.set("n", "<leader>gw", ":Git write<cr>", { desc = "[G]it: [W]rite" })
vim.keymap.set("n", "<leader>gf", ":Git fetch<cr>", { desc = "[G]it: [F]etch" })
vim.keymap.set("n", "<leader>gpl", ":Git pull<cr>", { desc = "[G]it: [P]u[L]l" })
vim.keymap.set("n", "<leader>gps", ":Git push<cr>", { desc = "[G]it: [P]u[S]h" })
vim.keymap.set("n", "<leader>gr", ":Git rebase -i", { desc = "[G]it: [R]ebase" })
vim.keymap.set("n", "<leader>ga", ":Git add", { desc = "[G]it: [A]dd" })
vim.keymap.set("n", "<leader>gcm", ":Git commit -m", { desc = "[G]it: [C]om[M]it" })
vim.keymap.set("n", "<leader>gco", ":Git checkout", { desc = "[G]it: [C]heck[O]ut" })
vim.keymap.set("n", "<leader>gcb", ":Git checkout -b", { desc = "[G]it: [C]heckout [B]ranch" })
vim.keymap.set("n", "<leader>gm", ":Git merge", { desc = "[G]it: [M]erge" })
