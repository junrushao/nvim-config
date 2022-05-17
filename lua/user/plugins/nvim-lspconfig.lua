local lspconfig = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")
local lsp_installer_servers = require('nvim-lsp-installer.servers')
local PATH = require("user.path")

lsp_installer.settings{
  ui = {
    icons = {
      -- The list icon to use for installed servers.
      server_installed = "◍",
      -- The list icon to use for servers that are pending installation.
      server_pending = "◍",
      -- The list icon to use for servers that are not installed.
      server_uninstalled = "◍",
    },
    keymaps = {
      -- Keymap to expand a server in the UI
      toggle_server_expand = "<CR>",
      -- Keymap to install a server
      install_server = "i",
      -- Keymap to reinstall/update a server
      update_server = "u",
      -- Keymap to update all installed servers
      update_all_servers = "U",
      -- Keymap to uninstall a server
      uninstall_server = "X",
    },
  },
  -- The directory in which to install all servers.
  install_root_dir = require("nvim-lsp-installer.path").concat {
    vim.fn.stdpath "data", "lsp_servers"
  },
  pip = {
    -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
    -- and is not recommended.
    --
    -- Example: { "--proxy", "https://proxyserver" }
    install_args = {},
  },
  -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
  -- debugging issues with server installations.
  log_level = vim.log.levels.INFO,
  -- Limit for the maximum amount of servers to be installed at the same time. Once this limit is reached, any further
  -- servers that are requested to be installed will be put in a queue.
  max_concurrent_installers = 4,
}

-- When this particular server is ready (i.e. when installation is finished or the server is already installed),
-- this function will be invoked. Make sure not to use the "catch-all" lsp_installer.on_server_ready()
-- function to set up servers, to avoid doing setting up a server twice.

local setup_server = function(server_name, fn_setup)
  local server_available, server = lsp_installer_servers.get_server(server_name)
  if not server_available then
    return
  end
  require("user.plugins.nvim-cmp").setup_lsp(server_name)
  fn_setup(server)
  if not server:is_installed() then
    -- Queue the server to be installed.
    server:install()
  end
end

local function enable_format_on_save(client)
  if client.server_capabilities.document_formatting then
    require("user.general.options").augroup("LspFormatting", {
      {"BufWritePre", "<buffer>", "lua vim.lsp.buf.formatting_sync()"},
    }, "* <buffer>")
  end
end

setup_server("pyright", function(server)
  server:on_ready(function ()
    server:setup{}
    lspconfig.pyright.setup{
      on_attach = function(client, bufnr)
        enable_format_on_save(client)
        -- require 'illuminate'.on_attach(client)
      end,
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            typeCheckingMode = "off",
            autoImportCompletions = false,
            extraPath = {PATH.PYTHONPATH},
            -- autoSearchPaths = true,
            -- useLibraryCodeForTypes = true,
            diagnosticSeverityOverrides = {
              reportMissingImports = "none",
              reportMissingModuleSource = "none",
              reportUndefinedVariable = "none",
              reportUnusedVariable = "none",
            },
          },
        },
      }
    }
  end)
end)

setup_server("clangd", function(server)
  server:on_ready(function ()
    server:setup{}
    require("clangd_extensions").setup {
      server = {
        -- options to pass to nvim-lspconfig
        -- i.e. the arguments to require("lspconfig").clangd.setup({})
        on_attach = function(client, bufnr)
          enable_format_on_save(client)
          -- require 'illuminate'.on_attach(client)
        end,
        filetypes = {"c", "cpp", "h", "hpp"},
        capabilities = {offsetEncoding = 'utf-8'},
        cmd = {
          PATH.CLANGD,
          "--query-driver=/usr/bin/**/clang-*,/usr/local/opt/llvm/bin/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
          "--all-scopes-completion",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=never",
          "--inlay-hints",
          "-j=12",
          "--pch-storage=memory",
          -- "--header-insertion-decorators",
          -- "--limit-references=100",
          -- "--limit-results=100",
          -- "--clang-tidy-checks=*",
        }
      },
      extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- Whether to show hover actions inside the hover window
        -- This overrides the default hover handler
        hover_with_actions = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
          -- Only show inlay hints for the current line
          only_current_line = false,
          -- Event which triggers a refresh of the inlay hints.
          -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
          -- not that this may cause  higher CPU usage.
          -- This option is only respected when only_current_line and
          -- autoSetHints both are true.
          only_current_line_autocmd = "CursorHold",
          -- whether to show parameter hints with the inlay hints or not
          show_parameter_hints = true,
          -- whether to show variable name before type hints with the inlay hints or not
          show_variable_name = false,
          -- prefix for parameter hints
          parameter_hints_prefix = "<- ",
          -- prefix for all the other hints (type, chaining)
          other_hints_prefix = "=> ",
          -- whether to align to the length of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- whether to align to the extreme right or not
          right_align = false,
          -- padding from the right if right_align is true
          right_align_padding = 7,
          -- The color of the hints
          highlight = "Comment",
        },
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },
          kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
          },
          highlights = {
            detail = "Comment",
          },
        }
      }
    -- lspconfig.clangd.setup{
    -- }
  }
  end)
end)

require("user.plugins.which-key")
.register("n", {
  ["g"] = {
    name = "LSP",
    G = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration"},
    T = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition"},
    h = {"<cmd>lua vim.lsp.buf.hover()<CR>", "Hover"},
    s = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help"},
    R = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"},
    f = {"<cmd>lua vim.lsp.buf.formatting_sync()<CR>", "Format"},
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  },
})
