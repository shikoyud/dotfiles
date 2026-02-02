vim.pack.add({
  { src = "https://github.com/Wansmer/treesj" }
})

vim.keymap.set("n", "<leader>sj", require('treesj').toggle)
