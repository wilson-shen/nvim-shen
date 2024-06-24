vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI"}, {
  pattern = "*",
  callback = function()
    if vim.fn.line(".") == vim.fn.line("$") then
      -- delay 500ms
      vim.defer_fn(function()
        vim.cmd("normal! zz")
      end, 500)
    end
  end,
})
