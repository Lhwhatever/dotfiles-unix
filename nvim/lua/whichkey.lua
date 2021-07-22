local wk = require 'which-key'
wk.setup {}

wk.register({
    g = {
        D  = '[LSP] Jump to declaration',
        d  = '[LSP] List definitions',
        r  = '[LSP] List references',
        y  = '[LSP] Preview type definition',
        yy = '[LSP] Jump to type definition',
        k  = '[LSP] Signature help',
        i  = '[LSP] Implementation',
        s = 'Substitute {count} chars',
        l = 'Look at parent function definition',
        L = 'Look at parent class definition',
    },
    ['['] = {
        e = '[LSP] Previous diagnostic',
        m = '[TS] Start of previous function',
        M = '[TS] End of previous function',
        b = '[TS] Start of previous block',
        B = '[TS] End of previous block',
        [','] = '[TS] Previous parameter',
        c = '[Gitsigns] Previous change',
    },
    [']'] = {
        e = '[LSP] Next diagnostic',
        m = '[TS] Start of next function',
        M = '[TS] End of next function',
        b = '[TS] Start of next block',
        B = '[TS] End of next block',
        [','] = '[TS] Next parameter',
        c = '[Gitsigns] Next change',
    },
    ['<C-w>'] = {
        ['<C-s>'] = 'Split window',
        ['<C-->'] = 'Split window',
        ['<C-v>'] = 'Split window vertically',
        ['<C-\\>'] = 'Split window vertically',
        ['<C-x>'] = 'Exchange windows',
    },
    ['<leader>'] = {
        rn = '[LSP] Rename',
        ca = '[LSP] Code actions',
        a = '[TS] Swap with next parameter',
        A = '[TS] Swap with previous parameter',
        f = {
            name = '+telescope',
            f = 'Find workspace files',
            g = 'Grep in workspace',
            b = 'Find buffers',
            h = 'Find help tags',
            o = 'Find old files',
            y = 'Registers',
            m = 'Marks',
            ['/'] = 'Search history',
            q = 'Command history',
            z = 'Spelling suggestions',
        },
        x = 'Trouble',
        h = {
            name = '+gitsigns',
            s = 'Stage hunk',
            u = 'Unstage hunk',
            r = 'Reset hunk',
            R = 'Reset buffer',
            p = 'Preview hunk',
            b = 'Blame',
        }
    },
    c = {
        d = '[LSP] Show line diagnostics'
    },
})
