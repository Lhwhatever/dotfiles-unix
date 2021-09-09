vim.cmd [[runtime macros/sandwich/keymap/surround.vim]]
vim.cmd [[runtime vim/sandwich.vim]]
local recipes = vim.g['sandwich#recipes']

local new_recipes = {
    {
        buns = {'{ ', ' }'},
        nesting = 1,
        match_syntax = 1,
        kind = {'add', 'replace'},
        action = {'add'},
        input = {'{'}
    },
    {
        buns = {'[ ', ' ]'},
        nesting = 1,
        match_syntax = 1,
        kind = {'add', 'replace'},
        action = {'add'},
        input = {'['}
    },
    {
        buns = {'( ', ' )'},
        nesting = 1,
        match_syntax = 1,
        kind = {'add', 'replace'},
        action = {'add'},
        input = {'('}
    },
    {
        buns = {'{\\s*', '\\s*}'},
        nesting = 1,
        regex = 1,
        match_syntax = 1,
        kind = {'delete', 'replace', 'textobj'},
        action = {'delete'},
        input = {'{'}
    },
    {
        buns = {'\\[\\s*', '\\s*\\]'},
        nesting = 1,
        regex = 1,
        match_syntax = 1,
        kind = {'delete', 'replace', 'textobj'},
        action = {'delete'},
        input = {'['}
    },
    {
        buns = {'(\\s*', '\\s*)'},
        nesting = 1,
        regex = 1,
        match_syntax = 1,
        kind = {'delete', 'replace', 'textobj'},
        action = {'delete'},
        input = {'('}
    },
}

for _, recipe in pairs(new_recipes) do
    table.insert(recipes, recipe)
end

vim.g['sandwich#recipes'] = recipes
