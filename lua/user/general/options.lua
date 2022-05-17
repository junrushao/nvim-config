local options = {
  -- Line wrap
  wrap = false,                     -- Display long lines as just one line
  whichwrap = 'b,s,<,>,[,],h,l',    -- <BS>, <Space> <Left>, <Right>, h, and l wrap around line breaks
  -- Encoding
  encoding = "utf-8",               -- The encoding displayed
  fileencoding = "utf-8",           -- The encoding written to file
  -- Indents and tab
  shiftwidth = 2,                   -- Change the number of space characters inserted for indentation
  shiftround = true,                -- When shifting lines, round the indentation to the nearest multiple of “shiftwidth.”
  tabstop = 2,                      -- Insert 2 spaces for a tab
  softtabstop = 2,
  smarttab = true,                  -- Makes tabbing smarter will realize you have 2 vs 4
  expandtab = true,                 -- Converts tabs to spaces
  smartindent = true,               -- Makes indenting smart
  autoindent = true,                -- Good auto indent
  -- Cursor position
  cursorline = true,                -- Enable highlighting of the current line
  cursorcolumn = true,              -- Enable highlighting of the current column
  colorcolumn = "100",              -- Highlight the column at 100 characters
  -- Search
  ignorecase = true,                -- ignore case in search patterns
  smartcase = true,                 -- override ignorecase if search pattern has capital letters
  showmatch = true,                 -- highlight matching parentheses/brackets
  hlsearch = true,                  -- highlight search results
  incsearch = true,                 -- show matches while typing pattern
  -- Backup file
  backup = false,                   -- no backup file
  writebackup = false,              -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  swapfile = false,                 -- no swap file
  undofile = true,                  -- enable persistent undo
  autoread = true,                  -- auto load when modified by another program
  -- Theme
  background = "dark",              -- background color
  termguicolors = true,
  guifont = "monospace:h17",        -- the font used in graphical neovim applications
  cmdheight = 2,                    -- More space for displaying messages
  showmode = false,                 -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                  -- always show tabs
  pumblend = 20,
  -- Line number
  number = true,                    -- set numbered lines
  relativenumber = true,            -- set relative numbered lines
  numberwidth = 4,                  -- set number column width to 4
  signcolumn = "yes",               -- always show the sign column, otherwise it would shift the text each time
  -- Render whitespace
  list = true,
  listchars = "space:·",
  -- Completion
  completeopt = {                   -- mostly just for cmp
    "menu",
    "menuone",
    "noselect",
    "noinsert",
  },
  timeoutlen = 100,                 -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 300,                 -- faster completion (4000ms default)
  -- Folding
  foldmethod = "expr",              -- fold by indentation
  foldlevel = 1000,                 -- default fold level
  -- foldcolumn = "5",                 -- fold columns
  foldexpr = 'nvim_treesitter#foldexpr()',
  -- Misc
  mouse = "a",                      -- Enable your mouse
  spell = false,                    -- Turn off Vim's spell as it highlights the same words.
  clipboard = "unnamedplus",        -- allows neovim to access the system clipboard
  splitbelow = true,                -- Horizontal splits will automatically be below
  splitright = true,                -- Vertical splits will automatically be to the right
  conceallevel = 0,                 -- So that I can see `` in markdown files
  sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

  -- https://www.shortcutfoo.com/blog/top-50-vim-configuration-options/
  -- set pumheight=30                        " Makes popup menu smaller
  -- set t_Co=256                            " Support 256 colors
  -- set laststatus=0                        " Always display the status line
  -- "set autochdir                           " Your working directory will always be the same as your working directory
  -- "set scrolloff=10                       " keep at least x lines above/below cursor if possible
  -- vim.o.shortmess = vim.o.shortmess .. 'c' " Dont' pass messages to |ins-completin menu|
}

vim.opt.iskeyword:append("-")
vim.opt.formatoptions:remove("cro")
vim.opt.formatoptions:append("j")
for k, v in pairs(options) do
  vim.opt[k] = v
end

local M = {}

function M.augroup(name, definition, suffix)
  vim.cmd('augroup '..name)
  if suffix == nil then
    vim.cmd('autocmd!')
  else
    vim.cmd("autocmd! " .. suffix)
  end
  for _, def in ipairs(definition) do
    vim.cmd(table.concat(vim.tbl_flatten{'autocmd', def}, ' '))
  end
  vim.cmd('augroup END')
end

M.augroup("makefile_no_expandtab", {
  {"FileType", "make", "set noexpandtab"},
})

M.augroup("switch_line_number_relative", {
  {"BufEnter,FocusGained,InsertLeave,WinEnter", "*", "if &nu && mode() != \"i\" | set rnu   | endif"},
  {"BufLeave,FocusLost,InsertEnter,WinLeave"  , "*", "if &nu                    | set nornu | endif"},
})

M.augroup("jump_to_last_position", {
  {"BufReadPost", "*", [[ if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]},
})

return M
