local icons = require 'nvim-web-devicons'
local palette = vim.fn['sonokai#get_palette'](vim.g.sonokai_style)

local function get_palette(key)
    return palette[key][1]
end

local colors = {
    red    = get_palette('bg_red'),
    green  = get_palette('bg_green'),
    blue   = get_palette('bg_blue'),
    purple = get_palette('purple'),
    orange = get_palette('orange'),
    yellow = get_palette('yellow'),
    dcharc = get_palette('bg1'),
    charc  = get_palette('bg2'),
    dgrey  = get_palette('bg3'),
    grey   = get_palette('bg4'),
    lgrey  = get_palette('grey'),
}

colors.fg0 = colors.lgrey
colors.fg1 = colors.dcharc
colors.fg2 = 'fg'
colors.bg  = 'NONE'
colors.bg0 = colors.dcharc
colors.bg2 = colors.dgrey


local properties = {
    force_inactive = {
        filetypes = {
            'packer',
            'dashboard',
            'fugitive',
            'fugitiveblame'
        },
        buftypes = {'terminal'},
        bufnames = {}
    }
}

local vi_groups = {
    n        = 'Normal',
    no       = 'Oper',
    nov      = 'Oper',
    noV      = 'Oper',
    ['no'] = 'Oper',
    niI      = 'Normal',
    niR      = 'Normal',
    niV      = 'Normal',
    v        = 'Visual',
    V        = 'Visual',
    ['']   = 'Visual',
    s        = 'Select',
    S        = 'Select',
    ['']   = 'Select',
    i        = 'Insert',
    ic       = 'Insert',
    ix       = 'Insert',
    R        = 'Replace',
    Rc       = 'Replace',
    Rx       = 'Replace',
    Rv       = 'Replace',
    c        = 'Command',
    cv       = 'Command',
    ce       = 'Command',
    r        = 'Command',
    rm       = 'Command',
    ['r?']   = 'Command',
    ['!']    = 'Shell',
    t        = 'Terminal',
    ['null'] = 'Normal',
}

local vi_icons = {
    n        = [[  ]],
    no       = [[  ]],
    nov      = [[ ]],
    noV      = [[ ]],
    ['no'] = [[ ]],
    niI      = [[ ]],
    niR      = [[﯒ ]],
    niV      = [[麗]],
    v        = [[ 麗]],
    V        = [[麗]],
    ['']   = [[麗]],
    s        = [[ 礪]],
    S        = [[礪]],
    ['']   = [[礪]],
    i        = [[  ]],
    ic       = [[ ]],
    ix       = [[ ]],
    R        = [[ ﯒ ]],
    Rc       = [[﯒ ]],
    Rx       = [[﯒ ]],
    Rv       = [[﯒ ]],
    c        = [[  ]],
    cv       = [[ ]],
    ce       = [[ ]],
    r        = [[  ]],
    rm       = [[  ]],
    ['r?']   = [[   ]],
    ['!']    = [[  ]],
    t        = [[  ]],
    ['null'] = [[   ]]
}

local group_colors = {
    Normal = 'green',
    Oper = 'blue',
    Insert = 'yellow',
    Visual = 'purple',
    Select = 'blue',
    Replace = 'red',
    Command = 'blue',
    Shell = 'red',
    Terminal = 'blue',
}

local function get_vi_color()
    local group = vi_groups[vim.fn.mode()] or vi_groups['null']
    return group_colors[group]
end

local function ternary(condition, if_true, if_false)
    if condition then return if_true else return if_false end
end

local primary_hl = function() return {
    bg = get_vi_color(),
    fg = 'fg1',
    style = 'bold',
} end

local primary_outer_hl = function() return {
    fg = get_vi_color(),
} end

local primary_inner_hl = function() return {
    bg = 'bg2',
    fg = get_vi_color(),
} end

local secondary_hl = function() return { bg = 'bg2', fg = get_vi_color() } end

local inactive_hl = { bg = 'bg0', fg = 'fg0' }
local inactive_within_hl = { bg = 'bg0', fg = 'black' }

local mode_component = {
    provider = function()
        return vi_icons[vim.fn.mode()] or vi_icons['null']
    end,
    hl = primary_hl,
    left_sep = function() return { str = 'left_filled', hl = primary_outer_hl() } end,
    right_sep = function() return { str = 'right_filled', hl = primary_inner_hl() } end,
}

