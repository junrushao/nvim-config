require("user.plugins.which-key")
.register("n", {
  ["g"] = {
    name = "LSP",
    A = {"<cmd>CodeActionMenu<CR>", "Code Action"},
  },
})
