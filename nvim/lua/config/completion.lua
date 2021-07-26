vim.opt.completeopt = 'menuone,noselect'
local keymaps = require 'keymaps'

require 'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    preselect = 'enable',
    source = {
        path = true,
        buffer = true,
        nvim_lsp = true,
        nvim_lua = true,
    },
    documentation = {
        border = 'rounded'
    }
}

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return (col == 0 or vim.fn.getline('.'):sub(col, col):match('%s'))
end

keymaps.map({
    { 'i', '<C-space>', [[compe#complete()]] },
    { 'i', '<CR>', [[compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))]] },
    { 'i', '<C-e>', [[compe#close('<C-e>')]] },
    { 'i', '<C-f>', [[compe#scroll({ 'delta': +4 })]] },
    { 'i', '<C-d>', [[compe#scroll({ 'delta': -4 })]] },
    { 'i', '<Tab>', [[v:lua.tab_complete()]] },
    { 's', '<Tab>', [[v:lua.tab_complete()]] },
    { 'i', '<S-Tab>', [[v:lua.s_tab_complete()]] },
    { 's', '<S-Tab>', [[v:lua.s_tab_complete()]] },
}, { noremap = true, expr = true })


_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return keymaps.t "<C-n>"
    elseif check_back_space() then
        return keymaps.t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return keymaps.t "<C-p>"
    else
        return keymaps.t "<S-Tab>"
    end
end
