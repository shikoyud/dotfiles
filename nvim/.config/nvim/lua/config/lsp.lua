vim.lsp.enable({ 'clangd', 'lua_ls', 'svelte', 'ts_ls', 'eslint', 'html', 'cssls', 'tailwindcss' })

vim.api.nvim_create_autocmd('Filetype', {
	pattern = 'java',
---@diagnostic disable-next-line: unused-local
	callback = function(args)
---@diagnostic disable-next-line: missing-parameter
		require("jdtls.jdtls_setup").setup()
	end
})


vim.diagnostic.config({
	virtual_lines = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " "
		}
	}
})

vim.keymap.set("n", "<leader>gr", "<CMD>Telescope lsp_references<CR>")
vim.keymap.set("n", "<leader>gi", "<CMD>Telescope lsp_implementations<CR>")
vim.keymap.set("n", "<leader>gt", "<CMD>Telescope lsp_type_definitions<CR>")
vim.keymap.set("n", "<leader>gd", "<CMD>Telescope lsp_definitions<CR>")
vim.keymap.set("n", "<leader>D", "<CMD>Telescope diagnostics<CR>")
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set('n', '<C-s>', vim.lsp.buf.format)
vim.keymap.set("i", "<C-\\>", vim.lsp.buf.signature_help)

local cmp = require("pack.cmp")
vim.lsp.config('clangd', {
	settings = {
		capabilities = cmp.CAPABILITIES,
	}
})

vim.lsp.config('cssls', {
	settings = {
		capabilities = cmp.CAPABILITIES,
		css = {
			lint = {
				unknownAtRules = "ignore",
			}
		},
	}
})

vim.lsp.config('html', {
	settings = {
		capabilities = cmp.CAPABILITIES,
	}
})

vim.lsp.config('tailwindcss', {
	settings = {
		capabilities = cmp.CAPABILITIES,
		css = {
			lint = {
				unknownAtRules = "ignore",
			}
		},
	}
})

vim.lsp.config('svelte', {
	settings = {
		capabilities = cmp.CAPABILITIES,
	}
})

vim.lsp.config('lua_ls', {
	settings = {
		capabilities = cmp.CAPABILITIES,
		Lua = { diagnostics = { globals = { 'vim' } } }
	}
})

vim.lsp.config('ts_ls', {
	settings = {
		capabilities = cmp.CAPABILITIES,
	},
	filetypes = {
		'svelte',
		'javascript',
		'javascriptreact',
		'typescript',
		'typescriptreact',
	},
})

vim.lsp.config('eslint', {
	settings = {
		capabilities = cmp.CAPABILITIES,
	},
	filetypes = {
		'svelte',
		'javascript',
		'javascriptreact',
		'typescript',
		'typescriptreact',
	},
})
