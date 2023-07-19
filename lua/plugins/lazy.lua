return {
  { "RRethy/vim-illuminate", enabled = false },
  {
    "olimorris/onedarkpro.nvim",
    priority = 10000, -- Ensure it loads first
    lazy = false,
    opts = {
      highlights = {
        MiniCursorword = { link = "Visual" },
        MiniCursorwordCurrent = { link = "Visual" },
        MatchParen = {
          bold = true,
          fg = "${yellow}",
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
    dependencies = {
      "onedarkpro.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader><space>", vim.lsp.buf.hover, desc = "Hover" },
      { "<leader>/", false },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(_) end,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false,
      },
      current_line_blame_formatter_opts = {
        relative_time = false,
      },
    },
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "q",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
      {
        "Q",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts["mapping"] = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Down>"] = { i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }) },
        ["<Up>"] = { i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }) },
        ["<M-Down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<M-Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>/",
        function()
          require("Comment.api").toggle.linewise()
        end,
        mode = "n",
        desc = "Linewise comment",
      },
      {
        "<leader>/",
        function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
          require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end,
        mode = "v",
        desc = "Linewise comment",
      },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    event = "VeryLazy",
    opts = {
      mappings = nil,
    },
    keys = {
      {
        "gl",
        function()
          local gl = package.loaded.gitlinker
          gl.get_buf_range_url("n")
        end,
        mode = "n",
        desc = "Get link to the current line in the git repo",
      },
      {
        "gl",
        function()
          local gl = package.loaded.gitlinker
          gl.get_buf_range_url("v")
        end,
        mode = "v",
        desc = "Get link to the current line in the git repo",
      },
    },
  },
  {
    "rmagatti/goto-preview",
    event = "VeryLazy",
    opts = {
      opacity = 30,
    },
    keys = {
      {
        "gg",
        "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
        mode = "n",
        desc = "Open a preview window for the definition",
      },
    },
  },
  {
    "echasnovski/mini.cursorword",
    version = "*",
    event = "VeryLazy",
    opts = function()
      vim.g.loaded_matchparen = true
      return {
        delay = 100,
      }
    end,
  },
  {
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
    event = "VeryLazy",
    init = function(_)
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
      return {}
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter", "kevinhwang91/promise-async" },
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
    },
  },
}
