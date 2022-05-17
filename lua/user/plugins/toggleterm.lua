local toggleterm = require("toggleterm")

toggleterm.setup{
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = false,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 20,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

local M = {}

function M.set_terminal_keymaps()
  local function bind_key(key, cmd)
    vim.api.nvim_buf_set_keymap(0, "t", key, cmd, {noremap = true})
  end
  bind_key('<esc>', '<C-\\><C-n>')
  bind_key('<Leader><Left>' , '<C-\\><C-n><C-W>h')
  bind_key('<Leader><Right>', '<C-\\><C-n><C-W>l')
  bind_key('<Leader><Up>'   , '<C-\\><C-n><C-W>k')
  bind_key('<Leader><Down>' , '<C-\\><C-n><C-W>j')
end

function M.create()
  local Terminal = require("toggleterm.terminal").Terminal
  return Terminal:new({
    cmd = nil,
    hidden = true,
    on_open = function(term)
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
  })
end

M.terminals = {
  M.create(), -- 1
  M.create(), -- 2
  M.create(), -- 3
  M.create(), -- 4
  M.create(), -- 5
  M.create(), -- 6
  M.create(), -- 7
  M.create(), -- 8
  M.create(), -- 9
  M.create(), -- 10
}

function M.toggle(id, direction)
  M.terminals[id]:toggle(nil, direction)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
require("user.general.options").augroup("toggleterm_set_terminal_keymaps", {
    {"TermOpen", "term://* lua require('user.plugins.toggleterm').set_terminal_keymaps()"},
})

require("user.plugins.which-key")
.register("n", {
  ["<Leader>t"] = {
    name = "Toggle Terminal",
    ["1"] = {"<cmd>lua require('user.plugins.toggleterm').toggle(1 , 'float')<cr>", "Toggle Terminal 1"},
    ["2"] = {"<cmd>lua require('user.plugins.toggleterm').toggle(2 , 'float')<cr>", "Toggle Terminal 2"},
    ["3"] = {"<cmd>lua require('user.plugins.toggleterm').toggle(3 , 'float')<cr>", "Toggle Terminal 3"},
    ["4"] = {"<cmd>lua require('user.plugins.toggleterm').toggle(4 , 'float')<cr>", "Toggle Terminal 4"},
    ["5"] = {"<cmd>lua require('user.plugins.toggleterm').toggle(5 , 'float')<cr>", "Toggle Terminal 5"},
    ["6"] = {"<cmd>lua require('user.plugins.toggleterm').toggle(6 , 'float')<cr>", "Toggle Terminal 6"},
    ["7"] = {"<cmd>lua require('user.plugins.toggleterm').toggle(7 , 'float')<cr>", "Toggle Terminal 7"},
    ["8"] = {"<cmd>lua require('user.plugins.toggleterm').toggle(8 , 'float')<cr>", "Toggle Terminal 8"},
    ["9"] = {"<cmd>lua require('user.plugins.toggleterm').toggle(9 , 'float')<cr>", "Toggle Terminal 9"},
    ["0"] = {"<cmd>lua require('user.plugins.toggleterm').toggle(10, 'float')<cr>", "Toggle Terminal 10"},
  },
})

return M
