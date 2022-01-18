local M = {}

M.on_attach = function(client, bufnr)
	local function mapkey(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	client.resolved_capabilities.document_formatting = false

	local opts = { noremap = true, silent = true }

	mapkey("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	mapkey("n", "gd", [[<cmd>TroubleToggle lsp_definitions<CR>]], opts)
	mapkey("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	mapkey("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	mapkey("n", "gr", [[<cmd>TroubleToggle lsp_references<CR>]], opts)
	mapkey("n", "gy", [[<cmd>TroubleToggle lsp_type_definitions<CR>]], opts)
	mapkey("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	mapkey("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	mapkey("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	mapkey("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	mapkey("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	mapkey("n", "cd", "<cmd>lua vim.diagnostic.open_float(nil, { source = 'always' })<CR>", opts)
	mapkey("n", "[e", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	mapkey("n", "]e", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.cmd([[ command! -buffer Format execute 'lua vim.lsp.buf.formatting()' ]])
end

M.flags = {
	debounce_text_changes = 150,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
M.capabilities = capabilities

return M
