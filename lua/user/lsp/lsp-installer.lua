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
    end

    lspconfig[server_name].setup(opts)
  end,
})
