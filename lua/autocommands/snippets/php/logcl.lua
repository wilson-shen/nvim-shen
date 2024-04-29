local luasnip = require("luasnip")
local snippet = luasnip.snippet
local text = luasnip.text_node
local insert = luasnip.insert_node

luasnip.add_snippets("php", {
	snippet({
		trig = "logcl",
		name = "Laravel: logger",
		dscr = "logger()",
	}, {
		text({
			"logger([",
			"\t__CLASS__,",
			"\t__LINE__,",
			"\t",
		}),
		insert(0),
		text({ "", "]);" }),
	}),
})
