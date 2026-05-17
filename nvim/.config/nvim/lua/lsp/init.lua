vim.lsp.enable({
	'pyright',
	'clangd',
	'lua_ls',
	'svelte',
	'ts_ls',
	'eslint',
	'html',
	'cssls',
	'tailwindcss',
	'rust_analyzer'
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " "
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
local web_filetypes = { 'svelte', 'javascript', 'jsx', 'typescript', 'tsx', }

vim.lsp.config('*', { capabilities = cmp.capabilities })

vim.lsp.config('lua_ls', { settings = { Lua = { diagnostics = { globals = { 'vim' } } } } })

vim.lsp.config('ts_ls', { filetypes = web_filetypes })
vim.lsp.config('eslint', { filetypes = web_filetypes })
vim.lsp.config('tailwindcss', { filetypes = web_filetypes })

vim.lsp.config('pyright', {
	settings = {
		python = {
			analysis = {
				diagnosticSeverityOverrides = { reportPrivateImportUsage = "none" }
			}
		}
	}
})
