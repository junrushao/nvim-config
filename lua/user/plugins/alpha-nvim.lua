local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local fortune = require("alpha.fortune")

-- Set header
dashboard.section.header.val = {
  "███╗░░░███╗███████╗░█████╗░░██╗░░░░░░░██╗    ██╗░░░██╗██╗███╗░░░███╗",
  "████╗░████║██╔════╝██╔══██╗░██║░░██╗░░██║    ██║░░░██║██║████╗░████║",
  "██╔████╔██║█████╗░░██║░░██║░╚██╗████╗██╔╝    ╚██╗░██╔╝██║██╔████╔██║",
  "██║╚██╔╝██║██╔══╝░░██║░░██║░░████╔═████║░    ░╚████╔╝░██║██║╚██╔╝██║",
  "██║░╚═╝░██║███████╗╚█████╔╝░░╚██╔╝░╚██╔╝░    ░░╚██╔╝░░██║██║░╚═╝░██║",
  "╚═╝░░░░░╚═╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝░░    ░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝",
}

-- Set menu
dashboard.section.buttons.val = {
  dashboard.button("e", "  > Find session" , ":lua require('session-lens').search_session()<CR>"),
  dashboard.button("f", "  > Find file"    , ":lua require('user.plugins.telescope').find_files()<CR>"),
  dashboard.button("r", "  > Recent"       , ":Telescope oldfiles<CR>"),
  dashboard.button("c", "  > Config"       , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
  dashboard.button("q", "  > Quit"         , ":qa<CR>"),
}

dashboard.section.footer.val = fortune()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
