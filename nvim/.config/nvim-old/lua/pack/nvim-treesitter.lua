vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", branch = "main" }
})

vim.g.no_plugin_maps = true
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
