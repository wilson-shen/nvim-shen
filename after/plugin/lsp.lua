-- function --
function AddDescToOpts(opts, desc)
	opts["desc"] = desc
	return opts
end

-- neodev --
require("neodev").setup()

-- lsp-zero & manson --
local lsp = require("lsp-zero")

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, AddDescToOpts(opts, "Go to definition"))

	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, AddDescToOpts(opts, "Show hover"))

	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, AddDescToOpts(opts, "Next diagnostic"))

	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, AddDescToOpts(opts, "Previous diagnostic"))

	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, AddDescToOpts(opts, "Signature help"))

	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, AddDescToOpts(opts, "[V]iew: [D]iagnostic"))

	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, AddDescToOpts(opts, "[C]ode [A]ction"))

	vim.keymap.set("n", "<leader>crf", function()
		vim.lsp.buf.references()
	end, AddDescToOpts(opts, "[C]ode [R]e[F]erences"))

	vim.keymap.set("n", "<leader>crn", function()
		vim.lsp.buf.rename()
	end, AddDescToOpts(opts, "[C]ode [R]e[N]ame"))
end)

require("mason").setup({
	ui = {
		border = "rounded",
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"cssls",
		"cssmodules_ls",
		"eslint",
		-- 'golangci_lint_ls',
		-- 'gopls',
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

-- inlay hints --
local inlay_hints = require("lsp-inlayhints")
inlay_hints.setup()

require("lspconfig").lua_ls.setup({
	on_attach = function(client, bufnr)
		inlay_hints.on_attach(client, bufnr)
	end,
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

-- cmp --
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "codeium" },
	},
	formatting = lsp.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<C-l>"] = cmp.mapping.complete(), -- [L]ist
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select), -- [P]revious
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select), -- [N]ext
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- [Enter]Confirm
	}),
	window = {
		completion = {
			border = "rounded",
		},
		documentation = {
			border = "rounded",
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
