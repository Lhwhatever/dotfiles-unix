require('icons')
local langs = require('lang')
local keymaps = require('keymaps')

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or 'rounded'
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = {
		prefix = '■ ',
		source = 'if_many',
	},
	signs = true,
	underline = true,
	update_in_insert = true,
})

local mason_lsp = require('mason-lspconfig')

local mason_setup_config = {
	function(server_name) -- default handler
		require('lspconfig')[server_name].setup(langs.common)
	end,
}

vim.diagnostic.config({ severity_sort = true })

mason_lsp.setup()

for server_name, config in pairs(langs.servers) do
	if config.override ~= false then
		mason_setup_config[server_name] = function()
			require('lspconfig')[server_name].setup(config)
		end
	else
		mason_setup_config[server_name] = config.setup
	end
end

mason_lsp.setup()
mason_lsp.setup_handlers(mason_setup_config)
