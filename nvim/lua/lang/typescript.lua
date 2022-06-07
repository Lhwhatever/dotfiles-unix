local common = require('lang.common')

local M = {}

M.lsp = {
	key = '',
	on_attach = function(client, bufnr)
		common.on_attach(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false

		local ts_utils = require('nvim-lsp-ts-utils')
		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = true,
			update_imports_on_move = true,
			require_confirmation_on_move = true,
		})

		local opts = { silent = true, buffer = bufnr }

		vim.keymap.set('n', '<A-o>', '<cmd>TSLspOrganize<CR>', opts)
		vim.keymap.set('n', '<leader>rf', '<cmd>TSLspRenameFile<CR>', opts)

		vim.cmd([[ command! -buffer FormattingSync lua vim.lsp.buf.formatting_sync() ]])

		vim.api.nvim_create_autocmd('BufWritePre', {
			buffer = 0,
			callback = vim.lsp.buf.formatting_sync,
		})
	end,
}

return M
