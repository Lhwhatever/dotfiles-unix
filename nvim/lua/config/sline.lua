local icons = require 'nvim-web-devicons'
local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'

local colors = require("colors").colors
colors.fg0 = colors.lgrey
colors.fg1 = colors.dcharc
colors.fg2 = colors.lgrey
colors.bg = "NONE"
colors.bg0 = colors.dcharc
colors.bg2 = colors.dgrey

vim.o.showmode = false

local delims = {
    none = '',
    hard_r = '',
    hard_l = '',
    soft_r = '',
    soft_l = '',
}

local primary_hl = function(self) return { bg = self.mode_color, fg = colors.fg1, style = 'bold' } end
local secondary_hl = function(self) return { bg = self.bg_color, fg = self.mode_color } end
local tertiary_hl = function(self) return { bg = self.bg_color, fg = colors.fg2 } end
local delim_hl = function(self) return { bg = colors.bg, fg = self.bg_color } end
local middle_hl = { bg = colors.bg }

local Align = {
    provider = "%=",
}

local ViMode = {
    static = {
        vi_icons = {
            n = [[  ]],
            nt = [[  ]],
            no = [[  ]],
            nov = [[ ]],
            noV = [[ ]],
            ["no"] = [[ ]],
            niI = [[ ]],
            niR = [[﯒ ]],
            niV = [[麗 ]],
            v = [[ 麗 ]],
            V = [[麗 ]],
            [""] = [[麗 ]],
            s = [[ 礪]],
            S = [[礪 ]],
            [""] = [[礪 ]],
            i = [[  ]],
            ic = [[ ]],
            ix = [[ ]],
            R = [[ ﯒ ]],
            Rc = [[﯒ ]],
            Rx = [[﯒ ]],
            Rv = [[﯒ ]],
            c = [[  ]],
            cv = [[ ]],
            ce = [[ ]],
            r = [[  ]],
            rm = [[  ]],
            ["r?"] = [[   ]],
            ["!"] = [[  ]],
            t = [[  ]],
            ["null"] = [[   ]],
        },
    },
    hl = function(self)
        return { bg = self.mode_color, fg = colors.fg1, style = 'bold' }
    end,
    provider = function(self)
        return self.vi_icons[self.mode] or self.vi_icons['null']
    end,
}

local GitSignsBlock = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
    end,
    hl = tertiary_hl,
    { -- git branch name
        provider = function(self) return '  ' .. self.status_dict.head end,
        hl = secondary_hl,
    },
    {
        condition = function(self) return (self.status_dict.added or 0) > 0 end,
        provider = function(self) return '  ' ..  self.status_dict.added end,
    },
    {
        condition = function(self) return (self.status_dict.removed or 0) > 0 end,
        provider = function(self) return '  ' ..  self.status_dict.removed end,
    },
    {
        condition = function(self) return (self.status_dict.changed or 0) > 0 end,
        provider = function(self) return ' 柳' ..  self.status_dict.changed end,
    },
    {
        provider = ' ' .. delims.soft_r,
        hl = secondary_hl,
    }
}

local ViModeRightDelim = {
    provider = delims.hard_r,
    hl = secondary_hl,
}

local FileNameBlock = {
    hl = function(self) return { bg = self.bg_color, force = true } end,
}

