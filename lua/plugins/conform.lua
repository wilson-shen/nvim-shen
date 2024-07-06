---@diagnostic disable: unused-local

return {
	{
		"stevearc/conform.nvim",
		cmd = {
			"ConformInfo",
		},
		event = {
			"LspAttach",
			"BufReadPre",
			"BufNewFile",
		},
		dependencies = {
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		},
		config = function()
			local conform = require("conform")

			conform.setup({
				notify_on_error = true,
				-- format_on_save = function(bufnr)
				-- 	local bufname = vim.api.nvim_buf_get_name(bufnr)
				--
				-- 	if bufname:match("/node_modules/") then
				-- 		return
				-- 	end
				--
				-- 	return {
				-- 		timeout_ms = 1000,
				-- 		lsp_fallback = true,
				-- 		async = false,
				-- 	}
				-- end,
				-- format_after_save = {
				-- 	lsp_fallback = true,
				-- },
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
								---@diagnostic disable-next-line: assign-type-mismatch
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
							"$FILENAME",
							"--config=/home/shen/.config/.php-cs-fixer.php",
						},
						stdin = false,
					},
				},
			})

			-- JS/TS format with eslint
			vim.keymap.set("n", "<leader>ce", vim.cmd.EslintFixAll, { desc = "[C]ode: Run [E]slint with LSP" })

			-- Normal: format whole file
			-- Visual: format selected lines
			vim.keymap.set({ "n", "v" }, "<leader>cf", function()
				conform.format({ lsp_fallback = true, async = true })
			end, { desc = "[C]ode: [F]ormat code with conform.nvim" })

			-- Format with LSP
			vim.keymap.set({ "n", "v" }, "<leader>cF", vim.lsp.buf.format, { desc = "[C]ode: [F]ormat code with LSP" })

			require("mason-tool-installer").setup({
				ensure_installed = {
					"phpactor",
					"prettier",
					"stylua",
				},
			})
		end,
	},
}
