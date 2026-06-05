return {
	"shellRaining/hlchunk.nvim",
	opts = {
		indent = {
			enable = true,
			chars = { "│" },
		},
		chunk = {
			enable = true,
			straight = true,
			chars = {
				-- horizontal_line = "─",
				vertical_line = "│",
				-- left_top = "┌",
				-- left_bottom = "└",
				-- right_arrow = "─",
			},
			delay = 0,
			style = "#ab5dc3"
		},
		line_num = {
			enable = false,
		},
		-- blank = {
		-- 	enable = true,
		-- 	chars = { " " },
		-- 	style = {
		-- 		{ fg = "#222222" }
		-- 	}
		-- },
	}
}
