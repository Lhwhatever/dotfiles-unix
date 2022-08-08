local M = {}

M.on_attach = function(client, bufnr)
	local function mapkey(mode, lhs, rhs)
		vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr })
	end

	client.resolved_capabilities.document_formatting = false

	mapkey('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
	mapkey('n', 'gd', [[<cmd>TroubleToggle lsp_definitions<CR>]])
	mapkey('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
	mapkey('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
	mapkey('n', 'gr', [[<cmd>TroubleToggle lsp_references<CR>]])
	mapkey('n', 'gy', [[<cmd>TroubleToggle lsp_type_definitions<CR>]])
	mapkey('n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
	mapkey('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
	mapkey('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
	mapkey('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
	mapkey('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
	mapkey('n', 'cd', "<cmd>lua vim.diagnostic.open_float(nil, { source = 'always' })<CR>")
	mapkey('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
	mapkey('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>')
	vim.cmd([[ command! -buffer Format execute 'lua vim.lsp.buf.formatting()' ]])
end

M.flags = {
	debounce_text_changes = 150,
}

M.make_capabilites = function ()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    return capabilities
end

M.capabilities = M.make_capabilites()

return M
