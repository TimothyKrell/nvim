local colors = require("catppuccin.palettes").get_palette()
require("catppuccin").setup({
  custom_highlights = {
    ScrollbarHandle = { bg = colors.red }
  }
})
