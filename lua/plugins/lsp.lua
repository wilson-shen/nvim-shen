---@diagnostic disable: unused-local

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "j-hui/fidget.nvim" },
			{ "folke/neodev.nvim" },
			{ "b0o/schemastore.nvim" },
		},
		config = function()
			-- Neodev
			require("neodev").setup()

			-- LSP
			local lsp = require("lsp-zero")

			local lsp_attach = function(client, bufnr)
				lsp.highlight_symbol(client, bufnr)
			end

			lsp.extend_lspconfig({
				float_border = "rounded",
				sign_text = true,
				capabilities = require('blink.cmp').get_lsp_capabilities(),
				lsp_attach = lsp_attach,
			})

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
				map("gi", telescope_builtin.lsp_implementations, "[G]oto [I]mplementation")

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
			end)

			-- Ensure the servers and tools above are installed
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})

			local lspconfig = require("lspconfig")

			require("mason-lspconfig").setup({
				automatic_installation = false,
				ensure_installed = {
					-- "csharp_ls",
					"cssls",
					"cssmodules_ls",
					"eslint",
					"golangci_lint_ls",
					"gopls",
					"html",
					"jsonls",
					"lua_ls",
					"marksman",
					"phpactor",
					"rust_analyzer",
					"sqlls",
					"svelte",
					"tailwindcss",
					"ts_ls",
				},
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = lsp.get_capabilities(),
						})

						lsp.default_setup(server_name)
					end,

					jsonls = function()
						lspconfig.jsonls.setup({
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
						})
					end,

					lua_ls = function()
						local lua_opts = lsp.nvim_lua_ls()

						lua_opts.settings = {
							Lua = {
								hint = {
									enable = true,
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						}

						lspconfig.lua_ls.setup(lua_opts)
					end,

					phpactor = function()
						lspconfig.phpactor.setup({
							filetypes = { "php", "blade" },
						})
					end,

					tailwindcss = function()
						lspconfig.tailwindcss.setup({
							settings = {
								tailwindCSS = {
									experimental = {
										classRegex = {
											{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
											{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
										},
									},
								},
							},
						})
					end,

					ts_ls = function()
						lspconfig.ts_ls.setup({
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
						})
					end,
				},
			})

			-- Enable Flutter/Dart LSP
			lsp.setup_servers({ "dartls", force = true })
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
						completeFunctionCalls = false,
						showTodos = true,
						lineLength = 80,
					},
				},
			})

			-- default hide diagnostics messages
			vim.diagnostic.config({
				virtual_text = false,
			})

			-- LSP inlay hint
			if vim.lsp.inlay_hint then
				vim.keymap.set("n", "<leader>ch", function()
					---@diagnostic disable-next-line: missing-parameter
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, { desc = "[C]ode: Toggle Inlay [H]ints" })
			end
		end,
	},
}
