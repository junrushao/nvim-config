-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local function get_python_path()
  local conda_prefix = os.getenv("CONDA_PREFIX")
  if conda_prefix ~= nil then
    local python_path = conda_prefix .. "/bin/python3"
    if vim.fn.executable(python_path) then
      return python_path
    end
  end
  return nil
end

vim.g.python3_host_prog = get_python_path()

-- Line wrap
vim.opt.wrap = false -- Display long lines as just one line
vim.opt.whichwrap = "b,s,<,>,[,],h,l" -- <BS>, <Space> <Left>, <Right>, h, and l wrap around line breaks

-- Cursor position
-- vim.opt.cursorline = true -- Enable highlighting of the current line
-- vim.opt.cursorcolumn = true -- Enable highlighting of the current column
vim.opt.colorcolumn = "100" -- Highlight the column at 100 characters
