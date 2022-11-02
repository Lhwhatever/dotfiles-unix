-- bootstrapping
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.cmd('!git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd('packadd packer.nvim')
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = 'plugins.lua',
	command = "echo 'Compiling packer...' | PackerCompile",
})

local packer = require('packer')

return packer.startup(function(use)
	use({
		'wbthomason/packer.nvim',
	})

	-- LSP
	use({ 'neovim/nvim-lspconfig' })

	use({
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup()
		end,
	})

	use({
		'williamboman/mason-lspconfig.nvim',
		after = { 'nvim-lspconfig', 'mason.nvim', 'cmp-nvim-lsp' },
		config = function()
			require('config.lsp')
		end,
	})

	use({
		'folke/trouble.nvim',
		after = 'nvim-lspconfig',
		config = function()
			require('config.trouble')
		end,
	})

	use({
		'ray-x/lsp_signature.nvim',
		after = 'nvim-lspconfig',
		config = function()
			require('lsp_signature').setup({
				bind = true,
				handler_opts = {
					border = 'rounded',
				},
				transparency = 10,
			})
		end,
	})

	-- Notifications
	use({
		'rcarriga/nvim-notify',
		after = 'telescope.nvim',
		config = function()
			local notify = require('notify')
			notify.setup({ background_color = '#000000', stages = 'slide' })
			vim.notify = notify
			require('telescope').load_extension('notify')
			vim.keymap.set('n', '<leader>fn', '<cmd>Telescope notify<CR>')
		end,
	})

	use({
		'kosayoda/nvim-lightbulb',
		requires = 'nvim-lspconfig',
		config = function()
			require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
		end,
	})

	-- Completion
	use({
		'windwp/nvim-autopairs',
		after = 'nvim-treesitter',
		config = function()
			require('config.autopairs')
		end,
	})

	use({
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-calc',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-emoji',
		after = 'LuaSnip',
	})

	-- Treesitter
	use({
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('config.treesitter')
		end,
	})

	-- Icons
	use({
		'kyazdani42/nvim-web-devicons',
		event = 'User NvimConnect',
		config = function()
			require('nvim-web-devicons').setup()
		end,
	})

	-- Project Navigation
	use({
		'nvim-telescope/telescope.nvim',
		requires = {
			{ 'nvim-lua/popup.nvim' },
			{ 'nvim-lua/plenary.nvim' },
		},
		after = 'nvim-web-devicons',
		config = function()
			require('config.telescope')
		end,
	})

	use({
		'famiu/bufdelete.nvim',
		event = 'User NvimSpawn',
		config = function()
			vim.cmd([[runtime vim/bd.vim]])
		end,
	})

	use({
		'nvim-telescope/telescope-file-browser.nvim',
		after = 'telescope.nvim',
		config = function()
			require('telescope').load_extension('file_browser')
			vim.keymap.set('n', '<M-p>', '<cmd>Telescope file_browser<CR>', { silent = true })
		end,
	})

	-- User Assistance
	use({
		'folke/which-key.nvim',
		event = 'User NvimConnect',
		config = function()
			require('config.whichkey')
		end,
	})

	-- Editing
	use({
		'JoosepAlviste/nvim-ts-context-commentstring',
		after = 'nvim-treesitter',
	})

	use({
		'numToStr/Comment.nvim',
		after = 'nvim-ts-context-commentstring',
		config = function()
			require('Comment').setup()
		end,
	})

	use({
		'machakann/vim-sandwich',
		config = function()
			require('config.sandwich')
		end,
	})

	-- Snippets
	use({
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		after = 'nvim-cmp',
	})

	-- VCS
	use({
		'lewis6991/gitsigns.nvim',
		event = 'User NvimConnect',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('gitsigns').setup()
		end,
	})

	use({
		'tpope/vim-fugitive',
		event = 'User NvimConnect',
	})

	-- Navigation
	use({
		'ggandor/lightspeed.nvim',
		event = 'User NvimSpawn',
	})

	-- Colorschemes
	use({
		'sainnhe/sonokai',
		event = 'User Colorize',
		config = function()
			require('colors')
			vim.cmd([[colorscheme sonokai]])
			vim.api.nvim_exec_autocmds('ColorScheme', { group = 'OnColorscheme' })
		end,
	})

	-- Editing guides
	use({
		'lukas-reineke/indent-blankline.nvim',
		event = 'User NvimConnect',
		config = function()
			require('config.indent-guide')
		end,
	})

	-- Statusline and bufferline
	use({
		'akinsho/bufferline.nvim',
		tag = 'v2.*',
		after = 'sonokai',
		requires = 'kyazdan142/nvim-web-devicons',
		config = function()
			require('config.bline')
		end,
	})

	use({
		'rebelot/heirline.nvim',
		after = { 'sonokai', 'nvim-web-devicons', 'nvim-lspconfig' },
		config = function()
			require('config.sline')
		end,
	})

	-- Languages
	use({
		'iamcco/markdown-preview.nvim',
		run = 'cd app && yarn install',
		ft = 'markdown',
	})

	use({
		'lervag/vimtex',
		ft = { 'tex', 'latex' },
		config = function()
			require('config.vimtex')
		end,
	})

	use({
		'jose-elias-alvarez/typescript.nvim',
		after = 'nvim-lspconfig',
	})

	-- Debugging
	use({
		'rcarriga/nvim-dap-ui',
		requires = 'mfussenegger/nvim-dap',
		event = 'User NvimSpawn',
		config = function()
			require('config.debugger')
		end,
	})

	use({
		'mfussenegger/nvim-dap-python',
		requires = 'mfussenegger/nvim-dap',
		event = 'User NvimSpawn',
		config = function()
			require('dap-python').setup(vim.env.DEBUGPY_PYTHON)
		end,
	})

	-- Linting
	use({
		'jose-elias-alvarez/null-ls.nvim',
		event = 'User NvimConnect',
		after = 'mason.nvim',
		config = function()
			require('config.null')
		end,
	})

	-- Distant
	use({
		'chipsenkbeil/distant.nvim',
		config = function()
			require('distant').setup({
				-- Applies Chip's personal settings to every machine you connect to
				--
				-- 1. Ensures that distant servers terminate with no connections
				-- 2. Provides navigation bindings for remote directories
				-- 3. Provides keybinding to jump into a remote file's parent directory
				['*'] = require('distant.settings').chip_default(),
			})
		end,
	})
end)
