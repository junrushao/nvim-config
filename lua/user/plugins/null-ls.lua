local null_ls = require("null-ls")
local PATH = require("user.path")

null_ls.setup{
  debug = false,
  default_timeout = 2000,
  fallback_severity = vim.diagnostic.severity.HINT,
  on_attach = function(client)
    if client.supports_method("textDocument/formatting") then
      require("user.general.options").augroup("LspFormatting", {
        {"BufWritePre", "<buffer>", "lua vim.lsp.buf.format()"},
      }, "* <buffer>")
    end
  end,
  sources = {
    null_ls.builtins.diagnostics.cspell.with{
      filetypes = {"python", "h", "cc", "cpp", "hpp", "lua"},
      command = PATH.CSPELL,
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      args = function(params)
        return {
          "--language-id",
          params.ft,
          "--config",
          PATH.CSPELL_CONFIG,
          "stdin"
        }
      end,
    },
    null_ls.builtins.diagnostics.pylint.with{
      filetypes = {"python"},
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      command = PATH.PYLINT,
      args = function(params)
        if PATH.TVM_HOME ~= nil then 
          return {
            "$FILENAME", "-f", "json",
            "--rcfile=" .. PATH.TVM_HOME .. "/tests/lint/pylintrc",
            "--enable=undefined-variable,no-member,no-self-use,fixme,no-name-in-module,import-error,unsubscriptable-object,unbalanced-tuple-unpacking,undefined-variable,protected-access,consider-using-get",
            "--init-hook", "import sys; sys.path.insert(0, '" .. PATH.TVM_HOME .. "/python')",
          }
        else
          return {"$FILENAME", "-f", "json"}
        end
      end,
    },
    null_ls.builtins.diagnostics.mypy.with{
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      command = PATH.MYPY,
      args = function(params)
        return {
          "--check-untyped-defs",
          "--follow-imports", "skip",
          "--hide-error-codes", "--hide-error-context", "--no-color-output", "--show-column-numbers",
          "--show-error-codes", "--no-error-summary", "--no-pretty",
          "--shadow-file", params.bufname, params.temp_path, params.bufname,
        }
      end,
    },
    null_ls.builtins.formatting.black.with{
      filetypes = {"python"},
      command = PATH.BLACK,
      args = {"--quiet", "--fast", "-"},
    },
    null_ls.builtins.formatting.isort.with{
      filetypes = {"python"},
      command = PATH.ISORT,
      args = {"--stdout", "--profile", "black", "-"},
    },
  },
}

local M = {}

function M.cspell_new_word()
  local word = vim.fn.expand("<cword>")
  vim.ui.input({
    prompt = "[CSpell] Add new word: ",
    default = word,
  }, function (input)
    if input == nil then
      return
    end
    local f = io.open(PATH.CSPELL_DICT, "a")
    f:write(input .. "\n")
    f:close()
  end)
end

require("user.plugins.which-key")
.register("n", {
  ["g"] = {
    name = "LSP",
    C = {"<cmd>lua require('user.plugins.null-ls').cspell_new_word()<CR>", "Add the word under cursor to dictionary"},
  },
})

return M

