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
})
