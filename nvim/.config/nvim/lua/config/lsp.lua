local cmp = require("pack.cmp")
vim.lsp.enable({ 'pyright', 'lua_ls', 'svelte', 'ts_ls', 'eslint', 'html', 'cssls', 'tailwindcss' })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect', 'fuzzy', 'popup' }
			-- vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			vim.keymap.set("i", "<C-Space>", function()
				vim.lsp.completion.get()
			end)
		end
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
	end
})

vim.cmd("set completeopt+=noselect")

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
vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "<leader>D", "<CMD>Telescope diagnostics<CR>")
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set('n', '<C-s>', vim.lsp.buf.format)
vim.keymap.set("i", "<C-\\>", vim.lsp.buf.signature_help)

vim.lsp.config('cssls', {
	settings = {
		capabilities = cmp.CAPABILITIES,
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
