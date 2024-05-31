local function init() 
	require 'FoehammerVim.vim'.init()
	require 'FoehammerVim.theme'.init()
end

return {
	init = init,
}
