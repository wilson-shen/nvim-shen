return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = {
            enable = true,
            leave_dirs_open = false,
          },
        },
        buffers = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
        },
        lazy = false,
      })

      vim.keymap.set("n", "<C-e>", "<cmd>Neotree filesystem toggle left<cr>", { desc = "Neotree: Toggle Explorer" })
      vim.keymap.set("n", "<M-e>", "<cmd>Neotree filesystem reveal left<cr>", { desc = "Neotree: Reveal current file" })
    end
  }
}
