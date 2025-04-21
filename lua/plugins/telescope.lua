return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							layout_config = {
								width = function(_, max_columns, _)
									return math.min(max_columns, 200)
								end,
								height = function(_, _, max_lines)
									return math.min(max_lines, 20)
								end,
							},
						}),
					},
				},
				defaults = {
					file_ignore_patterns = {
						".git/",
						"node_modules/",
						"vendor/",
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "ui-select")
			pcall(telescope.load_extension, "file_browser")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			bind("n", "<leader>sh", builtin.help_tags, "[S]earch [H]elp")
			bind("n", "<leader>sk", builtin.keymaps, "[S]earch [K]eymaps")
			bind("n", "<leader>sf", builtin.find_files, "[S]earch [F]iles")
			bind("n", "<leader>st", builtin.builtin, "[S]earch Select [T]elescope")
			bind("n", "<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
			bind("n", "<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
			bind("n", "<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
			bind("n", "<leader>sr", builtin.oldfiles, "[S]earch [R]ecent Files")
			bind("n", "<leader>sl", builtin.resume, "[S]earch [L]ast Search")
			bind("n", "<leader>sb", builtin.buffers, "[S]earch existing [B]uffers")

			bind("n", "<leader>sc", builtin.current_buffer_fuzzy_find, "[S]earch in [C]urrent buffer")

			bind("n", "<leader>so", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, "[S]earch in [O]pen Files")

			bind("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, "[S]earch [N]eovim files")
		end,
	},
}
