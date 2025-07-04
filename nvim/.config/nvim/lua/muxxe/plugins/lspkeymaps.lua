-- lua/plugins/lsp_keymaps.lua
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local buf, opts = event.buf, { buffer = event.buf }
    vim.keymap.set("n", "K",  vim.lsp.buf.hover,           opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition,      opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration,     opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation,  opts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references,      opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help,  opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename,        opts)
    vim.keymap.set({ "n","x" }, "<F3>", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action,   opts)
  end,
})

