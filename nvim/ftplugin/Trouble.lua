local wk = require 'which-key'

local maps = {
    q = '[Trouble] Close',
    r = '[Trouble] Refresh',
    m = '[Trouble] Toggle scope',
    P = '[Trouble] Toggle preview',
    p = '[Trouble] Preview',
    K = '[Trouble] Hover preview',
    k = '[Trouble] Previous item',
    j = '[Trouble] Next item',
    ['<S-Tab>'] = '[Trouble] Previous item',
    ['<Tab>'] = '[Trouble] Next item',
    ['[q'] = '[Trouble] Previous item',
    [']q'] = '[Trouble] Next item',
    ['<Esc>'] = '[Trouble] Cancel preview',
    ['<CR>'] = '[Trouble] Jump and close Trouble',
    ['<C-x>'] = '[Trouble] Open in new split',
    ['<C-v>'] = '[Trouble] Open in new vsplit',
    ['<C-t>'] = '[Trouble] Open in new tab',
    z = {
        name = '+folds',
        M = 'Close all',
        m = 'Close all',
        R = 'Open all',
        r = 'Open all',
        A = 'Toggle all',
        a = 'Toggle all',
    }
}

local z_ignore = {'=', 'b', 'c', 'C', 'g', 'O', 'o', 't', 'v', 'w', 'x', 'z', 'f'}
for _, z_key  in pairs(z_ignore) do maps.z[z_key] = 'which_key_ignore' end

wk.register(maps, {
    noremap = false,
    buffer = 0,
})

vim.keymap.set('n', 'gh', '<cmd>WhichKey<CR>', { silent = true, buffer = 0 })
vim.keymap.set('n', 'g?', '<cmd>WhichKey<CR>', { silent = true, buffer = 0 })
