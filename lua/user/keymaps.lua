-- local TERM = os.getenv("TERM")
local bind = vim.keymap.set

-- Disable F1
bind({ "n", "i", "v" }, "<F1>", "<nop>", { desc = "Disable F1 help, use :help" })

-- Rebind record macro
bind("n", "Q", "q", { desc = "Record macro" })
bind("n", "q", "<nop>", { desc = "Disable record macro, use <leader>q" })

-- Clear hightlignt after search is highlighted
bind("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Disable highlight search" })

-- Quit
bind("n", "<leader>qq", "<cmd>q<cr>", { desc = "[Q]uit" })
bind("n", "<leader>qd", "<cmd>Ex<cr>", { desc = "[Q]uit to [D]irectory" })

-- Write action
bind("n", "<leader>ws", "<cmd>w<cr>", { desc = "[W]rite: [S]ave" })
bind("n", "<leader>wq", "<cmd>wq<cr>", { desc = "[W]rite: Save & [Q]uit" })
bind("n", "<leader>wd", "<cmd>w<cr><cmd>Ex<cr>", { desc = "[W]rite: Save & quit to [D]irectory" })

-- Extra Delete, Yank, Paste config
bind("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting (visual mode)" })
bind({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
bind("n", "<leader>Y", [["+Y]], { desc = "Yank to system clipboard (linewise)" })
bind({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to black hole register" })

-- Neovim windows navigation
bind("n", "<C-v>", "<C-w><C-v>", { desc = "Create vertical window" })
bind("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
bind("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
bind("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
bind("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Navigate in Neovim
bind("n", "H", "^", { desc = "Go to first character in current line" })
bind("n", "L", "$", { desc = "Go to last character in current line" })
bind("n", "J", "mzJ`z", { desc = "Keep cursor centered after moving down" })
bind("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down and center" })
bind("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up and center" })
bind("n", "n", "nzzzv", { desc = "Search next, keep cursor centered" })
bind("n", "N", "Nzzzv", { desc = "Search previous, keep cursor centered" })
bind("n", "<leader>k", "<cmd>lnext<cr>zz", { desc = "Next location item" })
bind("n", "<leader>j", "<cmd>lprev<cr>zz", { desc = "Previous location item" })
bind("n", "{", "{zz", { desc = "" })
bind("n", "}", "}zz", { desc = "" })
bind("n", "G", "Gzz", { desc = "" })
bind("n", "<C-i>", "<C-i>zz", { desc = "" })
bind("n", "<C-o>", "<C-o>zz", { desc = "" })
bind("n", "%", "%zz", { desc = "" })
bind("n", "*", "*zz", { desc = "" })
bind("n", "#", "#zz", { desc = "" })

-- Move lines
bind("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line(s) down" })
bind("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line(s) up" })

-- Search and replace
bind(
  "n",
  "<leader>rp",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "[R]e[p]lace word under cursor" }
)

-- Diagnostic keymaps
bind("n", "[d", function()
  vim.diagnostic.goto_prev({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Go to previous diagnostic" })

bind("n", "]d", function()
  vim.diagnostic.goto_next({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Go to next diagnostic" })

bind("n", "<leader>de", function()
  vim.diagnostic.open_float({
    border = "rounded",
  })
end, { desc = "[D]iagnostic: [E]rror messages" })

bind("n", "<leader>dq", function()
  vim.diagnostic.setloclist({
    border = "rounded",
  })
end, { desc = "[D]iagnostic: [Q]uickfix" })

bind("n", "<leader>dn", "<cmd>cnext<cr>zz", { desc = "[D]iagnostic: [N]ext quickfix item" })
bind("n", "<leader>dp", "<cmd>cprev<cr>zz", { desc = "[D]iagnostic: [P]revious quickfix item" })
