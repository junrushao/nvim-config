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

