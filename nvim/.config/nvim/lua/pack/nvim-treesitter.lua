vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" }
})

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", branch = "main" }
})

-- require("nvim-treesitter").setup({
--   ensure_installed = {
--     "c", "css", "html", "java", "javascript", "json",
--     "lua", "markdown", "python", "rust", "svelte", "typescript", "tsx"
--   },
--   auto_install = false,
--   highlight = {
--     enable = true,
--     disable = { "c", "rust" },
--     additional_vim_regex_highlighting = false,
--   },
--   indent = {
--     enable = true,
--   },
-- })

vim.g.no_plugin_maps = true
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
