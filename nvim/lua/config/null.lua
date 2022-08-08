local null = require('null-ls')

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
	},
	on_attach = function(client, bufnr)
		if client.resolved_capabilities.document_formatting then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('LspFormatting', {}),
				buffer = bufnr,
				desc = 'Format on save',
				callback = function()
					local params = require('vim.lsp.util').make_formatting_params({})
					client.request('textDocument/formatting', params, nil, bufnr)
				end,
			})
		end
	end,
})
