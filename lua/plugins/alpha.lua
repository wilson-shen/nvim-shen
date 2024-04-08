return {
  {
    "goolord/alpha-nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      local logo = {
        "                                                  ",
        "                                                  ",
        "                                                  ",
        "                                                  ",
        "                                                  ",
        " ██╗    ██╗██╗██╗     ███████╗ ██████╗ ███╗   ██╗ ",
        " ██║    ██║██║██║     ██╔════╝██╔═══██╗████╗  ██║ ",
        " ██║ █╗ ██║██║██║     ███████╗██║   ██║██╔██╗ ██║ ",
        " ██║███╗██║██║██║     ╚════██║██║   ██║██║╚██╗██║ ",
        " ╚███╔███╔╝██║███████╗███████║╚██████╔╝██║ ╚████║ ",
        "  ╚══╝╚══╝ ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝ ",
        "                                                  ",
        "                                                  ",
        "                                                  ",
        "                                                  ",
        "                                                  ",
        "                                                  ",
        "                                                  ",
        "                                                  ",
        "                                                  ",
        "                                                  ",
      }

      local buttonhl = function(shortcut, text, command)
        local button = dashboard.button(shortcut, text, command)
        button.opts.hl = "Constant"
        button.opts.hl_shortcut = "Tag"
        return button
      end

      local function footer()
        local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
        local version = vim.version()

        local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

        return datetime .. nvim_version_info
      end

      dashboard.section.header.val = logo

      dashboard.section.buttons.val = {
        buttonhl("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
        buttonhl("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
        buttonhl("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
        buttonhl("q", " " .. " Quit", "<cmd> qa <cr>"),
      }

      dashboard.section.footer.val = footer()

      dashboard.section.header.opts.hl = "@comment.documentation.lua"
      dashboard.section.footer.opts.hl = "String"

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)

      vim.cmd([[ Alpha ]]);
    end
  }
}
