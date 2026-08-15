return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	main = "nvim-treesitter",
	build = function()
		require("nvim-treesitter").install()
	end,
	init = function()
		-- Enable treesitter highlighting and indent (no longer in setup())
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		-- ensure_installed equivalent: install missing parsers on startup
		local ensure_installed = {
			"bash",
			"css",
			"diff",
			"dockerfile",
			"gitignore",
			"go",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"nix",
			"prisma",
			"python",
			"query",
			"rust",
			"toml",
			"tsx",
			"typescript",
			"typst",
			"vim",
			"vimdoc",
			"yaml",
		}
		local installed = require("nvim-treesitter.config").get_installed()
		local missing = vim.iter(ensure_installed)
			:filter(function(p) return not vim.tbl_contains(installed, p) end)
			:totable()
		if #missing > 0 then
			require("nvim-treesitter").install(missing)
		end
	end,
}
