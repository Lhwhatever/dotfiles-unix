require('telescope').setup({
	defaults = {
		promt_prefix = '➤ ',
	},
})

require('keymaps').map({
	{ 'n', '<C-p>', '<cmd>Telescope find_files<CR>' },
	{ 'n', '<M-f>', '<cmd>Telescope live_grep<CR>' },
	{ 'n', '<M-b>', '<cmd>Telescope buffers<CR>' },
	{ 'n', '<leader>ff', '<cmd>Telescope find_files<CR>' },
	{ 'n', '<leader>fg', '<cmd>Telescope live_grep<CR>' },
	{ 'n', '<leader>fb', '<cmd>Telescope buffers<CR>' },
	{ 'n', '<leader>fh', '<cmd>Telescope help_tags<CR>' },
	{ 'n', '<leader>fo', '<cmd>Telescope old_files<CR>' },
	{ 'n', '<leader>fy', '<cmd>Telescope registers<CR>' },
	{ 'n', '<leader>fm', '<cmd>Telescope marks<CR>' },
	{ 'n', '<leader>f/', '<cmd>Telescope search_history<CR>' },
	{ 'n', '<leader>f/', '<cmd>Telescope command_history<CR>' },
	{ 'n', '<leader>f/', '<cmd>Telescope spell_suggest<CR>' },
}, { silent = true })
