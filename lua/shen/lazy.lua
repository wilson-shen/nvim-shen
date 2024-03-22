local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-treesitter/playground" },
	{ "mbbill/undotree" },
	{ "tpope/vim-fugitive" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "MunifTanjim/nui.nvim" },
	{ "windwp/nvim-ts-autotag" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "loctvl842/monokai-pro.nvim" },

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
	},
	{
		"ccaglak/namespace.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"echasnovski/mini.comment",
		version = "*",
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
	},
	{
		"echasnovski/mini.surround",
		version = "*",
	},
	{
		"folke/neodev.nvim",
		opts = {},
	},
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
	},

	-- Formating --
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{
		"stevearc/conform.nvim",
		event = {
			"LspAttach",
			"BufReadPre",
			"BufNewFile",
		},
	},

	-- LSP --
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{ "lvimuser/lsp-inlayhints.nvim" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
	},
	---------
})
