vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" }
})

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c", "css", "html", "java", "javascript", "json",
    "lua", "markdown", "python", "rust", "svelte", "typescript",
  },
  auto_install = false,
  highlight = {
    enable = true,
    disable = { "c", "rust" },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
