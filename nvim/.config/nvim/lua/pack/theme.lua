vim.pack.add({"https://github.com/blazkowolf/gruber-darker.nvim"})
vim.cmd[[colorscheme gruber-darker]]

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#969696" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#969696" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#96a6c8" })

vim.api.nvim_set_hl(0, "Cursor", { fg = "#96a6c8" })