local function make_git_component(active) return {
    provider = function()
        local gsd = vim.b.gitsigns_status_dict
        local output = '  ' .. gsd.head .. ' '
        if gsd['added'] and gsd['added'] > 0 then
            output = output .. ' ' .. gsd['added'] .. ' '
        end
        if gsd['removed'] and gsd['removed'] > 0 then
            output = output .. ' ' .. gsd['removed'] .. ' '
        end
        if gsd['changed'] and gsd['changed'] > 0 then
            output = output .. '柳' .. gsd['changed'] .. ' '
        end
        return output
    end,
    hl = ternary(active, secondary_hl, inactive_hl),
    enabled = function() return vim.b.gitsigns_status_dict ~= nil end,
    right_sep = ternary(
        active,
        function() return { str = 'right', hl = secondary_hl() } end,
        { str = 'vertical_bar_thin', hl = inactive_within_hl }
    )
} end

local function get_file_icon()
    local name = vim.fn.expand('%')
    local ext = vim.fn.expand('%:e')
    return ' ' .. icons.get_icon(name, ext, { default = true }) .. ' '
end

local function get_file_hl_active() return {
    bg = 'bg2',
    fg = ternary(vim.bo.modified, 'orange', get_vi_color())
} end

local function get_file_hl_inactive() return {
    bg = 'bg0',
    fg = ternary(vim.bo.modified, 'orange', 'fg0')
} end

local function make_directory_component(active)
    return {
        provider = function()
            if vim.bo.filetype == 'help' then
                return ''
            end

            local filename = vim.fn.bufname()
            filename = vim.fn.pathshorten(vim.fn.fnamemodify(filename, '%:~:%.'))
            local dirname = vim.fn.fnamemodify(filename, ':h')
            if dirname == '.' then
                return ''
            else
                return dirname .. '/'
            end
        end,
        hl = ternary(
            active,
            {fg = 'lgrey', bg = 'bg2'},
            {fg = 'black', bg = 'bg0'}
        ),
        left_sep = ternary(
            active,
            function() return {
                str = get_file_icon(),
                hl = get_file_hl_active()
            } end,
            function() return {
                str = get_file_icon(),
                hl = get_file_hl_inactive()
            } end
        )
    }
end

local function make_filename_component(active)
    return {
        provider = function()
            local filename = vim.fn.expand('%:t')
            local tags = ' '
            if vim.bo.modified then tags = tags .. '●' end
            if vim.bo.readonly then tags = tags .. '' end
            return filename .. tags
        end,
        hl = ternary(active, get_file_hl_active, get_file_hl_inactive),
        right_sep = 'right_filled'
    }
end


local position_component = {
    provider = 'position',
    hl = primary_hl,
    left_sep = function() return { str = 'left_filled', hl = primary_inner_hl() } end,
    right_sep = function() return { str = 'right_filled', hl = primary_outer_hl() } end,
}

local metadata_component = {
    provider = function()
        local suffix = {'b', 'ki', 'Mi', 'Gi', 'Ti', 'Pi', 'Ei'}
        local index = 1
        local fsize = vim.fn.getfsize(vim.fn.expand('%:p'))
        while fsize > 1024 and index < 7 do
            fsize = fsize / 1024
            index = index + 1
        end
        return string.format('%.1f', fsize) .. suffix[index]
    end,
    hl = secondary_hl,
}

local inactive_left = {
    provider = '',
    hl = { bg = 'NONE' },
    right_sep = {
        str = 'left_filled',
        hl = { fg = 'bg0' },
    },
}

local inactive_right = {
    provider = '',
    hl = { bg = 'NONE' },
    left_sep = {
        str = 'right_filled',
        hl = { fg = 'bg0' },
    },
}


local InactiveStatusHL = {
    fg = vim.api.nvim_exec('hi VertSplit', true):match('guifg=(#%x+)') or '#444444',
    bg = vim.api.nvim_exec('hi VertSplit', true):match('guibg=(#%x+)') or 'NONE',
    style = vim.api.nvim_exec('hi VertSplit', true):match('gui=(#[%l,]+)') or ''
}

if InactiveStatusHL.style == '' then
    InactiveStatusHL.style = 'strikethrough'
else
    InactiveStatusHL.style = 'strikethrough'
end

local empty_component = {provider = '', hl = InactiveStatusHL}

local components = {
    left = {
        active = {
            mode_component,
            make_git_component(true),
            make_directory_component(true),
            make_filename_component(true),
        },
        inactive = {
            inactive_left,
            make_git_component(false),
            make_directory_component(false),
            make_filename_component(false),
            empty_component,
        },
    },
    mid = {
        active = {},
        inactive = {},
    },
    right = {
        active = {
            position_component
        },
        inactive = {
            inactive_right
        },
    },
}

require 'feline'.setup {
    properties = properties,
    components = components,
    colors = colors,
}

local to_link = {'StatusLine', 'StatusLineNC', 'StatusLineTerm', 'StatusLineTermNC'}

for _, group in pairs(to_link) do
    vim.cmd('hi ' .. group .. ' guifg=' .. InactiveStatusHL.fg .. ' guibg=' .. InactiveStatusHL.bg)
end
