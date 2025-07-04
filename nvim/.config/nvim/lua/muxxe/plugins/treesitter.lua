-- ~/.config/nvim/lua/muxxe/plugins/treesitter.lua

-- Optional build-time update
require("nvim-treesitter.install").update({ with_sync = true })

-- Main setup
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "javascript",
    "typescript",
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "rust",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" },
  },
})

