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

      vim.keymap.set("n", "<leader>gt", gitsigns.toggle_current_line_blame, { desc = "[G]it: [T]oggle git blame" })
      vim.keymap.set("n", "<leader>gph", gitsigns.preview_hunk, { desc = "[G]it: [P]review [H]unk" })
    end,
  },
}
