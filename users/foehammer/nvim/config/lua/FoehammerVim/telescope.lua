local telescope = require 'telescope'
local actions = require 'telescope.actions'

local function init()
	telescope.setup {
		defaults = {
			file_ignore_patterns = {
				"node_modules/.*",
				"%.pem"
			},
			layout_strategy = "flex",
			layout_config = {
				horizontal = {
					prompt_position = "bottom",
					preview_width = 0.55,
				},
				vertical = { mirror = false },
				width = 0.87,
				height = 0.8,
				preview_cutoff = 125,
			},
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<C-u>"] = false,
					["<c-d>"] = actions.delete_buffer + actions.move_to_top,
				},
			},
		}
	}

	telescope.load_extension('notify')

	local options = { noremap = true, silent = true }

	vim.keymap.set('n', '<leader>ff', '<CMD>lua require ("telescope.builtin").find_files()<CR>', options)
	vim.keymap.set('n', '<leader>fg', '<CMD>lua require ("telescope.builtin").live_grep()<CR>', options)
	vim.keymap.set('n', '<leader>cd', '<CMD>lua require ("telescope.builtin").diagnostics()<CR>', options)
end

return {
	init = init,
}
