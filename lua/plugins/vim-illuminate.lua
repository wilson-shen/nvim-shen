return {
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				delay = 100,
				filetype_overrides = {},
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"fugitive",
				},
				filetypes_allowlist = {},
				modes_denylist = {},
				modes_allowlist = {},
				providers_regex_syntax_denylist = {},
				providers_regex_syntax_allowlist = {},
				under_cursor = true,
				large_file_cutoff = 200,
				large_file_overrides = nil,
				min_count_to_highlight = 2,
				---@diagnostic disable-next-line: unused-local
				should_enable = function(bufnr)
					return true
				end,
				case_insensitive_regex = false,
			})
		end,
	},
}
