vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
  callback = function()
    if vim.fn.win_gettype() == "command" then
      vim.keymap.set( "n", "<Esc>", "<C-c><Esc>", { noremap = true, buffer = true, silent = true })
    end
  end,
})

