local keymaps = require('keymaps')

require('bufferline').setup({
	options = {
		numbers = 'ordinal',
		diagnostics = 'nvim_lsp',
		show_buffer_close_icons = false,
		separator_style = { ' ', ' ' },
	},
})

keymaps.map({
	{ 'n', '[b', '<cmd>BufferLineCyclePrev<CR>' },
	{ 'n', ']b', '<cmd>BufferLineCycleNext<CR>' },
}, { silent = true })
