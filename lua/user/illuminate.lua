vim.g.Illuminate_ftblacklist = {'alpha', 'NvimTree'}
-- TODO: figure out why the default <a-n>, <a-p> commands don't work
vim.api.nvim_set_keymap('n', '<c-n>', '<cmd>lua require"illuminate".goto_next_reference()<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<c-p>', '<cmd>lua require"illuminate".goto_prev_reference()<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<c-i>', '<cmd>lua require"illuminate".textobj_select()<cr>', {noremap=true})

