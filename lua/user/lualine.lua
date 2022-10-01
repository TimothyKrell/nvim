local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local mode = {
  function()
    return " "
  end,
  padding = { left = 0, right = 0 },
  color = {},
  cond = nil,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
}

local filetypeIcon = {
  'filetype',
  icon_only = true,
  separator = "",
  padding = { left = 1, right = 0 },
}

local filename = {
  'filename',
  file_status = true,
  newfile_status = true,
  path = 1,
  separator = "",
}

local location = {
  "location",
  padding = 0,
}

local tabs = {
  "tabs",
  icons_enabled = true,
  icon = { "裡", align = 'left' },
}

local spaces = function()
  if (vim.api.nvim_buf_get_option(0, "expandtab")) then
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  else
    return " "
  end
end

local lspbreadcrumbs = function()
  local none_display = "🙈🙊🙉"

  local ok, navic = pcall(require, 'nvim-navic')
  if not ok then
    vim.pretty_print('could not load navic')
    return "oops"
  end
  if navic.is_available() then
    local l = navic.get_location()
    -- return (l ~= "") and l or none_display
    return l or " "
  else
    return none_display
  end
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { "branch" },
    lualine_c = { diagnostics },
    lualine_x = { diff, spaces, "encoding", filetype, tabs },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
  winbar = {
    lualine_a = {},
    lualine_b = { filetypeIcon, filename },
    lualine_c = { lspbreadcrumbs },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
}
