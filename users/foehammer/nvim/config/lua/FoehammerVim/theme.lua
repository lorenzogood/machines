local colorizer = require 'colorizer'
local comment = require 'Comment'
local gitsigns = require 'gitsigns'
local lualine = require 'lualine'
local noice = require 'noice'
local notify = require 'notify'
local gruvbox = require 'gruvbox'

local function init()
	colorizer.setup {}

	comment.setup {}

	gitsigns.setup {}

	lualine.setup {
		options = {
			theme = "gruvbox",
		},
	}

	notify.setup({
		render = "compact",
		timeout = 2500,
	})

	require("noice").setup({
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
