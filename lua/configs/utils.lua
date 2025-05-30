function _G.bind(mode, keys, func, desc, opts)
  local default_opts = { desc = desc, noremap = true, silent = true }

  vim.keymap.set(mode, keys, func, vim.tbl_extend("force", default_opts, opts or {}))
end

function _G.str_split(str, sep)
  if str == nil or str == "" then
   return {}
  end

  if sep == nil then
    sep = '%s'
  end

  local split = {}

  for s in string.gmatch(str, sep) do
    table.insert(split, s)
  end

  return split
end
