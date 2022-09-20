-- local guifont = "FiraCode Nerd Font Mono"
-- local guifontSize = 14
local guifont = "DankMono Nerd Font"
local guifontSize = 16
-- local guifont = "Comic Code Ligatures"
-- local guifont = "ComicCodeLigatures Nerd Font"
-- local guifontSize = 14
-- local guifont = "MonoLisa Nerd Font"
-- local guifontSize = 16
vim.o.guifont = guifont .. ":h" .. guifontSize
-- vim.o.guifont = "FiraCode Nerd Font Mono:h14"
-- vim.o.guifont = "DankMono Nerd Font:h16"
-- vim.o.guifont = "Victor Mono:h14"
-- vim.o.guifont = "MonoLisa:h16"
-- vim.o.guifont = "MonoLisa Nerd Font:h16"

-- allow changing fontsize in neovide
local currentFontSize = guifontSize
local function adjustFontSize(amount)
  amount = amount or 0
  currentFontSize = amount == 0 and guifontSize or currentFontSize + amount
  vim.o.guifont = guifont .. ":h" .. currentFontSize
end

vim.keymap.set('', '<D-+>', function() adjustFontSize(1) end)
vim.keymap.set('', '<C-+>', function() adjustFontSize(1) end)
vim.keymap.set('', '<D-->', function() adjustFontSize(-1) end)
vim.keymap.set('', '<C-->', function() adjustFontSize(-1) end)
vim.keymap.set('', '<D-0>', function() adjustFontSize() end)
vim.keymap.set('', '<C-0>', function() adjustFontSize() end)

vim.g.neovide_cursor_vfx_mode = "railgun"
