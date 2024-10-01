vim.api.nvim_create_autocmd("FileType", {
  pattern = { "php", "cs" },
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.showbreak = string.rep(" ", 4)
  end
})
