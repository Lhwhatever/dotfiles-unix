local common = require('lang.common')

local M = {}

local capabilities = common.make_capabilites()
capabilities.textDocument.semanticHighlighting = true

M.lsp = {
    key = 'clangd',
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--all-scopes-completion",
        "--suggest-missing-includes",
        "--background-index",
        "--pch-storage=disk",
        "--cross-file-rename",
        "--log=info",
        "--completion-style=detailed",
        "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
        "--clang-tidy",
        "--offset-encoding=utf-16", --temporary fix for null-ls
    }
}

return M
