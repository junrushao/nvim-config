local CONDA_PREFIX = os.getenv("CONDA_PREFIX")

function file_exists(name)
  local f = io.open(name,"r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end


local function get_conda_executable(relative_path, fallback)
  if CONDA_PREFIX ~= nil then
    local path = CONDA_PREFIX .. "/" .. relative_path
    if file_exists(path) then
      return path
    end
  end
  return fallback
end


return {
  PYLINT          = get_conda_executable("bin/pylint", "pylint"),
  BLACK           = get_conda_executable("bin/black", "black"),
  MYPY            = get_conda_executable("bin/mypy", "mypy"),
  ISORT           = get_conda_executable("bin/isort", "isort"),
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
