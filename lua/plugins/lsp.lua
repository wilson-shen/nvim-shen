return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "saghen/blink.cmp" },
      { "b0o/schemastore.nvim" },
      {
        "j-hui/fidget.nvim",
        opts = {},
      },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach", { clear = true }),
        callback = function(event)
          local lsp_opts = { buffer = event.buf }
          local telescope_builtin = require("telescope.builtin")

          bind("n", "gd", telescope_builtin.lsp_definitions, "[G]oto [D]efinition", lsp_opts)
          bind("n", "gr", telescope_builtin.lsp_references, "[G]oto [R]eferences", lsp_opts)
          bind("n", "gi", telescope_builtin.lsp_implementations, "[G]oto [I]mplementation", lsp_opts)
          bind("n", "gt", telescope_builtin.lsp_type_definitions, "[G]oto [T]ype Definition", lsp_opts)
          bind("n", "gsd", telescope_builtin.lsp_document_symbols, "[G]oto [S]ymbol: [D]ocuments", lsp_opts)
          bind(
            "n",
            "gsw",
            telescope_builtin.lsp_dynamic_workspace_symbols,
            "[G]oto [S]ymbols: [W]orkspace",
            lsp_opts
          )
          bind("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame", lsp_opts)
          bind({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", lsp_opts)
          bind("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration", lsp_opts)
          bind("n", "K", vim.lsp.buf.hover, "Hover Documentation")

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
              return client:supports_method(method, bufnr)
            else
              ---@diagnostic disable-next-line: param-type-mismatch
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if
              client and
              client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
          then
            bind("n", "<leader>ch", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = true,
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
        } or {},
        virtual_text = false,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require('blink.cmp').get_lsp_capabilities())

      local servers = {
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              hint = {
                enable = true,
              },
              runtime = {
                version = "LuaJIT"
              },
              diagnostics = {
                globals = {
                  "vim",
                },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        phpactor = {
          filetype = {
            "php",
            "blade",
          },
        },
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                },
              },
            },
          },
        },
        ts_ls = {
          init_options = {
            preferences = {
              importModuleSpecifierPreference = "non-relative",
              importModuleSpecifierEnding = "minimal",
            },
          },
          settings = {
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- false
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true, -- false
              },
            },
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "cssls",
        "cssmodules_ls",
        "eslint",
        "golangci_lint_ls",
        "gopls",
        "html",
        "marksman",
        "rust_analyzer",
        "sqlls",
        "svelte",
      })

      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

            lspconfig[server_name].setup(server)
          end,
        },
      })

      -- Custom Flutter/Dart LSP
      -- lspconfig.dartls.setup({
      --   cmd = { "dart", "language-server", "--protocol=lsp" },
      --   filetypes = { "dart" },
      --   init_options = {
      --     closingLabels = true,
      --     flutterOutline = true,
      --     onlyAnalyzeProjectsWithOpenFiles = true,
      --     outline = true,
      --     suggestFromUnimportedLibraries = true,
      --   },
      --   root_dir = lspconfig.util.root_pattern("pubspec.yaml"),
      --   settings = {
      --     dart = {
      --       completeFunctionCalls = false,
      --       showTodos = true,
      --       lineLength = 80,
      --     },
      --   },
      -- })
    end,
  },
}
