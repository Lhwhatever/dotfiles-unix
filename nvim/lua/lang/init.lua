local M = {
    servers = {},
}

local common = require 'lang.common'

local langs = {
    lua = require 'lang.lua',
}

for name, settings in pairs(langs) do
    if settings.lsp ~= nil then
        for key, value in pairs(common) do
            if settings.lsp[key] == nil then
                settings.lsp[key] = value
            end
        end
    end
    M.servers[name] = settings.lsp
end

return M
