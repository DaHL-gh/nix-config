require("dahl.lazy")
require("dahl.themes")
vim.cmd("colorscheme onedark")

require("dahl.keymap")
require("dahl.options")

require("dahl.lsp")

local function make_transparent()
	local groups = {
		'Normal',
		'NormalNC',
		'NormalFloat',
		'SignColumn',
		'StatusLine',
		'StatusLineNC',
		'EndOfBuffer',
	}
	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { bg = 'NONE', ctermbg = 'NONE' })
	end
end


vim.opt.fillchars:append({
	eob = ' ',
})
make_transparent()
vim.api.nvim_create_autocmd('ColorScheme', {
	callback = make_transparent,
})
