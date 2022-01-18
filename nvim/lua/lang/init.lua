local M = {
	servers = {},
}

local common = require("lang.common")
M.common = {
    settings = common
}

local langs = {
    require("lang.lua"),
    require("lang.typescript"),
}

for _, module in ipairs(langs) do
    if module.lsp ~= nil then
        for key, value in pairs(common) do
            if module.lsp[key] == nil then
                module.lsp[key] = value
            end
        end
        M.servers[module.lsp.key] = module.lsp
    end
end

return M
