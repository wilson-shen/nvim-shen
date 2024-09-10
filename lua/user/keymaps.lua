local bind = function(mode, keys, func, desc)
  vim.keymap.set(mode, keys, func, { desc = desc, noremap = true, silent = true })
end

-- Disable F1
bind({ "n", "i", "v" }, "<F1>", "<nop>", "Disable F1 help, use :help")

-- Rebind record macro
bind("n", "Q", "q", "Record macro")
bind("n", "q", "<nop>", "Disable record macro, use Q")

-- Clear hightlignt after search is highlighted
bind("n", "<Esc>", "<cmd>nohlsearch<cr>", "Disable highlight search")

-- Extra Delete, Yank, Paste config
bind("x", "<leader>p", [["_dP]], "Paste without overwriting (visual mode)")
bind({ "n", "v" }, "<leader>y", [["+y]], "Yank to system clipboard")
bind("n", "<leader>Y", [["+Y]], "Yank to system clipboard (linewise)")
bind({ "n", "v" }, "<leader>d", [["_d]], "Delete to black hole register")

-- Neovim windows navigation
bind("n", "<M-v>", "<C-w><C-v>", "Create vertical window")
bind("n", "<C-h>", "<C-w><C-h>", "Move focus to the left window")
bind("n", "<C-l>", "<C-w><C-l>", "Move focus to the right window")
bind("n", "<C-j>", "<C-w><C-j>", "Move focus to the lower window")
bind("n", "<C-k>", "<C-w><C-k>", "Move focus to the upper window")

-- Navigate in Neovim
bind("n", "H", "^", "Go to first character in current line")
bind("n", "L", "$", "Go to last character in current line")
bind("n", "J", "mzJ`z", "Keep cursor centered after moving down")
bind("n", "<C-d>", "<C-d>zz", "Scroll half-page down and center")
bind("n", "<C-u>", "<C-u>zz", "Scroll half-page up and center")
bind("n", "n", "nzzzv", "Search next, keep cursor centered")
bind("n", "N", "Nzzzv", "Search previous, keep cursor centered")
bind("n", "<leader>k", "<cmd>lnext<cr>zz", "Next location item")
bind("n", "<leader>j", "<cmd>lprev<cr>zz", "Previous location item")
bind("n", "{", "{zz", "")
bind("n", "}", "}zz", "")
bind("n", "G", "Gzz", "")
bind("n", "<C-i>", "<C-i>zz", "")
bind("n", "<C-o>", "<C-o>zz", "")
bind("n", "%", "%zz", "")
bind("n", "*", "*zz", "")
bind("n", "#", "#zz", "")

-- Move lines
bind("v", "J", ":m '>+1<cr>gv=gv", "Move line(s) down")
bind("v", "K", ":m '<-2<cr>gv=gv", "Move line(s) up")

-- Search and replace
bind("n", "<leader>rp", [[:%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>]], "[R]e[p]lace")

-- Diagnostic keymaps
bind("n", "[d", function()
  vim.diagnostic.goto_prev({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, "Go to previous diagnostic")

bind("n", "]d", function()
  vim.diagnostic.goto_next({})
  vim.api.nvim_feedkeys("zz", "n", false)
end, "Go to next diagnostic")

bind("n", "<leader>dm", function()
  vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
end, "[D]iagnostics: [M]essage")

bind("n", "<leader>dl", function()
  vim.diagnostic.setloclist()
end, "[D]iagnostic: Set [L]ocation list")

bind("n", "<leader>di", function()
  vim.diagnostic.config({
    virtual_text = not vim.diagnostic.config().virtual_text,
  })
end, "[D]iagnostic: Toggle [I]nline message")
