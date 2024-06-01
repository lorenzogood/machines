local gitsigns = require 'gitsigns'
local lualine = require 'lualine'
local noice = require 'noice'
local notify = require 'notify'
local gruvbox = require 'gruvbox'

local function setup_lualine()
	local colors = {
		black        = '#282828',
		white        = '#ebdbb2',
		red          = '#fb4934',
		green        = '#b8bb26',
		blue         = '#459588',
		yellow       = '#faBD2f',
		gray         = '#928374',
		darkgray     = '#3c3836',
		lightgray    = '#504945',
		inactivegray = '#7c6f64',
	}

	local theme = {
		normal = {
			a = { bg = colors.gray, fg = colors.black, gui = 'bold' },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.darkgray, fg = colors.gray },
		},
		insert = {
			a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.lightgray, fg = colors.white },
		},
		visual = {
			a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.inactivegray, fg = colors.black },
		},
		replace = {
			a = { bg = colors.red, fg = colors.black, gui = 'bold' },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.black, fg = colors.white },
		},
		command = {
			a = { bg = colors.green, fg = colors.black, gui = 'bold' },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.inactivegray, fg = colors.black },
		},
		inactive = {
			a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
			b = { bg = colors.darkgray, fg = colors.gray },
			c = { bg = colors.darkgray, fg = colors.gray },
		},
	}

	lualine.setup({
		options = {
			icons_enabled = true,
			theme = theme,
			component_separators = { left = '', right = '' },
			section_separators = { left = '', right = '' },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = vim.go.laststatus == 3,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'diff', 'diagnostics' },
			lualine_c = { 'filename' },
			lualine_x = { 'encoding', {
				'fileformat',
				symbols = {
					unix = "",
					mac = "󰀶",
				}
			},
				'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { 'location' },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { 'filename' },
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	})
end

local function init()
	gitsigns.setup {}

	setup_lualine()

	notify.setup({
		render = "compact",
		timeout = 1000,
	})

	noice.setup({
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false,  -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	})

	gruvbox.setup {
		terminal_colors = true,
		undercurl = true,
		underline = true,
		bold = true,
		italic = {
			strings = true,
			emphasis = true,
			comments = true,
			operators = false,
			folds = true,
		},
		strikethrough = true,
		invert_selection = false,
		invert_signs = false,
		invert_tabline = false,
		invert_intend_guides = false,
		inverse = true, -- invert background for search, diffs, statuslines and errors
		contrast = "", -- can be "hard", "soft" or empty string
		palette_overrides = {},
		overrides = {},
		dim_inactive = false,
		transparent_mode = false,
	}



	vim.o.background = "dark"
	vim.cmd [[colorscheme gruvbox]]
end


return {
	init = init,
}
