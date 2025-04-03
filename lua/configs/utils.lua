function _G.bind(mode, keys, func, desc, opts)
  local default_opts = { desc = desc, noremap = true, silent = true }
	
  vim.keymap.set(mode, keys, func, vim.tbl_extend("force", default_opts, opts or {}))
end
