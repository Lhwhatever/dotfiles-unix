local M = {
    servers = {},
}

local common = require 'lang.common'

local langs = {
    lua = require 'lang.lua',
}

for name, settings in pairs(langs) do
    local capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    if settings.lsp ~= nil then
        for key, value in pairs(common) do
            settings.lsp.capabilities = capabilities
            if settings.lsp[key] == nil then
                settings.lsp[key] = value
            end
        end
    end
    M.servers[name] = settings.lsp
end

return M
