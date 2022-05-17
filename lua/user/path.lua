local CONDA_PATH_PREFIX = "/root/miniconda/envs/python38"

return {
  PYLINT          = CONDA_PATH_PREFIX .. "/bin/pylint",
  BLACK           = CONDA_PATH_PREFIX .. "/bin/black",
  MYPY            = CONDA_PATH_PREFIX .. "/bin/mypy",
  ISORT           = CONDA_PATH_PREFIX .. "/bin/isort",
  CLANGD          = "clangd-14",
  CSPELL          = "cspell",
  CSPELL_DICT     = vim.fn.stdpath("config") .. "/cspell/dict.txt",
  CSPELL_CONFIG   = vim.fn.stdpath("config") .. "/cspell/cspell.json",
  TVM_HOME        = os.getenv("TVM_HOME"),
  PYTHONPATH      = os.getenv("PYTHONPATH") or "",
  AUTO_SESSION    = {
    "~/Projects/tvm-dev",
    "~/Projects/tvm-stable",
    "~/Projects/relax-dev",
    "~/.config/nvim",
  },
}
