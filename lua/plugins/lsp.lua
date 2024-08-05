return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
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

				if
					(vim.bo.filetype ~= "json" or vim.bo.filetype ~= "markdown")
					and client
					and client.server_capabilities.documentHighlightProvider
				then
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
				else
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" }, {
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
					"biome", -- js, ts, json
					"csharp_ls",
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

			lspconfig.phpactor.setup({
				filetypes = { "php", "blade" },
			})

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
						completeFunctionCalls = true,
						showTodos = true,
					},
				},
			})

			-- JSON --
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

			-- TS Server --
			lspconfig.tsserver.setup({
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

			-- csharp_ls --
			lspconfig.csharp_ls.setup({})

			-- Floating windows --
			vim.o.updatetime = 250

			vim.keymap.set("n", "<leader>dm", function()
				vim.diagnostic.open_float(nil, { focus = false })
			end, { desc = "[D]iagnostics: [M]essage" })

			vim.diagnostic.config({
				float = {
					border = "rounded",
				},
			})

			-- Diagnostic signs
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

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
