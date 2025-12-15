vim.pack.add({
	{ src = "https://github.com/roobert/tailwindcss-colorizer-cmp.nvim" },
	{ src = "https://github.com/onsails/lspkind.nvim" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/FelipeLema/cmp-async-path" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
})
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local colorizer = require("tailwindcss-colorizer-cmp").formatter

local lsp_kinds = { Class = " ", Color = " ", Constant = " ", Constructor = " ", Enum = " ", EnumMember = " ", Event =
" ", Field = " ", File = " ", Folder = " ", Function = " ", Interface = " ", Keyword = " ", Method = " ", Module =
" ", Operator = " ", Property = " ", Reference = " ", Snippet = " ", Struct = " ", Text = " ", TypeParameter =
" ", Unit = " ", Value = " ", Variable = " ", }

cmp.setup.cmdline(':', {
    sources = {
        { name = 'path' },
        { name = 'cmdline' }
    }
})
cmp.setup.cmdline('q:', {
    sources = {
        { name = 'path' },
        { name = 'cmdline' }
    }
})

cmp.setup({
	enabled = function()
		local type = vim.fn.win_gettype()
		return type ~= "command"
	end,
	experimental = {
		ghost_text = false,
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end
	},
	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			scrollbar = false,
		},
		completion = {
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		},
	},
	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<CR>"]  = cmp.mapping.confirm({select = true, behavior = cmp.ConfirmBehavior.Replace}),
---@diagnostic disable-next-line: unused-local
		["<Tab>"]  = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({select = true, behavior = cmp.ConfirmBehavior.Replace})
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				local key = vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
				vim.api.nvim_feedkeys(key, "nt", true)
			end
		end, {"i", "s"})
		-- ["<Tab>"]  = cmp.mapping.confirm({select = true, behavior = cmp.ConfirmBehavior.Replace}),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "tailwindcss-colorizer-cmp" },
	}),
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = string.format("%s %s", lsp_kinds[vim_item.kind] or "", vim_item.kind)
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[LaTeX]",
			})[entry.source.name]

			vim_item = lspkind.cmp_format({
				maxwidth = 25,
				ellipsis_char = "...",
			})(entry, vim_item)

			if entry.source.name == "nvim_lsp" then
				vim_item = colorizer(entry, vim_item)
			end
			return vim_item
		end,
	}
})

local config = require("cmp.config")
local toggle_ghost_text = function()
	if vim.api.nvim_get_mode().mode ~= "i" then
		return
	end

	local cursor_column = vim.fn.col(".")
	local current_line_contents = vim.fn.getline(".")
	local character_after_cursor = current_line_contents:sub(cursor_column, cursor_column)

	local should_enable_ghost_text = character_after_cursor == ""
			or vim.fn.match(character_after_cursor, [[\k]]) == -1

	local current = config.get().experimental.ghost_text
	if current ~= should_enable_ghost_text then
		config.set_global({
			experimental = {
				ghost_text = should_enable_ghost_text,
			},
		})
	end
end

vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMovedI" }, {
	callback = toggle_ghost_text,
})

local M = {}
M.CAPABILITIES = require("cmp_nvim_lsp").default_capabilities()
return M
