require 'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = {'python'},
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                af = '@function.outer',
                ['if'] = '@function.inner',
                ac = '@class.outer',
                ic = '@class.inner',
                ['a,'] = '@parameter.outer',
                ['i,'] = '@parameter.inner',
                ab = '@block.outer',
                ib = '@block.inner',
                ai = '@call.outer',
                ii = '@call.inner',
            }
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner'
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']s'] = '@block.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']S'] = '@block.outer',
                ['],'] = '@parameter.outer',
            },
            goto_prev_start = {
                ['[m'] = '@function.outer',
                ['[s'] = '@block.outer',
                ['[,'] = '@parameter.outer',
            },
            goto_prev_end = {
                ['[M'] = '@function.outer',
                ['[S'] = '@block.outer',
            },
        },
        lsp_interop = {
            enable = true,
            border = 'rounded',
            peek_definition_code = {
                gl = '@function.outer',
                gL = '@class.outer',
                gb = '@block.outer',
            }
        }
    }
}

vim.opt.foldmethod='expr'
vim.opt.foldexpr='nvim_treesitter#foldexpr()'
