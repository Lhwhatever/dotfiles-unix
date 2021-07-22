local M = {}

M.t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.map = function(maps, default_opts)
    for _, map in ipairs(maps) do
        local opts = map[4] or default_opts
        vim.api.nvim_set_keymap(map[1], map[2], map[3], opts)
    end
end

M.map({
    {'n', 'j', [[v:count ? 'j' : 'gj']]},
    {'n', 'k', [[v:count ? 'k' : 'gk']]},
}, { noremap = true, expr = true })

M.map({
    {'n', '<F5>', [[<cmd>nohl | normal! <C-l><CR>]]},
    {'n', 'gs', [[s]]},
    {'n', '<C-h>', [[<cmd>wincmd h<CR>]]},
    {'n', '<C-j>', [[<cmd>wincmd j<CR>]]},
    {'n', '<C-k>', [[<cmd>wincmd k<CR>]]},
    {'n', '<C-l>', [[<cmd>wincmd l<CR>]]},
    {'n', '<C-w><C-s>', [[<cmd>wincmd s<CR>]]},
    {'n', '<C-w><C-->', [[<cmd>wincmd s<CR>]]},
    {'n', '<C-w><C-v>', [[<cmd>wincmd v<CR>]]},
    {'n', '<C-w><C-\\>', [[<cmd>wincmd v<CR>]]},
    {'n', '<C-w><C-x>', [[<cmd>wincmd x<CR>]]},
    {'n', '<leader>bd', [[<cmd>Bdelete<CR>]]},
    {'n', '<leader>bD', [[<cmd>Bdelete!<CR>]]},
    {'n', '<leader>bw', [[<cmd>Bwipeout<CR>]]},
    {'n', '<leader>bW', [[<cmd>Bwipeout!<CR>]]},
}, { noremap = true, silent = true })


return M
