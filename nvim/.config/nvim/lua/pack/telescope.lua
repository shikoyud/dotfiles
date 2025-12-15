vim.pack.add({
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim",            tag = "v0.2.0" }
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		path_display = { "smart" },
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		find_files = {
			file_ignore_patterns = { 'node_modules', '.git', '.venv'},
			hidden = true
		},
		live_grep = {
			file_ignore_patterns = { 'node_modules', '.git', '.venv'},
			additional_args = function(_)
				return { "--hidden" }
			end
		}
	},
	extensions = {
		fzf = {},
	},
})

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fG", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fc", function()
	builtin.find_files({ cwd = "~/.config/nvim" })
end)

telescope.load_extension("fzf")
