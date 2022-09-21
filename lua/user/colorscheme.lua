local colorscheme = "catppuccin"

vim.g.tokyonight_style = "night"
vim.g.catppuccin_flavour = "macchiato"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
