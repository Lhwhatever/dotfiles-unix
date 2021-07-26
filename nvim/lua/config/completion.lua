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
    { 'i', '<C-f>', [[compe#scroll({ 'delta': +4 })]] },
    { 'i', '<C-d>', [[compe#scroll({ 'delta': -4 })]] },
    { 'i', '<Tab>', [[v:lua.tab_complete()]] },
    { 's', '<Tab>', [[v:lua.tab_complete()]] },
    { 'i', '<S-Tab>', [[v:lua.s_tab_complete()]] },
    { 's', '<S-Tab>', [[v:lua.s_tab_complete()]] },
}, { noremap = true, expr = true, silent = true })

keymaps.map({
    { 'i', '<C-e>', [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : compe#close('<C-e>')]] },
    { 's', '<C-e>', [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : compe#close('<C-e>')]] },
}, { noremap = false, expr = true, silent = true })


_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return keymaps.t "<C-n>"
    elseif require 'luasnip'.expand_or_jumpable() then
        return keymaps.t [[<cmd>lua require 'luasnip'.jump(1)<CR>]]
    elseif check_back_space() then
        return keymaps.t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return keymaps.t "<C-p>"
    elseif require 'luasnip'.jumpable(-1) then
        return keymaps.t [[<cmd>lua require 'luasnip'.jump(-1)<CR>]]
    else
        return keymaps.t "<S-Tab>"
    end
end
