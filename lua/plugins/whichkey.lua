return {
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("which-key").register({
        ["c"] = {
          name = "[C]ode", _ = "which_key_ignore",
        },
        ["d"] = {
          name = "[D]iagnostic", _ = "which_key_ignore",
        },
        ["f"] = {
          name = "[F]ile", _ = "which_key_ignore",
        },
        ["g"] = {
          name = "[G]it", _ = "which_key_ignore",
        },
        ["h"] = {
          name = "[H]arpoon", _ = "which_key_ignore",
        },
        ["i"] = {
          name = "[I]import", _ = "which_key_ignore",
          ["p"] = {
            name = "[P]HP", _ = "which_key_ignore",
          }
        },
        ["l"] = {
          name = "[L]azy", _ = "which_key_ignore",
        },
        ["r"] = {
          name = "[R]ename", _ = "which_key_ignore",
        },
        ["s"] = {
          name = "[S]earch", _ = "which_key_ignore",
        },
        ["w"] = {
          name = "[W]rite", _ = "which_key_ignore",
        },
        ["q"] = {
          name = "[Q]uit", _ = "which_key_ignore",
        },
      }, {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false, -- use `nowait` when creating keymaps
        expr = false,   -- use `expr` when creating keymaps
      })
    end,
  },
}
