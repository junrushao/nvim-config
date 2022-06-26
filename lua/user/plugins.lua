-- Automatically install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print('Installing packer close and reopen Neovim...')
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
})

-- Install your plugins here
return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- Misc
  use "folke/which-key.nvim"
  use "famiu/bufdelete.nvim"
  use 'numToStr/Comment.nvim'
  use "lukas-reineke/indent-blankline.nvim"
  use "RRethy/vim-illuminate"
  use 'windwp/nvim-autopairs'
  use 'rmagatti/auto-session'
  use 'rcarriga/nvim-notify'

  -- Theme & UI
  use 'navarasu/onedark.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'akinsho/bufferline.nvim'
  use "petertriho/nvim-scrollbar"
  use "goolord/alpha-nvim"
  use "akinsho/toggleterm.nvim"
  use {"SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter"}
  use {'VonHeikemen/searchbox.nvim', requires = {'MunifTanjim/nui.nvim'}}

  -- Git integration
  use "lewis6991/gitsigns.nvim"
  use 'sindrets/diffview.nvim'
  use "ruifm/gitlinker.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"
  use {"nvim-telescope/telescope-frecency.nvim", requires = {"tami5/sqlite.lua"}}
  use "rmagatti/session-lens"
  -- use "tom-anders/telescope-vim-bookmarks.nvim"

  -- LSP & Parser
  use {'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'}
  use "folke/trouble.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use 'kosayoda/nvim-lightbulb'
  use "ray-x/lsp_signature.nvim"
  use "rmagatti/goto-preview"
  use {'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'onsails/lspkind-nvim'
  use "p00f/clangd_extensions.nvim"
  use 'simrat39/symbols-outline.nvim'

  -- Auto-completion
  use 'hrsh7th/nvim-cmp'
  use 'github/copilot.vim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-vsnip'
  -- use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/vim-vsnip'
  use "rafamadriz/friendly-snippets"
  -- use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
  require("user.general.options").augroup("packer", {
    {"BufWritePost", "plugins.lua", "source <afile> | PackerSync"},
  })
end)

