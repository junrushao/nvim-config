require("user.general.options")
require("user.plugins")
require("user.plugins.which-key")
require("user.general.keymap")
require("user.general.theme")

-- Misc
-- Ignored which-key
-- Ignored bufdelete
require("user.plugins.comment")
require("user.plugins.indent-blankline")
require("user.plugins.vim-illuminate")
require("user.plugins.nvim-autopairs")
require("user.plugins.resize-window") -- an extra plugin
require("user.plugins.auto-session") -- an extra plugin

-- Theme & UI
-- Ignored onedark
-- Ignored nvim-web-devicons
require("user.plugins.lualine")
require("user.plugins.nvim-tree")
require("user.plugins.bufferline")
require("user.plugins.nvim-scrollbar")
require("user.plugins.alpha-nvim")
require("user.plugins.toggleterm")

-- Git Integration
require("user.plugins.gitsigns")
require("user.plugins.diffview")
require("user.plugins.gitlinker")

-- Telescope
require("user.plugins.telescope")

-- LSP & Parser
require("user.plugins.nvim-lspconfig")
require("user.plugins.trouble")
require("user.plugins.null-ls")
require("user.plugins.nvim-lightbulb")
require("user.plugins.lsp-signature")
require("user.plugins.goto-preview")
require("user.plugins.nvim-code-action-menu")
require("user.plugins.nvim-treesitter")
require("user.plugins.lspkind-nvim")
-- Ignored clangd_extensions

-- Auto-completion
require("user.plugins.nvim-cmp")
require("user.plugins.copilot")

-- require("user.plugins.symbols-outline")
-- require("user.plugins.sidebar")
