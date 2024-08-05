vim.api.nvim_create_autocmd({ "CursorHold", "CursorMoved" }, {
	pattern = "*",
	callback = function()
		if vim.api.nvim_get_mode().mode == "n" and vim.fn.line(".") == vim.fn.line("$") then
			vim.defer_fn(function()
				vim.cmd("normal! zz")
			end, 500)
		end
	end,
})
