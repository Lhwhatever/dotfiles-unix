local null = require("null-ls")

null.setup({
	sources = {
		null.builtins.formatting.stylua,
		null.builtins.formatting.prettierd,
		null.builtins.formatting.clang_format,
		null.builtins.formatting.eslint_d,
		null.builtins.code_actions.eslint_d,
		null.builtins.code_actions.gitsigns,
        null.builtins.completion.luasnip,
	},
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
                augroup LspFormatting
                    autocmd! * <buffer>
                    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
                augroup END
            ]])
        end
    end
})
