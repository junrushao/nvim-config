require("user.plugins.which-key")
.register("n", {
  ["g"] = {
    name = "LSP",
    a = {"<cmd>CodeActionMenu<CR>", "Code Action"},
  },
})
