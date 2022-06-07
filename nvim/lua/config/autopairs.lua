local npairs = require('nvim-autopairs')

npairs.setup({
	check_ts = true,
	fast_wrap = {},
})

require('nvim-treesitter.configs').setup({
	autopairs = { enable = true },
})
