return {
  {
    "nvim-flutter/flutter-tools.nvim",
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
          capabilities = function()
            return vim.lsp.protocol.make_client_capabilities()
          end,
          settings = {
            completeFunctionCalls = false,
            enableSnippets = true,
            lineLength = 80,
            showTodos = true,
            updateImportsOnRename = true,
          },
        },
      })

      telescope.load_extension("flutter")

      bind("n", "<leader>ff", function()
        telescope.extensions.flutter.commands()
      end, "[F]lutter [F]ind")

      bind("n", "<leader>fq", "<cmd>FlutterQuit<cr>", "[F]lutter [Q]uit")
      bind(
        "n",
        "<leader>fh",
        "<cmd>FlutterReload<cr>",
        "[F]lutter [H]ot reload"
      )
      bind(
        "n",
        "<leader>fr",
        "<cmd>FlutterRestart<cr>",
        "[F]lutter [R]estart"
      )
      bind(
        "n",
        "<leader>fc",
        "<cmd>FlutterLogClear<cr>",
        "[F]lutter Log [C]lear"
      )
      bind(
        "n",
        "<leader>ft",
        "<cmd>FlutterLogToggle<cr>",
        "[F]lutter Log [T]oggle"
      )
      bind(
        "n",
        "<leader>fe",
        "<cmd>FlutterEmulators<cr>",
        "[F]lutter [E]mulators"
      )

      -- Flutter Run with options
      local select_run = {
        {
          name = "Debug: Verbose",
          args = { "--debug", "--verbose" },
        },
        {
          name = "Debug: Official Verbose",
          args = { "--flavor official", "--debug", "--verbose" },
        },
      }

      bind("n", "<leader>fs", function()
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
      end, "[F]lutter [S]tart with options")
    end,
  },
}
