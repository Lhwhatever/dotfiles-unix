local null = require('null-ls')
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null.setup({
	sources = {
		null.builtins.diagnostics.pylint,
		null.builtins.formatting.stylua,
		null.builtins.formatting.prettierd,
		null.builtins.formatting.clang_format,
		null.builtins.formatting.eslint_d,
		null.builtins.code_actions.eslint_d,
		null.builtins.code_actions.gitsigns,
		null.builtins.completion.luasnip,
		null.builtins.formatting.black,
		null.builtins.formatting.rustfmt,
	},
	on_attach = function(client, bufnr)
		if client.supports_method('textDocument/formatting') then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(client_)
							return client_.name == 'null-ls'
						end,
					})
				end,
			})
		end
	end,
})
