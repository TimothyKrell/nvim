local ok, trouble = pcall(require, 'trouble')
if not ok then return end

trouble.setup()

require('which-key').register({
  ["<leader>lt"] = { "<cmd>TroubleToggle<CR>", "Trouble" }
})
