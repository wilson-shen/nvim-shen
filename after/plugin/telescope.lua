local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

vim.keymap.set('n', '<leader>sa', function() 
	local grep_string_input = vim.fn.input("Search All: ")

	if (grep_string_input == '') then
		return
	end

	builtin.grep_string({ search = grep_string_input });
end)

require('telescope').load_extension('file_browser')
