require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'c',
    'css',
    'dart',
    'go',
    'gomod',
    'gosum',
    'gowork',
    'html',
    'ini',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'lua',
    'markdown',
    'php',
    'phpdoc',
    'query',
    'rust',
    'scss',
    'sql',
    'svelte',
    'typescript',
    'vim',
    'vimdoc',
  },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
  autotag = {
    enable = true,
  }
}

