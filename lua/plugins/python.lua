local function get_pylsp()
  local conda_prefix = os.getenv("CONDA_PREFIX")
  if conda_prefix ~= nil then
    local path = conda_prefix .. "/bin/pylsp"
    if vim.fn.executable(path) then
      return path
    end
  end
  return "pylsp"
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          cmd = { get_pylsp() },
          settings = {
            pylsp = {
              plugins = {
                -- Disable most of the plugins
                autopep8 = { enabled = false },
                flake8 = { enabled = false },
                pyls_flake8 = { enabled = false },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                pydocstyle = { enabled = false },
                mccabe = { enabled = false },
                yapf = { enabled = false },
                -- Enabled ones
                pylint = { enabled = true },
                isort = { enabled = true, profile = "black" },
                mypy = { enabled = true, ignore_missing_imports = true, follow_imports = "skip", strict = false },
                jedi_completion = { enabled = true },
                jedi_definition = { enabled = true },
                jedi_hover = { enabled = true },
                jedi_references = { enabled = true },
                jedi_signature_help = { enabled = true },
                jedi_symbols = { enabled = true },
              },
            },
          },
        },
      },
      format_notify = true,
      format = { timeout_ms = 10000 },
    },
  },
}
