local function set_vim_g()
	vim.g.mapleader = ' '
	vim.g.maplocalleader = ' '
end

local function set_vim_opt()
	local settings = {
		relativenumber = true,
		number = true,
		showmode = false,
		clipboard = 'unnamedplus',
		breakindent = true,
		undofile = true,
		ignorecase = true,
		smartcase = true,
		signcolumn = 'yes',
		updatetime = 250,
		timeoutlen = 300,
		splitright = true,
		splitbelow = true,
		inccommand = 'split',
		cursorline = true,
		scrolloff = 10,
		hlsearch = true,
		termguicolors = true,
		tabstop = 4,
		shiftwidth = 4
	}

	for k, v in pairs(settings) do
		vim.opt[k] = v
	end
end

local function set_vim_keymaps()
	local options = { noremap = false, silent = true }

	vim.keymap.set('n', '<leader>h', '<CMD>wincmd h<CR>', options)
	vim.keymap.set('n', '<leader>j', '<CMD>wincmd j<CR>', options)
	vim.keymap.set('n', '<leader>k', '<CMD>wincmd k<CR>', options)
	vim.keymap.set('n', '<leader>l', '<CMD>wincmd l<CR>', options)
	vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

	-- Bandaid Peel
	vim.keymap.set('n', '<left>', '<Nop>')
	vim.keymap.set('n', '<right>', '<Nop>')
	vim.keymap.set('n', '<up>', '<Nop>')
	vim.keymap.set('n', '<down>', '<No')
end


local function init()
	vim.loader.enable()
	set_vim_g()
	set_vim_opt()
	set_vim_keymaps()
end

return {
	init = init,
}
