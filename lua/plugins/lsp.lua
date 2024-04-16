return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "j-hui/fidget.nvim",                opts = {} },
      { "folke/neodev.nvim",                opts = {} },
    },
    config = function()
      -- Neodev
      require("neodev").setup()

      -- LSP
      local lsp = require("lsp-zero")

      lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = opts.buf, desc = "LSP: " .. desc })
        end

        local telescope_builtin = require("telescope.builtin")

        -- Jump to the definition of the word under cursor.
        map("gd", telescope_builtin.lsp_definitions, "[G]oto [D]efinition")

        -- Find references for the word under cursor.
        map("gr", telescope_builtin.lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under cursor.
        map("gI", telescope_builtin.lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under cursor.
        map("<leader>D", telescope_builtin.lsp_type_definitions, "Type [D]efinition")

        -- Fuzzy find all the symbols in current document.
        map("<leader>ss", telescope_builtin.lsp_document_symbols, "[S]earch [S]ymbols")

        -- Fuzzy find all the symbols in current workspace.
        map("<leader>sS", telescope_builtin.lsp_dynamic_workspace_symbols, "[S]earch Workspace [S]ymbols")

        -- Execute a code action
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Opens a popup that displays documentation about the word under your cursor
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- Goto Declaration.
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        if client and client.server_capabilities.documentHighlightProvider then
          -- Highlight references of the word under cursor when cursor rests on it.
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = opts.buf,

            callback = vim.lsp.buf.document_highlight,
          })

          -- When cursor moved, the highlights will be cleared.
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = opts.buf,

            callback = vim.lsp.buf.clear_references,
          })
        end
      end)

      -- Ensure the servers and tools above are installed
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "csharp_ls",
          "cssls",
          "cssmodules_ls",
          "eslint",
          -- "golangci_lint_ls",
          -- "gopls",
          "html",
          "jsonls",
          "lua_ls",
          "phpactor",
          "rust_analyzer",
          "sqlls",
          "svelte",
          "tailwindcss",
          "tsserver",
        },
        handlers = {
          lsp.default_setup,

          lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()

            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })

      lsp.setup_servers({ "dartls", force = true })

      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            hint = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })

      lspconfig.dartls.setup({
        cmd = { "dart", "language-server", "--protocol=lsp" },
        filetypes = { "dart" },
        init_options = {
          closingLabels = true,
          flutterOutline = true,
          onlyAnalyzeProjectsWithOpenFiles = true,
          outline = true,
          suggestFromUnimportedLibraries = true,
        },
        root_dir = lspconfig.util.root_pattern("pubspec.yaml"),
        settings = {
          dart = {
            completeFunctionCalls = true,
            showTodos = true,
          },
        },
      })

      -- Floating windows --
      vim.o.updatetime = 250
      vim.api.nvim_create_autocmd({ "CursorHold" }, {
        group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
        callback = function()
          vim.diagnostic.open_float(nil, { focus = false })
        end,
      })
      vim.diagnostic.config({
        float = {
          border = "rounded",
        },
      })

      -- Auto import not to use relative path --
      require("lspconfig").tsserver.setup({
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "non-relative",
            importModuleSpecifierEnding = "minimal",
          },
        },
      })
    end
  },
}
