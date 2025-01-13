return {
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			local flutter_tools = require("flutter-tools")
			local telescope = require("telescope")

			flutter_tools.setup({
				lsp = {
					capabilities = require("lsp-zero").get_capabilities(),
				},
			})

			telescope.load_extension("flutter")

			vim.keymap.set("n", "<leader>ff", function()
				telescope.extensions.flutter.commands()
			end, { desc = "[F]lutter [F]ind", noremap = true })

			vim.keymap.set("n", "<leader>fq", "<cmd>FlutterQuit<cr>", { desc = "[F]lutter [Q]uit", noremap = true })
			vim.keymap.set(
				"n",
				"<leader>fh",
				":FlutterReload",
				{ desc = "[F]lutter [H]ot reload", noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>fr",
				":FlutterRestart",
				{ desc = "[F]lutter [R]estart", noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>fc",
				":FlutterLogClear",
				{ desc = "[F]lutter Log [C]lear", noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>ft",
				":FlutterLogToggle",
				{ desc = "[F]lutter Log [T]oggle", noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>fe",
				":FlutterEmulators",
				{ desc = "[F]lutter [E]mulators", noremap = true, silent = true }
			)

			-- Flutter Run with options
			local select_run = {
				{
					name = "Dev: Android",
					args = { "--flavor", "official", "--verbose" },
				},
				{
					name = "Dev: Verbose",
					args = { "--verbose" },
				},
			}

			vim.keymap.set("n", "<leader>fs", function()
				local pickers = require("telescope.pickers")
				local entry_display = require("telescope.pickers.entry_display")
				local finders = require("telescope.finders")
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")

				local conf = require("telescope.themes").get_dropdown({
					width = 0.5,
					previewer = true,
					prompt_title = "Flutter Run Options",
					results_title = false,
				})

				pickers
					.new(conf, {
						finder = finders.new_table({
							results = select_run,
							entry_maker = function(entry)
								local max_width = 10

								for _, item in ipairs(select_run) do
									max_width = #item.name > max_width and #item.name or max_width
								end

								local has_args = entry.args and #entry.args ~= 0

								local displayer = entry_display.create({
									separator = has_args and " • " or "",
									items = {
										{ width = max_width },
										{ remaining = true },
									},
								})

								local items = { { entry.name, "String" } }

								if has_args then
									table.insert(items, { table.concat(entry.args, " "), "Structure" })
								end

								return {
									value = entry,
									ordinal = entry.name,
									display = function()
										return displayer(items)
									end,
								}
							end,
						}),
						sorter = require("telescope.config").values.generic_sorter({}),
						attach_mappings = function(prompt_bufnr)
							actions.select_default:replace(function()
								actions.close(prompt_bufnr)
								local selection = action_state.get_selected_entry()

								local args = table.concat(selection.value.args, " ")
								vim.cmd("FlutterRun " .. args)
							end)

							return true
						end,
					})
					:find()
			end, { desc = "[F]lutter [S]tart with options", noremap = true })
		end,
	},
}
