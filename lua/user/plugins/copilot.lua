vim.g.copilot_filetypes = {
  ["*"] = false,
  ['python'] = true,
  ['cpp'] = true,
  ['c'] = true,
  ['lua'] = true,
}

-- vim.cmd [[
--   imap <silent><script><expr> <C-A> copilot#Accept("\<CR>")
--   let g:copilot_no_tab_map = v:true
-- ]]

-- local M = {}
--
-- function M.setup()
--   vim.notify("Setting up Copilot","info", {title = "Environment"})
--   require("copilot").setup(
--   )
-- end
--
-- return M
