local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
		php = { "php" },
		["_"] = { "trim_whitespace" },
	},
	format_on_save = function(bufnr)
		local bufname = vim.api.nvim_buf_get_name(bufnr)

		if bufname:match("/node_modules/") then
			return
		end

		return {
			timeout_ms = 500,
			lsp_fallback = true,
			async = true,
		}
	end,
	format_after_save = {
		lsp_fallback = true,
	},
	notify_on_error = true,
	formatters = {
		prettier = {
			args = function(self, ctx)
				local prettier_roots = { ".prettierrc", ".prettierrc.json", "prettier.config.js" }
				local args = { "--stdin-filepath", "$FILENAME" }

				local localPrettierConfig = vim.fs.find(prettier_roots, {
					upward = true,
					path = ctx.dirname,
					type = "file",
				})[1]

				local globalPrettierConfig = vim.fs.find(prettier_roots, {
					path = vim.fn.stdpath("config"),
					type = "file",
				})[1]
				local disableGlobalPrettierConfig = os.getenv("DISABLE_GLOBAL_PRETTIER_CONFIG")

				if localPrettierConfig then
					table.insert(args, "--config")
					table.insert(args, localPrettierConfig)
				elseif globalPrettierConfig and not disableGlobalPrettierConfig then
					table.insert(args, "--config")
					table.insert(args, globalPrettierConfig)
				end

				local hasTailwindPrettierPlugin = vim.fs.find("node_modules/prettier-plugin-tailwindcss", {
					upward = true,
					path = ctx.dirname,
					type = "directory",
				})[1]

				if hasTailwindPrettierPlugin then
					table.insert(args, "--plugin")
					table.insert(args, "prettier-plugin-tailwindcss")
				end

				return args
			end,
		},

		php = {
			command = "php-cs-fixer",
			args = {
				"fix",
				"--config=~/.config/composer/vendor/bin/.php-cs-fixer.php",
			},
			stdin = false,
		},
	},
})

-- Key bindings --
vim.keymap.set("n", "<leader>ce", vim.cmd.EslintFixAll, { desc = "[C]ode: Run [E]slint with LSP" })

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	conform.format({ lsp_fallback = true, async = true })
end, { desc = "[C]ode: [F]ormat code with conform.nvim" })

vim.keymap.set("n", "<leader>cF", vim.lsp.buf.format, { desc = "[C]ode: [F]ormat code with LSP" })

-- Ensure Install prettier --
require("mason-tool-installer").setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"phpactor",
	},
})
