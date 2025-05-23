---@diagnostic disable: unused-local

return {
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		event = {
			"LspAttach",
			"BufReadPre",
			"BufNewFile",
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
					css = { "prettier" },
          dart = { "dart format" },
					go = { "goimports", "gofmt" },
					html = { "prettier" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					json = { "prettier" },
					lua = { "stylua" },
					markdown = { "prettier" },
					php = { "php" },
					rust = { "rustfmt", lsp_format = "fallback" },
					svelte = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					yaml = { "prettier" },
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

							local hasSveltePrettierPlugin = vim.fs.find("node_modules/prettier-plugin-svelte", {
								upward = true,
								path = ctx.dirname,
								type = "directory",
							})[1]

							if hasSveltePrettierPlugin then
								table.insert(args, "--plugin")
								table.insert(args, "prettier-plugin-svelte")
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
						args = function(self, ctx)
							local args = { "fix", "$FILENAME" }

							local configFile = os.getenv("HOME") .. "/.config/php-cs-fixer/.php-cs-fixer.php"

							table.insert(args, "--config=" .. configFile)
							table.insert(args, "--using-cache=no")

							return args
						end,
						stdin = false,
					},
				},
			})

			-- JS/TS format with eslint
			bind("n", "<leader>ce", vim.cmd.EslintFixAll, "[C]ode: Run [E]slint with LSP")

			-- Normal: format whole file
			-- Visual: format selected lines
      bind({ "n", "v" }, "<leader>cf", function()
        conform.format({ lsp_format = "fallback", async = true })
        vim.lsp.buf.code_action({
          context = { only = { "source.organizeImports" } },
          apply = true,
        })
      end, "[C]ode: [F]ormat code with conform.nvim")

			-- Format with LSP
			bind({ "n", "v" }, "<leader>cF", vim.lsp.buf.format, "[C]ode: [F]ormat code with LSP")
		end,
	},
}
