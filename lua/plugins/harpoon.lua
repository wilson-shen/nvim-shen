return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    config = function ()
      local harpoon = require("harpoon")

      harpoon:setup()

      bind("n", "<leader>ht", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, "[H]arpoon [T]oggle")

      bind("n", "<leader>ha", function()
        harpoon:list():add()
      end, "[H]arpoon [A]dd")

      bind("n", "<leader>hr", function()
        harpoon:list():remove()
      end, "[H]arpoon [R]emove")

      bind("n", "<leader>hc", function()
        harpoon:list():clear()
      end, "[H]arpoon [C]lear")

      for i = 1, 9 do
        bind("n", "<leader>h"..i, function()
          harpoon:list():select(i)
        end, "[H]arpoon Item ["..i.."]")
      end
    end
  },
}
