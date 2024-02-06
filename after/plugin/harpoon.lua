local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>ht", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "[H]arpoon [T]oggle" })

vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():append()
end, { desc = "[H]arpoon [A]dd" })

vim.keymap.set("n", "<leader>hd", function()
	harpoon:list():delete()
end, { desc = "[H]arpoon [D]elete" })

vim.keymap.set("n", "<leader>hc", function()
	harpoon:list():clear()
end, { desc = "[H]arpoon [C]lear" })

vim.keymap.set("n", "<leader>h1", function()
	harpoon:list():select(1)
end, { desc = "[H]arpoon Item [1]" })

vim.keymap.set("n", "<leader>h2", function()
	harpoon:list():select(2)
end, { desc = "[H]arpoon Item [2]" })

vim.keymap.set("n", "<leader>h3", function()
	harpoon:list():select(3)
end, { desc = "[H]arpoon Item [3]" })

vim.keymap.set("n", "<leader>h4", function()
	harpoon:list():select(4)
end, { desc = "[H]arpoon Item [4]" })

vim.keymap.set("n", "<leader>h5", function()
	harpoon:list():select(5)
end, { desc = "[H]arpoon Item [5]" })
