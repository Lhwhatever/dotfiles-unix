local common = require('lang.common')

local M = {}

M.lsp = {
	key = 'tsserver',
	override = true,
	on_attach = function(client, bufnr)
		common.on_attach(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		local opts = { silent = true, buffer = bufnr }
		local ts = require('typescript')

		vim.keymap.set('n', '<A-o>', ts.actions.addMissingImports, opts)
		vim.keymap.set('n', '<leader>rf', ts.actions.organizeImports, opts)
	end,
}

M.setup = function()
	require('typescript').setup({
		server = {
			on_attach = M.lsp.on_attach,
		},
	})
end

return M
