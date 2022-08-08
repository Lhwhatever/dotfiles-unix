local M = {
	servers = {},
	common = require('lang.common'),
}

local langs = {
	require('lang.lua'),
	require('lang.ts'),
	require('lang.emmet'),
	require('lang.clangd'),
}

for _, module in ipairs(langs) do
	if module.lsp ~= nil then
		for key, value in pairs(M.common) do
			if module.lsp[key] == nil then
				module.lsp[key] = value
			end
		end
		M.servers[module.lsp.key] = module.lsp
	end
end

return M
