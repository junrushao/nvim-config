gps = require("user.plugins.nvim-gps")

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = {left = "", right = ""},
    section_separators = {left = "", right = ""},
    disabled_filetypes = {"alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {gps.get_location, cond = gps.is_available},
    },
    lualine_x = {
      {
        'filename',
        file_status = true,   -- Displays file status (readonly status, modified status)
        path = 1,             -- 0: Just the filename
                              -- 1: Relative path
                              -- 2: Absolute path
                              -- 3: Absolute path, with tilde as the home directory
        shorting_target = 60, -- Shortens path to leave 60 spaces in the window
        symbols = {
          modified = '[+]',      -- Text to show when the file is modified.
          readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
        },
      },
    },
    lualine_y = {'filetype'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

