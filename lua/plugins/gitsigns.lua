return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",

    config = function()
      local gitsigns = require('gitsigns')

      gitsigns.setup({
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      })

      bind("n", "<leader>gt", gitsigns.toggle_current_line_blame, "[G]it: [T]oggle git")
      bind("n", "<leader>gp", gitsigns.preview_hunk_inline, "[G]it: [P]review Hunk")
    end,
  },
}
