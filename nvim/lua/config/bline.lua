local keymaps = require 'keymaps'

require 'bufferline'.setup {
    options = {
        numbers = 'ordinal',
        mappings = true,
        diagnostics = 'nvim_lsp',
        show_buffer_close_icons = false,
        separator_style = { ' ', ' ' },
    }
}

keymaps.map({
    {'n', '[b', '<cmd>BufferLineCyclePrev<CR>'},
    {'n', ']b', '<cmd>BufferLineCycleNext<CR>'},
}, { noremap = true, silent = true })
