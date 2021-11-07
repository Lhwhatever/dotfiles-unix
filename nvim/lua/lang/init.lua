local M = {
	servers = {},
}

local common = require("lang.common")
M.common = common

local langs = {
	lua = require("lang.lua"),
	typescript = require("lang.typescript"),
}

for name, settings in pairs(langs) do
	if settings.lsp ~= nil then
		for key, value in pairs(common) do
			if settings.lsp[key] == nil then
				settings.lsp[key] = value
			end
		end
		M.servers[name] = settings.lsp
	end
end

return M
