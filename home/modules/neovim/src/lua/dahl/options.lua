vim.opt.winborder = "rounded"
vim.opt.tabstop = 4
vim.opt.ignorecase = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"


vim.opt.fillchars:append { diff = "╱" }

vim.diagnostic.config({
	virtual_text = {
		source = "if_many",
		severity = { min = vim.diagnostic.severity.WARN },
		prefix = "x",
		hl_mode = "blend",
	},
	-- virtual_lines = {
	-- 	current_line = true,
	-- },
	severity_sort = true,
})
