return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			local harpoon = require("harpoon")

			local function truncate_branch_name(branch)
				if not branch or branch == "" then
					return ""
				end

				-- Match the branch name to the specified format
				local user, team, ticket_number = string.match(branch, "^(%w+)/(%w+)%-(%d+)")

				-- If the branch name matches the format, display {user}/{team}-{ticket_number}, otherwise display the full branch name
				if ticket_number then
					return user .. "/" .. team .. "-" .. ticket_number
				else
					return branch
				end
			end

			-- Replicate Harpoon v1's get_current_index
			local function harpoon_get_current_index(harpoon_items)
				-- Get current buffer name
				local current_buffer = vim.api.nvim_buf_get_name(0)

				-- Loop through harpoon list items
				for index, item in ipairs(harpoon_items) do
					-- Check if item name matches current buffer name (assuming name is the key)
					if current_buffer:find(item.value, 1, true) then
						return index
					end
				end

				return nil
			end

			local function harpoon_component()
				local total_marks = harpoon:list():length()

				if total_marks == 0 then
					return ""
				end

				local current_mark = harpoon_get_current_index(harpoon:list().items)

				return string.format("󰛢 %s/%d", current_mark, total_marks)
			end

			local function codeium_component()
				local status = vim.fn["codeium#GetStatusString"]()
				return string.format("{…}%s", status)

			end

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "" } },
					},
					lualine_b = {
						{ "branch", icon = "", fmt = truncate_branch_name },
						harpoon_component,
						codeium_component,
						"diff",
						"diagnostics",
					},
					lualine_c = {
						{ "filename", path = 1 },
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_z = {
						{ "location", separator = { right = "" } },
					},
				},
			})
		end,
	},
}
