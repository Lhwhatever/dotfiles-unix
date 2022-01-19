-- bootstrapping
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.cmd("!git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd("packadd packer.nvim")
vim.cmd([[au BufWritePost plugins.lua PackerCompile]])

local packer = require("packer")

return packer.startup(function(use)
	use({
		"wbthomason/packer.nvim",
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
	})

	use({
		"williamboman/nvim-lsp-installer",
		after = { "nvim-lspconfig", "cmp-nvim-lsp" },
		cmd = { "LspInstall" },
		config = function()
			require("config.lsp")
		end,
	})

	use({
		"folke/trouble.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("config.trouble")
		end,
	})

	use({
		"ray-x/lsp_signature.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lsp_signature").setup({
				bind = true,
				handler_opts = {
					border = "rounded",
				},
			})
		end,
	})

	use({
		"kosayoda/nvim-lightbulb",
		requires = "nvim-lspconfig",
		config = function()
			vim.cmd([[autocmd CursorHold, CursorHoldI * lua require 'nvim-lightbulb'.update_lightbulb()]])
		end,
	})

	-- Completion
	use({
		"windwp/nvim-autopairs",
		after = "nvim-treesitter-textobjects",
		config = function()
			require("config.autopairs")
		end,
	})

	use({
		"hrsh7th/nvim-cmp",
		event = "User NvimConnect",
	})

	use({
		"hrsh7th/cmp-nvim-lsp",
		after = "nvim-cmp",
	})

	use({
		"hrsh7th/cmp-buffer",
		after = "nvim-cmp",
	})
	use({
		"hrsh7th/cmp-path",
		after = "nvim-cmp",
	})
	use({
		"hrsh7th/cmp-calc",
		after = "nvim-cmp",
	})
	use({
		"hrsh7th/cmp-cmdline",
		after = "nvim-cmp",
	})

	use({
		"hrsh7th/cmp-emoji",
		after = "nvim-cmp",
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		event = "User NvimSpawn",
        commit = '668de0951a36ef17016074f1120b6aacbe6c4515',
	})

	-- Icons
	use({
		"kyazdani42/nvim-web-devicons",
		event = "User NvimConnect",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	})

	-- Project Navigation
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		after = "nvim-web-devicons",
		config = function()
			require("config.telescope")
		end,
	})

	use({
		"famiu/bufdelete.nvim",
		event = "User NvimSpawn",
		config = function()
			vim.cmd([[runtime vim/bd.vim]])
		end,
	})

	-- User Assistance
	use({
		"folke/which-key.nvim",
		event = "User NvimConnect",
		config = function()
			require("config.whichkey")
		end,
	})

	-- Editing
	use({
		"b3nj5m1n/kommentary",
	})

	use({
		"machakann/vim-sandwich",
		config = function()
			require("config.sandwich")
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
        commit = "ca4a500c7fb17f770b3b633d7c0fb7fbb8aca6fc",
		after = "nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
	})

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		after = "nvim-cmp",
		opt = true,
	})

	use({
		"saadparwaiz1/cmp_luasnip",
		after = "LuaSnip",
		opt = true,
	})

	-- VCS
	use({
		"lewis6991/gitsigns.nvim",
		event = "User NvimConnect",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({
		"tpope/vim-fugitive",
		event = "User NvimConnect",
	})

	-- Navigation
	use({
		"ggandor/lightspeed.nvim",
		event = "User NvimSpawn",
	})

	-- Colorschemes
	use({
		"sainnhe/sonokai",
		event = "User NvimColorize",
		config = function()
			require("colors")
		end,
	})

	-- Editing guides
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "User NvimConnect",
		config = function()
			require("config.indent-guide")
		end,
	})

	-- Statusline and bufferline
	use({
		"akinsho/bufferline.nvim",
        after = 'sonokai',
		config = function()
			require("config.bline")
		end,
	})

	use({
		"rebelot/heirline.nvim",
        after = {'sonokai', 'nvim-web-devicons'},
		config = function()
			require("config.sline")
		end,
	})

	-- Start screen
	use({
		"glepnir/dashboard-nvim",
		config = function()
			require("config.dashboard")
		end,
	})

	-- Languages
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		ft = "markdown",
	})

	use({
		"lervag/vimtex",
		ft = { "tex", "latex" },
		config = function()
			require("config.vimtex")
		end,
	})

	use({
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		ft = { "javascript", "typescript", "jsx", "tsx", "javascriptreact", "typescriptreact" },
	})

	-- Debugging
	use({
		"rcarriga/nvim-dap-ui",
		requires = "mfussenegger/nvim-dap",
		event = "User NvimSpawn",
		config = function()
			require("config.debugger")
		end,
	})

	use({
		"mfussenegger/nvim-dap-python",
		requires = "mfussenegger/nvim-dap",
		event = "User NvimSpawn",
		config = function()
			require("dap-python").setup(vim.env.DEBUGPY_PYTHON)
		end,
	})

	-- Linting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		event = "User NvimConnect",
		config = function()
			require("config.null")
		end,
	})
end)
