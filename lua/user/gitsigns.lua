local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

-- local pipe = "▎"
local pipe = "┃"
-- local arrow = ""
-- local arrow = "契"

gitsigns.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = pipe, numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = pipe, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = pipe, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
}
