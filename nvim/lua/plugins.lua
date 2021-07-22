-- bootstrapping
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd 'packadd packer.nvim'
vim.cmd [[au BufWritePost plugins.lua PackerCompile]]

local packer = require 'packer'

local is_windows = vim.g.env.os == 'Windows'

return packer.startup(function(use)
    use {
        'wbthomason/packer.nvim',
    }

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        event = 'User NvimSpawn',
    }

    use {
        'kabouzeid/nvim-lspinstall',
        disable = is_windows,
        after = 'nvim-lspconfig',
        cmd = {'LspInstall'},
        config = function() require 'lsp' end,
    }

    use {
        'folke/trouble.nvim',
        after = 'nvim-lspconfig',
        config = function() require 'trouble-config' end,
    }

    use {
        'ray-x/lsp_signature.nvim',
        after = 'nvim-lspconfig',
        config = function()
            require 'lsp_signature'.setup {
                bind = true,
                handler_opts = {
                    border = 'single'
                }
            }
        end,
    }

    use {
        'kosayoda/nvim-lightbulb',
        after = 'nvim-lspconfig',
        config = function()
            vim.cmd [[autocmd CursorHold, CursorHoldI * lua require 'nvim-lightbulb'.update_lightbulb()]]
        end,
    }

    -- Completion
    use {
        'windwp/nvim-autopairs',
        after = 'nvim-treesitter',
        config = function() require 'autopairs' end,
    }

    use {
        'hrsh7th/nvim-compe',
        event = 'User NvimConnect',
        config = function() require 'completion' end,
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'User NvimSpawn',
        config = function() require 'treesitter' end,
    }

    -- Icons
    use {
        'kyazdani42/nvim-web-devicons',
        event = 'User NvimConnect',
        config = function() require 'nvim-web-devicons'.setup() end,
    }

    -- Project Navigation
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'}
        },
        after = 'nvim-web-devicons',
        config = function() require 'telescope-config' end,
    }

    -- User Assistance
    use {
        'folke/which-key.nvim',
        event = 'User NvimConnect',
        config = function() require 'whichkey' end,
    }

    -- Editing
    use {
        'b3nj5m1n/kommentary',
        keys = {
            {'n', '<Plug>kommentary_motion_default'},
            {'v', '<Plug>kommentary_visual_default'},
            {'n', '<Plug>kommentary_line_default'},
        }
    }

    use {
        'machakann/vim-sandwich',
        config = function() require 'sandwich-config' end,
    }

    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    }

    -- VCS
    use {
        'lewis6991/gitsigns.nvim',
        event = 'User NvimConnect',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require 'gitsigns'.setup() end
    }

    use {
        'tpope/vim-fugitive',
        event = 'User NvimConnect',
    }

    -- Navigation
    use {
        'ggandor/lightspeed.nvim',
        event = 'User NvimSpawn'
    }

    -- Colorschemes
    use {
        'sainnhe/sonokai',
        event = 'User NvimColorize',
        config = function() require 'colors' end
    }

    -- Visual
    use {
        'lukas-reineke/indent-blankline.nvim',
        event = 'User NvimConnect',
        config = function() require 'indent-guide' end
    }
end)
