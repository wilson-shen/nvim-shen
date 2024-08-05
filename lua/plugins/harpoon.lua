return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    config = function ()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "<leader>ht", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "[H]arpoon [T]oggle" })

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end, { desc = "[H]arpoon [A]dd" })

      vim.keymap.set("n", "<leader>hr", function()
        harpoon:list():remove()
      end, { desc = "[H]arpoon [R]emove" })

      vim.keymap.set("n", "<leader>hc", function()
        harpoon:list():clear()
      end, { desc = "[H]arpoon [C]lear" })

      for i = 1, 9 do
        vim.keymap.set("n", "<leader>h"..i, function()
          harpoon:list():select(i)
        end, { desc = "[H]arpoon Item ["..i.."]" })
      end
    end
  },
}
