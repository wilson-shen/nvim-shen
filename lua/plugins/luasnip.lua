return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local luasnip = require("luasnip")
      local snippet = luasnip.snippet
      local text = luasnip.text_node
      local insert = luasnip.insert_node
      local choice = luasnip.choice_node
      local fn = luasnip.function_node

      local function to_pascal(args)
        local str = args[1][1]:gsub("[-_]", " ")
            :gsub("(%l)(%u)", "%1 %2")
            :gsub("%S+", function(w)
              return w:sub(1, 1):upper() .. w:sub(2):lower()
            end)

        return str:gsub(" ", "")
      end

      local function to_snake(args)
        local str = args[1][1]:gsub("-", "_")
            :gsub("([a-z0-9])([A-Z])", "%1_%2")
            :lower()

        return str
      end

      bind("i", "<C-k>", function() luasnip.expand() end, "LuaSnip: Expoand")
      bind({ "i", "s" }, "<C-n>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        else
          luasnip.jump(1)
        end
      end, "LuaSnip: Next choice / jump")
      bind({ "i", "s" }, "<C-p>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(-1)
        else
          luasnip.jump(-1)
        end
      end, "LuaSnip: Previous choice / jump")

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

      luasnip.add_snippets("dart", {
        snippet({
          trig = "csw",
          name = "Riverpod: ConsumerStatefulWidget",
          dscr = "Riverpod ConsumerStatefulWidget snippet",
        }, {
          text({
            "import 'package:flutter_riverpod/flutter_riverpod.dart';",
            "",
            "class ",
          }),
          insert(1, "ClassName"),
          text({
            " extends ConsumerStatefulWidget {",
            "\tconst ",
          }
          ),
          fn(to_pascal, 1),
          text({
            "({super.key});",
            "",
            "\t@override",
            "\tConsumerState<ConsumerStatefulWidget> createState() => _",
          }),
          fn(to_pascal, 1),
          text({
            "State();",
            "}",
            "",
            "class _",
          }),
          fn(to_pascal, 1),
          text({
            "State extends ConsumerState<",
          }),
          fn(to_pascal, 1),
          text({
            "> {",
            "\t@override",
            "\tWidget",
          }),
          insert(0),
          text({
            " build(BuildContext context) {",
            "\t\treturn Container();",
            "\t}",
            "}",
          }),
        }),
      });

      luasnip.add_snippets("dart", {
        snippet({
          trig = "freezed",
          name = "Flutter: Freezed Model",
          dscr = "Freezed model",
        }, {
          text({
            "import 'package:freezed_annotation/freezed_annotation.dart';",
            "",
            "part '",
          }),
          fn(to_snake, 1),
          text({
            ".freezed.dart';",
            "part '",
          }),
          fn(to_snake, 1),
          text({
            ".g.dart';",
            "",
            "",
          }),
          choice(2, {
            text("@freezed"),
            text("@unfreezed"),
          }),
          text({
            "",
            "abstract class ",
          }),
          insert(1, "ClassName"),
          text({
            " with _$",
          }),
          fn(to_pascal, 1),
          text({
            " {",
            "\tconst factory ",
          }),
          fn(to_pascal, 1),
          text({
            "({",
          }),
          insert(0),
          text({
            "}) = _",
          }),
          fn(to_pascal, 1),
          text({
            ";",
            "",
            "\tfactory ",
          }),
          fn(to_pascal, 1),
          text({
            ".fromJson(Map<String, dynamic> json) => _$",
          }),
          fn(to_pascal, 1),
          text({
            "FromJson(json);",
            "}",
          }),
        }),
      });
    end,
  },
}
