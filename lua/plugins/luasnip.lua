return {
	{
		"L3MON4D3/LuaSnip",
		config = function()
			-- Typescript to use JS snippet
			require("luasnip").filetype_extend("typescript", { "javascript" })
			require("luasnip").filetype_extend("typescriptreact", { "javascript" })
			require("luasnip").filetype_extend("javascriptreact", { "javascript" })
		end,
	},
}
