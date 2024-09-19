vim.api.nvim_create_autocmd("FileType", {
  pattern = { "php", "cs" },
  callback = function()
    vim.opt_local.textwidth = 120
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "js", "ts", "jsx", "tsx", "dart" },
  callback = function()
    vim.opt_local.textwidth = 100
  end
})
