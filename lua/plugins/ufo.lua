--- @diagnostic disable: unused-local, missing-fields
return {
	{
		"kevinhwang91/nvim-ufo",
		event = "BufEnter",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			local ufo = require("ufo")

			local fold_text = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			ufo.setup({
				close_fold_kinds_for_ft = {
					default = {
						"imports",
					},
				},
				provider_selector = function(_bufnr, _filetype, _buftype)
					return { "treesitter", "indent" }
				end,
				fold_virt_text_handler = fold_text,
			})

			vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Fold: Open All" })
			vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Fold: Close All" })

			-- Toggle folds according to level
			vim.keymap.set("n", "zm1", function()
				ufo.closeFoldsWith(0)
			end, { desc = "Fold: Close Level 1" })
			vim.keymap.set("n", "zm2", function()
				ufo.closeFoldsWith(1)
			end, { desc = "Fold: Close Level 2" })
			vim.keymap.set("n", "zm3", function()
				ufo.closeFoldsWith(2)
			end, { desc = "Fold: Close Level 3" })
			vim.keymap.set("n", "zm4", function()
				ufo.closeFoldsWith(3)
			end, { desc = "Fold: Close Level 4" })
			vim.keymap.set("n", "zm5", function()
				ufo.closeFoldsWith(4)
			end, { desc = "Fold: Close Level 5" })
			vim.keymap.set("n", "zm6", function()
				ufo.closeFoldsWith(5)
			end, { desc = "Fold: Close Level 6" })
			vim.keymap.set("n", "zm7", function()
				ufo.closeFoldsWith(6)
			end, { desc = "Fold: Close Level 7" })
			vim.keymap.set("n", "zm8", function()
				ufo.closeFoldsWith(7)
			end, { desc = "Fold: Close Level 8" })
			vim.keymap.set("n", "zm9", function()
				ufo.closeFoldsWith(8)
			end, { desc = "Fold: Close Level 9" })

			vim.keymap.set("n", "K", function()
				local winid = ufo.peekFoldedLinesUnderCursor()

				if not winid then
					vim.lsp.buf.hover()
				end
			end)
		end,
	},
}

