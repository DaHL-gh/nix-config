local default_opts = { noremap = true, silent = true, desc = "..." }

local function update_table(from, to)
	local result = vim.deepcopy(from or nil)

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


map_cmd("n", "-", "Oil", { desc = "go to file directory"})
map_cmd("n", "<leader>o", { "update", "source" }, { desc = "update config?" })

map_action({ "n", "v" }, "<leader>y", "\"+y", { desc = "buffer yoink" })
map_action({ "n", "v" }, "<leader>d", "\"+d", { desc = "buffer yoink" })

-- Lazy
map_cmd("n", "<leader>L", "Lazy", { desc = "Lazy" })

-- LSP
map({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, nil, { desc = "format" })
map("n", "<leader>cr", vim.lsp.buf.rename, nil, { desc = "rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, nil, { desc = "code actions" })
map("n", "<leader>cd", vim.diagnostic.open_float, nil, { desc = "diagnostics" })
map("n", "gd", vim.lsp.buf.definition, nil, { desc = "LSP definition" })
map("n", "gr", vim.lsp.buf.references, nil, { desc = "LSP references" })
map("n", "gD", vim.lsp.buf.declaration, nil, { desc = "LSP declaration" })
map("n", "gI", vim.lsp.buf.implementation, nil, { desc = "LSP implementation" })
map("n", "<leader>ci", vim.lsp.buf.incoming_calls, nil, { desc = "function calls" })
map("n", "<leader>co", vim.lsp.buf.outgoing_calls, nil, { desc = "in function calls" })
map("n", "<leader>ch", vim.lsp.buf.typehierarchy, nil, { desc = "type hierarchy" })

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
local telescope = require("telescope.builtin")
local opts = require("telescope.themes").get_ivy({})
map("n", "<leader>fb", telescope.buffers, opts, { desc = "buffers" })
map("n", "<leader>ff", telescope.find_files, opts, { desc = "find files" })
map("n", "<leader>fl", telescope.live_grep, opts, { desc = "live grep" })
map("n", "<leader>fh", telescope.help_tags, opts, { desc = "live grep" })
map("n", "<leader>fs", telescope.colorscheme, opts, { desc = "file versions" })
map("n", "<leader>fv", telescope.git_bcommits, opts, { desc = "file versions" })
map("n", "<leader>fB", telescope.git_branches, opts, { desc = "branches" })
map("n", "<leader>fc", telescope.git_commits, opts, { desc = "commits" })

-- quickfix / loclist
map_cmd("n", "<leader>qo", "copen", { desc = "qflist close" })
map_cmd("n", "<leader>lo", "lopen", { desc = "loclist close" })
map_cmd("n", "<leader>qc", "cclose", { desc = "qflist close" })
map_cmd("n", "<leader>lc", "lclose", { desc = "loclist close" })
map("n", "<leader>qd", vim.diagnostic.setqflist, nil, { desc = "qflist diagnostics" })
map("n", "<leader>ld", vim.diagnostic.setloclist, nil, { desc = "loclist diagnostics" })
map_cmd("n", "<leader>qg", "Gitsigns setqflist", { desc = "qflist git hunks" })
map_cmd("n", "<leader>lg", "Gitsigns setloclist", { desc = "loclist git hunks" })

-- Molten
map_cmd("n", "<leader>mI", "MoltenInfo", { desc = "Molten info" })
map_cmd("n", "<leader>mi", "MoltenInit", { desc = "Molten initialize" })
map_cmd("n", "<leader>ms", "MoltenInterrupt", { desc = "Molten interrupt(stop)" })
map_cmd("n", "<leader>mr", "MoltenRestart", { desc = "Molten restart" })
map_cmd("n", "<leader>mR", "MoltenRestart!", { desc = "Molten hard restart" })
map_cmd("n", "<leader>md", "MoltenDelete", { desc = "Molten delete current cell" })
map_cmd("n", "<leader>mD", "MoltenDeinit", { desc = "Molten deinit, kill runtime" })
map_cmd("n", "<leader>mx", "MoltenOpenInBrowser", { desc = "Molten open output in browser" })
map_cmd("n", "<leader>ml", "MoltenImportOutput", { desc = "Molten load outputs from notebook" })

map_cmd("n", "]c", "MoltenNext", { desc = "next Molten cell" })
map_cmd("n", "[c", "MoltenPrev", { desc = "prev Molten cell" })

map_cmd("n", "<leader>eo", "MoltenEvaluateOperator", { desc = "Molten eval operator" })
map_action("v", "<leader>e", "<Esc>:MoltenEvaluateVisual<CR>gv")
map_cmd("n", "<leader>ev", "MoltenEvaluateVisual", { desc = "Molten eval visual" })
map_cmd("n", "<leader>el", "MoltenEvaluateLine", { desc = "Molten eval line" })
map_cmd("n", "<leader>ee", "MoltenReevaluateCell", { desc = "Molten reeval last" })

map_cmd("n", "<leader>oh", "MoltenHideOutput", { desc = "Molten hide output" })
map_cmd("n", "<leader>os", "noautocmd MoltenEnterOutput", { desc = "Molten show output" })
