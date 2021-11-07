local null = require("null-ls")

null.config({
	sources = {
		null.builtins.formatting.stylua,
		null.builtins.formatting.prettierd,
		null.builtins.formatting.clang_format,
		null.builtins.formatting.eslint_d,
		null.builtins.code_actions.gitsigns,
	},
})

--require("lspconfig")["null-ls"].setup({
--	on_attach = function(client)
--		if client.resolved_capabilities.document_formatting then
--			vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]])
--		end
--	end,
--})
