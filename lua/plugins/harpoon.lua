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

      -- vim.keymap.set("n", "<leader>h1", function()
      --   harpoon:list():select(1)
      -- end, { desc = "[H]arpoon Item [1]" })
      --
      -- vim.keymap.set("n", "<leader>h2", function()
      --   harpoon:list():select(2)
      -- end, { desc = "[H]arpoon Item [2]" })
      --
      -- vim.keymap.set("n", "<leader>h3", function()
      --   harpoon:list():select(3)
      -- end, { desc = "[H]arpoon Item [3]" })
      --
      -- vim.keymap.set("n", "<leader>h4", function()
      --   harpoon:list():select(4)
      -- end, { desc = "[H]arpoon Item [4]" })
      --
      -- vim.keymap.set("n", "<leader>h5", function()
      --   harpoon:list():select(5)
      -- end, { desc = "[H]arpoon Item [5]" })
    end
  },
}
