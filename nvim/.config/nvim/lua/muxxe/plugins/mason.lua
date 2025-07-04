require("mason").setup()
require("mason-lspconfig").setup ({
    ensure_installed = {
        "html",
        "cssls",
        "ts_ls",
        "eslint",
        -- "gopls",      
        "taplo",
        "bashls",
        "lua_ls",
        "jsonls",
        "yamlls",
        "dockerls",
        "marksman",
    },
    automatic_installation = true,
})

