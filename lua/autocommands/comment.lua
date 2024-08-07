vim.api.nvim_create_autocmd("FileType", {
  pattern = { "php", "cs" },
  callback = function()
    vim.opt_local.commentstring = "// %s"
  end
})
