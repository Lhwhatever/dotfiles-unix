local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.lsp = {
    key = 'emmet_ls',
    capabilities = capabilities,
    filetypes = { 'html', 'css', 'typescriptreact', 'javascriptreact' }
}

return M
