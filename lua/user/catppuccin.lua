local colors = require("catppuccin.palettes").get_palette()
require("catppuccin").setup({
	styles = {
		functions = { "italic" },
	},
	integrations = {
		ts_rainbow = true,
		gitsigns = true,
	},
	custom_highlights = {
		ScrollbarHandle = { bg = colors.red },
	},
})
