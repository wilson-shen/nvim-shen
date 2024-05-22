local uname = vim.loop.os_uname()

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function(event)
        local title = "Neovim"

        if event.file ~= "" then
            title = vim.fs.basename(event.file)
        end

        if uname.sysname == 'Linux' and uname.release:lower():find 'microsoft' then
            vim.fn.system({ "powershell.exe", "wezterm", "cli", "set-tab-title", title })
        else
            vim.fn.system({ "wezterm", "cli", "set-tab-title", title })
        end
    end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
    callback = function()
        if uname.sysname == 'Linux' and uname.release:lower():find 'microsoft' then
            vim.fn.system({ "powershell.exe", "wezterm", "cli", "set-tab-title", "" })
        else
            vim.fn.system({ "wezterm", "cli", "set-tab-title", "" })
        end
    end,
})
