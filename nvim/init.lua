require("env").checkenv()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("plugins")

function _G.startup_call()
	if vim.g.env.head ~= "VSCODE" then
		vim.cmd([[doautocmd User NvimSpawn]])
	end

	if vim.g.env.head == "NVIM" then
		vim.cmd([[doautocmd User NvimConnect]])
		require("config.completion")
		vim.cmd([[doautocmd User NvimColorize]])
		vim.cmd([[colorscheme sonokai]])
	end
end

vim.cmd([[au VimEnter * call v:lua.startup_call()]])

require("options")
