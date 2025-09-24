-- lua/plugins/lspconfig.lua
local lspconfig = require("lspconfig")
local caps = require("cmp_nvim_lsp").default_capabilities()

local servers = {
    "html", "cssls", "ts_ls", "eslint",
    "taplo", "bashls", "lua_ls",
    "jsonls", "yamlls", "dockerls", "marksman", "pylsp",
}



