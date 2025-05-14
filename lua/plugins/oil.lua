vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})

return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "VeryLazy" },
    config = function()
      local oil = require("oil")

      oil.setup({
        default_file_explorer = true,
        use_default_keymaps = false,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-h>"] = "actions.select_split",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<Esc>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            local m = name:match(".DS_Store")
            return m ~= nil
          end,
        },
        win_options = {
          foldcolumn = "1",
        },
      })

      bind("n", "-", function()
        oil.open_float(nil, {
          preview = {
            vertical = true,
          },
        })
      end, "[O]il File Explorer")

      bind("n", "_", function()
        oil.open_float(vim.fn.getcwd())
      end, "[O]il File Explorer")
    end,
  },
}
