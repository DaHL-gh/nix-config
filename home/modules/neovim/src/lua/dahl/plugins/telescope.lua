return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
	},
	opts = {
		pickers = {
			colorscheme = {
				enable_preview = true
			},
			find_files = {
				hidden = true
			}
		}
	}
}
