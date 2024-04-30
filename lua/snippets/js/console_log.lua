local luasnip = require("luasnip")
local snippet = luasnip.snippet
local text = luasnip.text_node
local insert = luasnip.insert_node

luasnip.add_snippets("javascript", {
	snippet({
		trig = "log",
		name = "JS/TS: console log",
		dscr = "console.log()",
	}, {
		text("console.log("),
		insert(0),
		text(");"),
	}),
})
