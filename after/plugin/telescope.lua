local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", builtin.git_files, { desc = "[S]earch [G]it Files" })

vim.keymap.set("n", "<leader>sa", function()
	local grep_string_input = vim.fn.input("Search All: ")

	if grep_string_input == "" then
		return
	end

	builtin.grep_string({ search = grep_string_input })
end, { desc = "[S]earch [A]ll" })

require("telescope").load_extension("file_browser")
