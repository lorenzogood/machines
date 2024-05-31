local function init() 
	require 'FoehammerVim.vim'.init()
	require 'FoehammerVim.theme'.init()
	require 'FoehammerVim.languages'.init()
end

return {
	init = init,
}
