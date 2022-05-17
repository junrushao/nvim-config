-- local sidebar = require("sidebar-nvim").setup({
--   disable_default_keybindings = 0,
--   bindings = nil,
--   open = true,
--   side = "left",
--   initial_width = 35,
--   hide_statusline = false,
--   update_interval = 1000,
--   sections = {"git", "files", "diagnostics", "symbols"},
--   section_separator = {"", "-----", ""},
--   containers = {
--       attach_shell = "/bin/sh", show_all = true, interval = 5000,
--   },
--   datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
--   todos = { ignored_paths = { "~" } },
--   disable_closing_prompt = true,
-- })


-- local M = {}

-- function M.symbol()
--   opt = {
--     sections = {"symbols"},
--   }
--   require("sidebar-nvim").setup(opt)
--   require("sidebar-nvim").toggle()
--   require("sidebar-nvim").toggle()
--   return M
-- end

-- return M
