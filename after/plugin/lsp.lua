-- neodev --
require('neodev').setup()

-- lsp-zero & manson --
local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)


require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'cssls',
    'cssmodules_ls',
    'eslint',
    -- 'golangci_lint_ls',
    -- 'gopls',
    'html',
    'jsonls',
    'lua_ls',
    'phpactor',
    'rust_analyzer',
    'sqlls',
    'svelte',
    'tailwindcss',
    'tsserver',
  },
  handlers = {
    lsp.default_setup,

    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()

      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

-- inlay hints --
local inlay_hints = require('lsp-inlayhints')
inlay_hints.setup()

require('lspconfig').lua_ls.setup({
  on_attach = function(client, bufnr)
    inlay_hints.on_attach(client, bufnr)
  end,
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
      completion ={
        callSnippet = "Replace"
      }
    },
  },
})

-- cmp --
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'codeium'},
  },
  formatting = lsp.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})
