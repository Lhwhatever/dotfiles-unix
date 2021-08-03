require 'null-ls'.config {}

require('lspconfig')['null-ls'].setup {
    on_attach = function (client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        end
    end
}
