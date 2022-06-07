local jsx = {
	snippets = {
		rf = [[{<React.Fragment>}$0{</React.Fragment>}]],
	},
}

local extends_jsx = {
	extends = 'jsx',
}

vim.g.user_emmet_settings = {
	typescriptreact = extends_jsx,
	tsx = extends_jsx,
	javascriptreact = extends_jsx,
	jsx = jsx,
}
