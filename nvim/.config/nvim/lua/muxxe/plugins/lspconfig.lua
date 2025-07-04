-- lua/plugins/lspconfig.lua
local lspconfig = require("lspconfig")
local caps = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  "html", "cssls", "ts_ls", "eslint",
  "taplo", "bashls", "lua_ls",
  "jsonls", "yamlls", "dockerls", "marksman",
}

for _, server in ipairs(servers) do
  local opts = { capabilities = caps }

  if server == "lua_ls" then
    opts.settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      }
    }
  end

  lspconfig[server].setup(opts)
end

