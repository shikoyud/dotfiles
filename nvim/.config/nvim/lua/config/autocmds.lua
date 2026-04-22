vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
  callback = function()
    if vim.fn.win_gettype() == "command" then
      vim.keymap.set( "n", "<Esc>", "<C-c><C-c>", { noremap = true, buffer = true, silent = true })
    end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local groups = {
      "Normal",
      "NormalNC",
      "StatusLine",
      "StatusLineNC",
      "WinBar",
      "WinBarNC",
    }

    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end
  end,
})

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then return end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function() io.write("\027]111\027\\") end,
})

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'svelte' },
--   callback = function() vim.treesitter.start() end,
-- })
