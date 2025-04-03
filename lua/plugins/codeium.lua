return {
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			vim.g.codeium_disable_bindings = 1
			vim.g.codeium_filetypes = {
				TelescopePrompt = false,
				dressing = false,
				fugitive = false,
				help = false,
			}

			bind("i", "<Tab>", function()
				return vim.fn["codeium#Accept"]()
			end, "Codeium: Accept", { expr = true })

			bind("i", "<M-n>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, "Codeium: Next Suggestion", { expr = true })

			bind("i", "<M-p>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, "Codeium: Previous Suggestion", { expr = true })

			bind("i", "<M-/>", function()
				return vim.fn["codeium#Clear"]()
			end, "Codeium: Clear", { expr = true })
		end,
	},
}
