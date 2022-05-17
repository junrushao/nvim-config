-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Set leader key
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("user.plugins.which-key")
.register("n", {
  -- Window
  ["<Leader>-"] = {"<C-W>s", "Window: horizontal split"},
  ["<Leader>\\"] = {"<C-W>v", "Window: vertical split"},
  ["<Leader><Up>"] = {"<C-W>k", "Window: navigate up"},
  ["<Leader><Down>"] = {"<C-W>j", "Window: navigate down"},
  ["<Leader><Left>"] = {"<C-W>h", "Window: navigate left"},
  ["<Leader><Right>"] = {"<C-W>l", "Window: navigate right"},
  -- Search
  ["<Leader>s"] = {"<cmd>nohlsearch<cr>", "Clear highlight"},
  -- Packer
  ["<Leader>p"] = {
    name = "Packer",
    c = {"<cmd>PackerCompile<cr>", "Compile"},
    i = {"<cmd>PackerInstall<cr>", "Install"},
    s = {"<cmd>PackerSync<cr>", "Sync"},
    S = {"<cmd>PackerStatus<cr>", "Status"},
    u = {"<cmd>PackerUpdate<cr>", "Update"},
  },
})
.register("v", {
  -- Indent
  ["<"] = {"<gv", "Convenient de-indent"},
  [">"] = {">gv", "Convenient dindent"},
})

-- -- Shorten function name
-- local opts = { noremap = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap

-- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], opts)

-- -- vim.cmd[[nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]]
-- -- vim.cmd[[nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]]
-- -- keymap("n", "c*", [[/\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]], opts)
-- -- keymap("n", "c#", [[?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]], opts)

-- keymap("n", "<F7>", "<cmd>TSHighlightCapturesUnderCursor<cr>", opts)
-- keymap("n", "<F8>", "<cmd>TSPlaygroundToggle<cr>", opts)
-- keymap("n", "<F11>", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- keymap("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- keymap("n", "<C-t>", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opts)
-- keymap("n", "<TAB>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

-- keymap("n", "<F4>", "<cmd>Telescope resume<cr>", opts)
-- keymap("n", "<F5>", "<cmd>Telescope commands<CR>", opts)
-- keymap(
--   "n",
--   "<C-p>",
--   "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
--   opts
-- )

