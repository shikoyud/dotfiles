vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "harpoon2"
  },
})
local harpoon = require("harpoon")

harpoon:setup({
  global_settings = {
    save_on_toggle = true,
    save_on_change = true,
  },
})

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
