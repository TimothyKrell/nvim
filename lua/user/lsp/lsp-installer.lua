local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  return
end

mason.setup()
mason_lspconfig.setup()

local util = require("lspconfig.util")
local function isVueProject(fname)
  local packagejson_path = util.find_package_json_ancestor(fname)
  local packagejson = vim.json.decode(
    table.concat(vim.fn.readfile(util.path.join(packagejson_path, 'package.json')))
  )

  local depKeys = { 'dependencies', 'devDependencies' }
  local vueDep = false
  for _, depKey in pairs(depKeys) do
    for k in pairs(packagejson[depKey]) do
      if vueDep then break end
      if string.find(k, 'vue') or string.find(k, 'nuxt') then
        vueDep = true
        break
      end
    end
  end

  return vueDep
end

local root_dir_cond = function(server_name, cond_fn)
  return function(fname)
    if not cond_fn(fname) then
      return
    end

    local default_root_dir = require('lspconfig')[server_name].document_config.default_config.root_dir
    return default_root_dir(fname)
  end
end


local opts = {}

mason_lspconfig.setup_handlers({
  function(server_name)
    opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    }
    if server_name == "sumneko_lua" then
      local sumneko_opts = require "user.lsp.settings.sumneko_lua"
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server_name == "pyright" then
      local pyright_opts = require "user.lsp.settings.pyright"
      opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server_name == "volar" then
      local volar_opts = require "user.lsp.settings.volar"
      opts = vim.tbl_deep_extend("force", volar_opts, opts)
      opts.root_dir = root_dir_cond(server_name, isVueProject)
    end

    if server_name == "tsserver" then
      opts.root_dir = root_dir_cond(server_name, function(f) 
        return not isVueProject(f)
      end)
    end

    lspconfig[server_name].setup(opts)
  end,
})
