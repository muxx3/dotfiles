-- lua/plugins/diagnostics.lua
vim.diagnostic.config({
  virtual_text     = true,
  signs            = true,
  underline        = true,
  update_in_insert = true,
})

-- optional: update quickfix on change
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  callback = function()
    vim.diagnostic.setqflist({ open = false })
  end,
})

