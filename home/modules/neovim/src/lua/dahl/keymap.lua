local default_opts = { noremap = true, silent = true, desc = "..." }

local function update_table(from, to)
	local result = vim.deepcopy(from or {})

	for k, v in pairs(to) do
		result[k] = v
	end

	return result
end

local function map_cmd(mode, binding, command, opts)
	if opts then
		opts = update_table(default_opts, opts)
	else
		opts = default_opts
	end

	if type(command) == "string" then
		command = { command }
	end

	local cmd_str = ""
	for _, cmd in ipairs(command) do
		cmd_str = cmd_str .. "<cmd>" .. cmd .. "<CR>"
	end

	vim.keymap.set(mode, binding, cmd_str, opts)
end

local function map_action(mode, binding, action, opts)
	if opts then
		opts = update_table(default_opts, opts)
	else
		opts = default_opts
	end

	vim.keymap.set(mode, binding, action, opts)
end

local function map(mode, binding, func, args, opts)
	if opts then
		opts = update_table(default_opts, opts)
	else
		opts = default_opts
	end

	if args then
		vim.keymap.set(mode, binding, function() func(args) end, opts)
	else
		vim.keymap.set(mode, binding, func, opts)
	end
end


map_cmd("n", "<leader>o", { "update", "source" }, { desc = "update config?" })

map_cmd({ "n", "v" }, "<C-q>", "q", { desc = "close window" })
map_cmd({ "n", "v" }, "<leader>Q", "qa", { desc = "close all windows" })
map_action({ "n", "v" }, "<leader>y", "\"+y", { desc = "buffer yoink" })
map_action({ "n", "v" }, "<leader>d", "\"+d", { desc = "buffer yoink" })

-- NeoTree
map_cmd("n", "<leader><Tab>", "Neotree toggle", { desc = "neotree" })

-- Lazy
map_cmd("n", "<leader>L", "Lazy", { desc = "Lazy" })

-- LSP
map({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, {}, { desc = "format" })
map("n", "<leader>cr", vim.lsp.buf.rename, {}, { desc = "rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, {}, { desc = "code actions" })
map("n", "<leader>cd", vim.diagnostic.open_float, {}, { desc = "diagnostics" })
map("n", "gd", vim.lsp.buf.definition, {}, { desc = "LSP definition" })
map("n", "gr", vim.lsp.buf.references, {}, { desc = "LSP references" })
map("n", "gD", vim.lsp.buf.declaration, {}, { desc = "LSP declaration" })
map("n", "gI", vim.lsp.buf.implementation, {}, { desc = "LSP implementation" })
map("n", "<leader>ci", vim.lsp.buf.incoming_calls, {}, { desc = "function calls" })
map("n", "<leader>co", vim.lsp.buf.outgoing_calls, {}, { desc = "in function calls" })
map("n", "gt", vim.lsp.buf.type_definition, {}, { desc = "LSP type definition" })
map("n", "<leader>ch", vim.lsp.buf.typehierarchy, {}, { desc = "type hierarchy" })

-- GIT
map_cmd("n", "<leader>gb", "Gitsigns blame_line", { desc = "blame line" })
map_cmd("n", "<leader>gB", "Gitsigns blame", { desc = "blame" })
map_cmd("n", "<leader>gd", "Gitsigns diffthis", { desc = "diff this" })
map_cmd("n", "<leader>gr", "Gitsigns reset_hunk", { desc = "reset hunk" })
map_cmd("n", "<leader>gR", "Gitsigns reset_buffer", { desc = "reset buffer" })
map_cmd("n", "<leader>gi", "Gitsigns reset_buffer_index", { desc = "reset to index" })
map_cmd("n", "<leader>gs", "Gitsigns stage_hunk", { desc = "stage hunk" })
map_cmd("n", "<leader>gS", "Gitsigns stage_buffer", { desc = "stage buffer" })
map_cmd("n", "<leader>gp", "Gitsigns preview_hunk_inline", { desc = "preview hunk" })

map_cmd("n", "]h", "Gitsigns next_hunk", { desc = "next hunk" })
map_cmd("n", "[h", "Gitsigns prev_hunk", { desc = "prev hunk" })
map_cmd({ "x", "o" }, "ih", "Gitsigns select_hunk", { desc = "inner git hunk" })

-- Telescope
map_cmd("n", "<leader>tb", "Telescope buffers", { desc = "buffers" })
map_cmd("n", "<leader>tf", "Telescope find_files", { desc = "find files" })
map_cmd("n", "<leader>tl", "Telescope live_grep", { desc = "live grep" })
map_cmd("n", "<leader>tv", "Telescope git_bcommits", { desc = "file versions" })
map_cmd("n", "<leader>tB", "Telescope git_branches", { desc = "branches" })
map_cmd("n", "<leader>tc", "Telescope git_commits", { desc = "commits" })

-- quickfix / loclist
map_cmd("n", "<leader>qc", "cclose", { desc = "qflist close" })
map_cmd("n", "<leader>lc", "lclose", { desc = "loclist close" })
map("n", "<leader>qd", vim.diagnostic.setqflist, {}, { desc = "qflist diagnostics" })
map("n", "<leader>ld", vim.diagnostic.setloclist, {}, { desc = "loclist diagnostics" })
map_cmd("n", "<leader>qg", "Gitsigns setqflist", { desc = "qflist git hunks" })
map_cmd("n", "<leader>lg", "Gitsigns setloclist", { desc = "loclist git hunks" })
