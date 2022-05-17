require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = false,
  space_char_blankline = " ",
}

vim.g.indent_blankline_filetype_exclude = {
  "lspinfo",
  "packer",
  "checkhealth",
  "help",
  "alpha",
  "",
}

