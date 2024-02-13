vim.g.mapleader = " "

vim.keymap.set("n", "<leader>qd", "<cmd>Ex<cr>", { desc = "[Q]uit to [D]irectory: Open Ex mode" })
vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>", { desc = "[Q]uit" })

vim.keymap.set("n", "<leader>ws", "<cmd>w<cr>", { desc = "[W]rite: Save" })
vim.keymap.set("n", "<leader>wq", "<cmd>wq<cr>", { desc = "[W]rite: Save & [Q]uit" })
vim.keymap.set("n", "<leader>wd", "<cmd>w<cr><cmd>Ex<cr>", { desc = "[W]rite: Save & quit to [D]irectory" })

vim.keymap.set("n", "H", "^", { desc = "Move cursor to start of line, first non-whitespace" })
vim.keymap.set("n", "L", "$", { desc = "Move cursor to end of line" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line(s) down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line(s) up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Keep cursor centered after moving down" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Search next, keep cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search previous, keep cursor centered" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting (visual mode)" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank to system clipboard (linewise)" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to black hole register" })

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Don't record macro" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open tmux sessionizer" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location item" })

vim.keymap.set(
	"n",
	"<leader>sr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "[S]earch & [R]eplace word under cursor" }
)

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
