local icons = require("nvim-web-devicons")
local lsp = require("feline.providers.lsp")

local palette = vim.fn["sonokai#get_palette"](vim.g.sonokai_style)

local function get_palette(key)
	return palette[key][1]
end

local colors = require("colors").colors

colors.fg0 = colors.lgrey
colors.fg1 = colors.dcharc
colors.fg2 = colors.lgrey
colors.bg = "NONE"
colors.bg0 = colors.dcharc
colors.bg2 = colors.dgrey

local properties = {
	force_inactive = {
		filetypes = {
			"packer",
			"dashboard",
			"fugitive",
			"fugitiveblame",
		},
		buftypes = { "terminal" },
		bufnames = {},
	},
}

local short_filetypes = {
	"help",
	"gitcommit",
	"gitrebase",
}

local vi_groups = {
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
}

local vi_icons = {
	n = [[  ]],
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
}

local group_colors = {
	Normal = "green",
	Oper = "blue",
	Insert = "yellow",
	Visual = "purple",
	Select = "blue",
	Replace = "red",
	Command = "blue",
	Shell = "red",
	Terminal = "blue",
}

local ffs = {
	dos = "",
	unix = "",
	mac = "",
}

local diag_constr = {
	provider = {
		err = "errors",
		warn = "warnings",
		hint = "hints",
		info = "info",
	},
	condition = {
		err = vim.diagnostic.severity.ERROR,
		warn = vim.diagnostic.severity.WARN,
		hint = vim.diagnostic.severity.HINT,
		info = vim.diagnostic.severity.INFO,
	},
	fg = {
		err = "red",
		warn = "yellow",
		hint = "green",
		info = "blue",
	},
}

local function get_vi_color()
	local group = vi_groups[vim.fn.mode()] or vi_groups["null"]
	return group_colors[group]
end

local function ternary(condition, if_true, if_false)
	if condition then
		return if_true
	else
		return if_false
	end
end

local function is_inactive_file()
	return vim.tbl_contains(properties.force_inactive.filetypes, vim.bo.filetype)
		or vim.tbl_contains(short_filetypes, vim.bo.filetype)
		or vim.tbl_contains(properties.force_inactive.buftypes, vim.bo.buftype)
end

local primary_hl = function()
	return {
		bg = get_vi_color(),
		fg = "fg1",
		style = "bold",
	}
end

local primary_inner_hl = function()
	return {
		bg = "bg2",
		fg = get_vi_color(),
	}
end

local secondary_hl = function()
	return { bg = "bg2", fg = get_vi_color() }
end

local tertiary_hl = { bg = "bg2", fg = "fg2" }
local inactive_hl = { bg = "bg0", fg = "fg0" }
local inactive_within_hl = { bg = "bg0", fg = "black" }

local mode_component = {
	provider = function()
		return vi_icons[vim.fn.mode()] or vi_icons["null"]
	end,
	hl = primary_hl,
	left_sep = "  ",
	right_sep = function()
		return { str = "right_filled", hl = primary_inner_hl() }
	end,
}

local function get_gsd(winid)
	return pcall(vim.api.nvim_buf_get_var, vim.api.nvim_win_get_buf(winid), "gitsigns_status_dict")
end

local function make_git_branch_component(active)
	return {
		provider = function(_, winid)
			local ok, gsd = get_gsd(winid)

			if not ok then
				return ""
			end

			return "  " .. gsd.head
		end,
		hl = ternary(active, secondary_hl, inactive_hl),
		enabled = function(winid)
			local ok, _ = get_gsd(winid)
			return ok
		end,
	}
end

local function make_git_component(active)
	return {
		provider = function(_, winid)
			local ok, gsd = get_gsd(winid)

			if not ok then
				return ""
			end

			local output = " "
			if gsd["added"] and gsd["added"] > 0 then
				output = output .. " " .. gsd["added"] .. " "
			end
			if gsd["removed"] and gsd["removed"] > 0 then
				output = output .. " " .. gsd["removed"] .. " "
			end
			if gsd["changed"] and gsd["changed"] > 0 then
				output = output .. "柳" .. gsd["changed"] .. " "
			end
			return output
		end,
		hl = ternary(active, tertiary_hl, inactive_hl),
		enabled = function(winid)
			local ok, _ = get_gsd(winid)
			return ok
		end,
		right_sep = ternary(active, function()
			return { str = "right", hl = secondary_hl() }
		end, {
			str = "right",
			hl = inactive_within_hl,
		}),
	}
end

local function get_fname(winid)
	return vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(winid))
end

local modified_hl_active = {
	bg = "bg2",
	fg = "orange",
}

local modified_hl_inactive = {
	bg = "bg0",
	fg = "orange",
}

local function make_file_icon_component(active, modified)
	return {
		provider = function(_, winid)
			if is_inactive_file() then
				return " "
			end

			local name = get_fname(winid)
			local ext = vim.fn.fnamemodify(name, ":e")
			return " " .. icons.get_icon(name, ext, { default = true }) .. " "
		end,
		hl = ternary(
			modified,
			ternary(active, modified_hl_active, modified_hl_inactive),
			ternary(active, secondary_hl, inactive_hl)
		),
		enabled = ternary(modified, function(winid)
			return vim.bo[vim.api.nvim_win_get_buf(winid)].modified
		end, function(winid)
			return not vim.bo[vim.api.nvim_win_get_buf(winid)].modified
		end),
	}
end

