local wk = require('which-key')

wk.register(
  {
    -- autoimport.lua
    i = {
      name = "Import/Insert",

      p = {
        name = "PHP",
      },
    },

    -- formatting.lua
    c = {
      name = "Code",

      -- lsp.lua
      r = {
        name = "Reference/Rename"
      },
    },

    -- git.lua
    g = {
      name = "Git",
      p = {
        name = "Preview/Pull/Push",
      },
      c = {
        name = "Commit/Checkout",
      },
    },

    -- harpoon.lua
    h = {
      name = "Harpoon",
    },

    -- lsp.lua
    v = {
      name = "View",
    },

    -- telescope.lua, lua/shen/keymap.lua `<leader>sr`
    s = {
      name = "Search",
    },

    -- lua/shen/keymap.lua
    q = {
			name = "Quit",
		},
		w = {
			name = "Write",
		},
  },
  {
    mode = 'n',
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
    expr = false, -- use `expr` when creating keymaps
  }
)
