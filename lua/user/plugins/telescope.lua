local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    selection_caret = " ",
    width = 0.8,
    border = false,
    show_line = false,
    prompt_prefix = '🔍  ',
    prompt_title = '',
    results_title = '',
    preview_title = '',
    borderchars = {
      prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
      results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
      preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
    },
    path_display = {
      truncate = 10,
    },
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },
      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg", "mp4", "webm", "pdf"},
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
    file_browser = {
      -- theme = "ivy",
      -- require("telescope.themes").get_dropdown {
      --   previewer = false,
      --   -- even more opts
      -- },
      -- mappings = {
      --   ["i"] = {
      --     -- your custom insert mode mappings
      --   },
      --   ["n"] = {
      --     -- your custom normal mode mappings
      --   },
      -- },
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      },
    },
  },
  defaults = {
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
  },
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('media_files')
require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("session-lens")
-- require("telescope").load_extension("frecency")

local M = {}

function M.find_files()
  require('telescope.builtin').find_files{
    winblend = 20,
    hidden = true,
    find_command = {"rg", "--ignore", "--hidden", "--files"},
    selection_caret = " ",
    width = 0.8,
    border = false,
    show_line = false,
    prompt_prefix = '🔍  ',
    prompt_title = '',
    results_title = '',
    preview_title = '',
    borderchars = {
      prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
      results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
      preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
    },
  }
end

function M.live_grep()
  require('telescope.builtin').live_grep{
    winblend = 20,
    hidden = true,
    find_command = {"rg", "--ignore", "--hidden", "--files"},
    selection_caret = " ",
    width = 0.8,
    border = false,
    show_line = false,
    prompt_prefix = '🔍  ',
    prompt_title = '',
    results_title = '',
    preview_title = '',
    borderchars = {
      prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
      results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
      preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
    },
  }
end

function M.file_browser()
  require('telescope').extensions.file_browser.file_browser{
    winblend = 20,
    hidden = true,
    selection_caret = " ",
    width = 0.8,
    border = false,
    show_line = false,
    prompt_prefix = '🔍  ',
    prompt_title = '',
    results_title = '',
    preview_title = '',
    borderchars = {
      prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
      results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
      preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
    },
  }
end

require("user.plugins.which-key")
.register("n", {
  ["<Leader>f"] = {
    name = "Telescope",
    f = {"<cmd>lua require('user.plugins.telescope').find_files()<cr>", "Find files"},
    g = {"<cmd>lua require('user.plugins.telescope').live_grep()<cr>", "Grep"},
    b = {"<cmd>lua require('user.plugins.telescope').file_browser()<cr>", "File browser"},
  },
})

return M