local function make_directory_component(active)
	return {
		provider = function(_, winid)
			if is_inactive_file() then
				return ""
			end

			local filename = get_fname(winid)
			filename = vim.fn.pathshorten(vim.fn.fnamemodify(filename, ":~:."))

			local dirname = vim.fn.fnamemodify(filename, ":h")
			if dirname == "." then
				return ""
			else
				return dirname .. "/"
			end
		end,
		hl = ternary(active, { fg = "lgrey", bg = "bg2" }, { fg = "xgrey", bg = "bg0" }),
	}
end

local function make_filename_component(active, modified)
	return {
		provider = ternary(modified, function(_, winid)
			local filename = vim.fn.fnamemodify(get_fname(winid), ":t")
			local tags = " ●"
			return filename .. tags .. " "
		end, function(_, winid)
			local filename = vim.fn.fnamemodify(get_fname(winid), ":t")
			local tags = " "
			if vim.bo[vim.api.nvim_win_get_buf(winid)].readonly then
				tags = tags .. ""
			end
			return filename .. tags .. " "
		end),
		hl = ternary(
			modified,
			ternary(active, modified_hl_active, modified_hl_inactive),
			ternary(active, secondary_hl, inactive_hl)
		),
		enabled = ternary(modified, function(winid)
			return vim.bo[vim.api.nvim_win_get_buf(winid)].modified
		end, function(winid)
			return not vim.bo[vim.api.nvim_win_get_buf(winid)].modified
		end),
		right_sep = "right_filled",
	}
end

local position_component = {
	provider = "position",
	hl = primary_hl,
	left_sep = function()
		return {
			str = "█",
			hl = primary_inner_hl(),
		}
	end,
	right_sep = function()
		return {
			str = "█  ",
			hl = { fg = get_vi_color(), bg = "NONE" },
		}
	end,
}

local function get_fsize()
	local suffix = { "ki", "Mi", "Gi", "Ti", "Pi", "Ei" }
	local index = 0
	local fsize = vim.fn.getfsize(vim.fn.expand("%:p"))
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

local fsize_component = {
	provider = function()
		return get_fsize()
	end,
	enabled = function()
		return vim.fn.glob(vim.fn.expand("%:p")) ~= "" and not is_inactive_file()
	end,
	hl = tertiary_hl,
	right_sep = "block",
}

local make_ff_component = function(active)
	return {
		provider = function()
			return ffs[vim.bo.ff]
		end,
		hl = ternary(active, secondary_hl, inactive_hl),
		left_sep = "block",
		right_sep = "block",
	}
end

local function make_diag_component(type, active)
	return {
		provider = "diagnostic_" .. diag_constr.provider[type],
		enabled = function()
			return lsp.diagnostics_exist(diag_constr.condition[type])
		end,
		hl = {
			fg = ternary(active, diag_constr.fg[type], "fg0"),
			bg = ternary(active, "bg2", "bg0"),
		},
	}
end

local secondary_left = {
	provider = " ",
	hl = secondary_hl,
	left_sep = "left_filled",
}

local inactive_left = {
	provider = "",
	hl = { bg = "NONE" },
	right_sep = "  ",
}

local inactive_right = {
	provider = " ",
	hl = inactive_hl,
	left_sep = {
		str = "left_filled",
		hl = { fg = "bg0" },
	},
}

local InactiveStatusHL = {
	--fg = vim.api.nvim_exec('hi VertSplit', true):match('guifg=(#%x+)') or '#444444',
	fg = "bg0",
	bg = vim.api.nvim_exec("hi VertSplit", true):match("guibg=(#%x+)") or "NONE",
	style = vim.api.nvim_exec("hi VertSplit", true):match("gui=(#[%l,]+)") or "",
}

if InactiveStatusHL.style == "" then
	InactiveStatusHL.style = "strikethrough"
else
	InactiveStatusHL.style = "strikethrough"
end

local empty_component = { provider = "", hl = InactiveStatusHL }

local components = {
	active = {
		{
			mode_component,
			make_git_branch_component(true),
			make_git_component(true),
			make_file_icon_component(true, true),
			make_file_icon_component(true, false),
			make_directory_component(true),
			make_filename_component(true, true),
			make_filename_component(true, false),
			empty_component,
		},
		{},
		{
			secondary_left,
			make_diag_component("err", true),
			make_diag_component("warn", true),
			make_diag_component("hint", true),
			make_diag_component("info", true),
			make_ff_component(true),
			fsize_component,
			position_component,
		},
	},
	inactive = {
		{
			inactive_left,
			make_git_branch_component(false),
			make_git_component(false),
			make_file_icon_component(false, true),
			make_file_icon_component(false, false),
			make_directory_component(false),
			make_filename_component(false, true),
			make_filename_component(false, false),
			empty_component,
		},
		{
			inactive_right,
			make_diag_component("err", false),
			make_diag_component("warn", false),
			make_diag_component("hint", false),
			make_diag_component("info", false),
			make_ff_component(false),
		},
	},
}

require("feline").setup({
	force_inactive = properties.force_inactive,
	components = components,
    theme = colors,
})

local to_link = { "StatusLine", "StatusLineNC", "StatusLineTerm", "StatusLineTermNC" }

for _, group in pairs(to_link) do
	vim.cmd("hi " .. group .. " guifg=" .. InactiveStatusHL.fg .. " guibg=" .. InactiveStatusHL.bg)
end

vim.opt.showmode = false
