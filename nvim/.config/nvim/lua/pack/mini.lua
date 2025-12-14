vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.completion" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/nvim-mini/mini.snippets" },
	{ src = "https://github.com/nvim-mini/mini.trailspace" },
})


-- MINI TRAILSPACE
local trailspace = require("mini.trailspace")
trailspace.setup()
vim.keymap.set("n", "<leader>cw", function()
	trailspace.trim()
end)

-- MINI SURROUND
require("mini.surround").setup({
	mappings = {
		add = "sa",     -- add surrounding
		delete = "sd",  -- delete surrounding
		replace = "sr", -- replace surrounding
	},
})
vim.api.nvim_set_keymap(
	"v",
	"st",
	[[:<C-U>lua MiniSurroundAddTag()<CR>]],
	{ noremap = true, silent = true }
)
vim.keymap.set("n", "dst", "<cmd>lua MiniSurroundDeleteTag()<CR>", { noremap = true, silent = true })

-- Lua function to wrap visual selection in a tag
_G.MiniSurroundAddTag = function()
	local tag = vim.fn.input("Tag name: ")
	if tag == "" then
		return
	end

	-- Get visual selection range
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_line, end_line = start_pos[2], end_pos[2]

	-- Get the selected lines
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

	-- Determine indentation of first line
	local indent = lines[1]:match("^%s*") or ""

	-- Indent inner lines by two spaces (adjust as you like)
	for i = 1, #lines do
		lines[i] = "  " .. lines[i]
	end

	-- Wrap with opening and closing tags
	table.insert(lines, 1, indent .. "<" .. tag .. ">")
	table.insert(lines, indent .. "</" .. tag .. ">")

	-- Replace buffer lines
	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end

-- DELETE SURROUND TAG

_G.MiniSurroundDeleteTag = function()
	---@diagnostic disable-next-line: deprecated
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	local line = lines[row]

	-- Match <tag ...>content</tag> on the same line
	local new_line, count = line:gsub("<(%w+)[^>]*>(.-)</%1>", "%2")
	if count > 0 then
		lines[row] = new_line
		vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
		return
	end

	-- Fallback: multi-line tag (opening tag above, closing tag below)
	local start_row, start_col, tag_name, open_tag_end
	for r = row, 1, -1 do
		local s, e, name = lines[r]:find("<(%w+)[^>]*>")
		if s then
			start_row, start_col, open_tag_end, tag_name = r, s, e, name
			break
		end
	end
	if not start_row then
		return print("No opening tag found")
	end

	local end_row, end_col
	for r = row, #lines do
		local s, e = lines[r]:find("</" .. tag_name .. ">")
		if s then
			end_row, end_col = r, e
			break
		end
	end
	if not end_row then
		return print("No closing tag found")
	end

	-- Remove opening tag
	lines[start_row] = lines[start_row]:sub(1, start_col - 1) .. lines[start_row]:sub(open_tag_end + 1)
	-- Remove closing tag
	lines[end_row] = lines[end_row]:sub(1, end_col - #tag_name - 3) .. lines[end_row]:sub(end_col + 1)

	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end
