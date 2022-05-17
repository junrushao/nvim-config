vim.g.Illuminate_delay = 5
vim.cmd [[ hi def link LspReferenceText CursorLine ]]
vim.cmd [[ hi def link LspReferenceWrite CursorLine ]]
vim.cmd [[ hi def link LspReferenceRead CursorLine ]]

vim.cmd('augroup illuminate_augroup')
vim.cmd('autocmd!')
vim.cmd([[autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline]])
vim.cmd('augroup END')
