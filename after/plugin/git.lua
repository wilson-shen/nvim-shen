local gitsigns = require('gitsigns')

gitsigns.setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
})

vim.keymap.set('n', '<leader>gt', gitsigns.toggle_current_line_blame, { desc = "Toggle git blame" })
vim.keymap.set('n', '<leader>gph', gitsigns.preview_hunk, { desc = "Preview git hunk" })


--- Fungitive ---
vim.keymap.set('n', '<leader>gs', ':Git<cr>', { desc = "Git status" })
vim.keymap.set('n', '<leader>gb', ':Git blame<cr>', { desc = "Git blame" })
vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<cr>', { desc = "Git diff" })
vim.keymap.set('n', '<leader>gl', ':Git log<cr>', { desc = "Git log" })
vim.keymap.set('n', '<leader>gh', ':Git hist<cr>', { desc = "Git history" })
vim.keymap.set('n', '<leader>gw', ':Git write<cr>', { desc = "Git write" })
vim.keymap.set('n', '<leader>gf', ':Git fetch<cr>', { desc = "Git fetch" })
vim.keymap.set('n', '<leader>gal', ':Git pull<cr>', { desc = "Git pull" })
vim.keymap.set('n', '<leader>gps', ':Git push<cr>', { desc = "Git push" })

vim.keymap.set('n', '<leader>gr', ':Git rebase -i', { desc = "Git rebase" })
vim.keymap.set('n', '<leader>ga', ':Git add', { desc = "Git add" })
vim.keymap.set('n', '<leader>gcm', ':Git commit -m', { desc = "Git commit" })
vim.keymap.set('n', '<leader>gco', ':Git checkout', { desc = "Git checkout" })
vim.keymap.set('n', '<leader>gcb', ':Git checkout -b', { desc = "Git checkout -b" })
vim.keymap.set('n', '<leader>gm', ':Git merge', { desc = "Git merge" })
vim.keymap.set('n', '<leader>gfm', ':Git fetch origin master', { desc = "Git fetch origin master" })
