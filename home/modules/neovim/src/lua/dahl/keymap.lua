local default_opts = { noremap = true, silent = true }

local function map_cmd(mode, binding, command, opts)
	opts = opts or default_opts
	vim.keymap.set(mode, binding, ":" .. command .. "<CR>", opts)
end

local function map(mode, binding, func, args, opts)
	opts = opts or default_opts
	if args then
		vim.keymap.set(mode, binding, function() func(args) end, opts)
	else
		vim.keymap.set(mode, binding, func, opts)
	end
end


-- NeoTree
map_cmd("n", "<leader><Tab>", "Neotree toggle")

-- Lazy
map_cmd("n", "<leader>L", "Lazy")

-- LSP
map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<leader>lr", vim.lsp.buf.rename)
map("n", "<leader>la", vim.lsp.buf.code_action)
map("n", "<leader>ld", vim.diagnostic.open_float)

map("n", "<leader>ln", vim.diagnostic.jump, { count = 1, float = true })
map("n", "<leader>lp", vim.diagnostic.jump, { count = -1, float = true })

-- GIT
