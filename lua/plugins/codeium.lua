return {
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.g.codeium_disable_bindings = 1

      vim.keymap.set("i", "<Tab>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true, desc = "Codeium: Accept" })

      vim.keymap.set("i", "<M-n>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true, desc = "Codeium: Next Suggestion" })

      vim.keymap.set("i", "<M-p>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true, desc = "Codeium: Previous Suggestion" })

      vim.keymap.set("i", "<M-/>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true, desc = "Codeium: Clear" })

      vim.keymap.set({"n", "v"}, "<leader>cc", function()
        return vim.fn["codeium#Chat"]()
      end, { expr = true, silent = true, desc = "Codeium: Chat" })
    end
  },
}
