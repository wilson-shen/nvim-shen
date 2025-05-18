return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local luasnip = require("luasnip")
      local snippet = luasnip.snippet
      local text = luasnip.text_node
      local insert = luasnip.insert_node

      -- Typescript to use JS snippet
      luasnip.filetype_extend("typescript", { "javascript" })
      luasnip.filetype_extend("typescriptreact", { "javascript" })
      luasnip.filetype_extend("javascriptreact", { "javascript" })

      -- PHP --
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
        snippet({
          trig = "divider",
          name = "Laravel: section divider",
          dscr = "Long section divider",
        }, {
          text({
            "/********************************************************************************",
            " * ",
          }),
          insert(0),
          text({
            "",
            " ********************************************************************************/",
          }),
        }),
      })

      -- JS/TS --
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

      -- Flutter --
      luasnip.add_snippets("dart", {
        snippet({
          trig = "color",
          name = "Flutter: Color with Alpha pre-set",
          dscr = "Color(0xFF)",
        }, {
          text("Color(0xFF"),
          insert(0),
          text(")"),
        }),
      });
    end,
  },
}
