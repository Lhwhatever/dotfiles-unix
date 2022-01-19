local keymaps = require 'keymaps'

vim.cmd('colorscheme sonokai')

require 'bufferline'.setup {
    options = {
        numbers = 'ordinal',
        diagnostics = 'nvim_lsp',
        show_buffer_close_icons = false,
        separator_style = { ' ', ' ' },
    },
}

keymaps.map({
    {'n', '[b', '<cmd>BufferLineCyclePrev<CR>'},
    {'n', ']b', '<cmd>BufferLineCycleNext<CR>'},
}, { noremap = true, silent = true })