local FileIcon = {
    init = function(self)
        local extension = vim.fn.fnamemodify(self.filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(self.filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (' ' .. self.icon)
    end,
    hl = function(self) return { fg = self.icon_color } end
}

local FileName = {
    init = function(self)
        self.filename_modified = vim.fn.fnamemodify(self.filename, ":.")
        self.nameless = self.filename_modified == ""
    end,
    provider = function(self)
        if self.nameless then return "[No Name]" end
        local filename  = self.filename_modified
        if not conditions.width_percent_below(#filename, 0.25) then filename = vim.fn.pathshorten(filename) end
        return ' ' .. filename
    end,
    hl = function(self)
        local hl = { fg = self.mode_color, bg = colors.bg2 }
        if self.nameless then hl.style = 'italic' end
        return hl
    end
}

local FileNameModifier = {
    hl = function() if vim.bo.modified then return { fg = colors.orange, style = 'bold', force = true } end end,
}

local FileFlags = {
    {
        provider = function() if vim.bo.modified then return '●' end end,
    },
    {
        provider = function() if (not vim.bo.modifiable) or vim.bo.readonly then return '' end end,
    },
    {
        provider = ' '
    }
}

FileName = utils.insert(FileNameModifier, FileName, unpack(FileFlags))

local FileNameBlockRightDelim = {
    provider = delims.hard_r,
    hl = delim_hl,
}

FileNameBlock = utils.insert(
    FileNameBlock,
    FileIcon,
    FileName
)

local DiagnosticsBlock = {
    condition = conditions.has_diagnostics,
    static = {
        error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
        warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
        info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
        hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
    },
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    hl = tertiary_hl,
    {
        provider = ' '
    },
    {
        provider = function(self) return self.errors > 0 and (self.error_icon .. self.errors .. ' ') end,
        hl = { fg = colors.red }
    },
    {
        provider = function(self) return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ') end,
        hl = { fg = colors.yellow }
    },
    {
        provider = function(self) return self.hints > 0 and (self.hint_icon .. self.hints .. ' ') end,
        hl = { fg = colors.green }
    },
    {
        provider = function(self) return self.info > 0 and (self.info_icon .. self.info .. ' ') end,
        hl = { fg = colors.blue }
    },
    {
        provider = delims.soft_l,
        hl = secondary_hl,
    }
}

local FileFormat = {
    init = function(self)
        self.ff = vim.bo.ff
    end,
    static = {
        ffs ={
            dos = "",
            unix = "",
            mac = "",
        } 
    },
    provider = function(self) return " " .. self.ffs[self.ff] .. " " end,
    hl = secondary_hl,
}

local function get_fsize(filename)
	local suffix = { "ki", "Mi", "Gi", "Ti", "Pi", "Ei" }
	local index = 0
	local fsize = vim.fn.getfsize(filename)
	while fsize > 1024 and index <= #suffix do
		fsize = fsize / 1024
		index = index + 1
	end

	if index == 0 then
		return fsize .. "B"
	else
		return string.format("%.1f", fsize) .. suffix[index]
	end
end

local FileSize = {
    provider = function(self) return get_fsize(self.filename) .. " " end,
    condition = function(self) return vim.fn.glob(self.filename) ~= "" end,
    hl = tertiary_hl,
}

local InfoBlockLeftDelim = {
    provider = delims.hard_l,
    hl = delim_hl,
}

local CursorBlock = {
    provider = " %l:%c ",
    hl = primary_hl
}

local CursorBlockLeftDelim = {
    provider = delims.hard_l,
    hl = secondary_hl
}

local ActiveStatusLine = {
    init = function (self)
        self.mode = vim.fn.mode(1)
        local group = self.vi_groups[self.mode] or self.vi_groups['null']
        self.mode_color = self.group_colors[group]
        self.bg_color = colors.bg2
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
    static = {
        vi_groups = {
            n = "Normal",
            no = "Oper",
            nov = "Oper",
            noV = "Oper",
            ["no"] = "Oper",
            niI = "Normal",
            niR = "Normal",
            niV = "Normal",
            v = "Visual",
            V = "Visual",
            [""] = "Visual",
            s = "Select",
            S = "Select",
            [""] = "Select",
            i = "Insert",
            ic = "Insert",
            ix = "Insert",
            R = "Replace",
            Rc = "Replace",
            Rx = "Replace",
            Rv = "Replace",
            c = "Command",
            cv = "Command",
            ce = "Command",
            r = "Command",
            rm = "Command",
            ["r?"] = "Command",
            ["!"] = "Shell",
            t = "Terminal",
            ["null"] = "Normal",
        },
    },
    ViMode, ViModeRightDelim, GitSignsBlock, FileNameBlock, FileNameBlockRightDelim,
    { provider = '%<%=%=' },
    InfoBlockLeftDelim, DiagnosticsBlock, FileFormat, FileSize, CursorBlockLeftDelim, CursorBlock
}

local InactiveStatusLine = {
    init = function(self)
        self.mode_color = colors.fg0
        self.bg_color = colors.bg0
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
    condition = function() return not conditions.is_active() end,
    GitSignsBlock, FileNameBlock, FileNameBlockRightDelim,
    { provider = '%<%=%=' },
    InfoBlockLeftDelim, FileFormat, FileSize
}

local HelpFileName = {
    condition = function()
        return vim.bo.filetype == 'help'
    end,
    hl = secondary_hl,
    {
        provider = delims.soft_r,
        hl = { fg = 'black' }
    },
    {
        provider = function()
            local filename = vim.api.nvim_buf_get_name(0)
            return ' ' .. vim.fn.fnamemodify(filename, ':t') .. ' '
        end,
    }
}

local SpecialStatusLine = {
    init = function(self)
        self.bg_color = colors.bg0
    end,
    condition = function()
        return conditions.buffer_matches({
            buftype = {"nofile", "help", "quickfix"},
            filetype = {"^git.*", "fugitive"}
        })
    end,
    {
        provider = function() return ' ' .. string.upper(vim.bo.filetype) .. ' ' end,
        hl = secondary_hl,
    },
    HelpFileName,
    FileNameBlockRightDelim,
    Align
}

local TerminalName = {
    provider = function()
        local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
        return "  " .. tname .. ' '
    end,
    hl = secondary_hl,
}

local TerminalStatusLine = {
    init = function(self)
        self.mode = vim.fn.mode(1)
        if conditions.is_active() then
            self.mode_color = colors.blue
            self.bg_color = colors.bg2
        else
            self.mode_color = colors.fg0
            self.bg_color = colors.bg0
        end
    end,
    condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
    end,
    hl = middle_hl,
    { condition = conditions.is_active, ViMode },
    ViModeRightDelim,
    TerminalName,
    FileNameBlockRightDelim,
    Align
}

local StatusLines = {
    hl = middle_hl,
    static = {
        group_colors = {
            Normal = colors.green,
            Oper = colors.blue,
            Insert = colors.yellow,
            Visual = colors.purple,
            Select = colors.blue,
            Replace = colors.red,
            Command = colors.blue,
            Shell = colors.red,
            Terminal = colors.blue,
        }
    },
    stop_at_first = true,
    SpecialStatusLine, TerminalStatusLine, InactiveStatusLine, ActiveStatusLine
}

require 'heirline'.setup(StatusLines)
