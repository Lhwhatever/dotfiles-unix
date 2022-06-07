require('env').checkenv()

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('plugins')

vim.api.nvim_create_autocmd('VimEnter', {
	group = vim.api.nvim_create_augroup('VimInit', {}),
	callback = function()
		if vim.g.env.head ~= 'VSCODE' then
			vim.api.nvim_exec_autocmds('User', { pattern = 'NvimSpawn' })
		end

		if vim.g.env.head == 'NVIM' then
			vim.api.nvim_exec_autocmds('User', { pattern = 'NvimConnect' })
			require('config.completion')
			vim.api.nvim_exec_autocmds('User', { pattern = 'Colorize' })
		end
	end,
})

require('options')
