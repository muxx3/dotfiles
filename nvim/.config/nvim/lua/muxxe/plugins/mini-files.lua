-- plugins/mini_files.lua
local M = {}

M.opts = {
  windows = {
    preview = true,
    width_focus = 25,
    height_focus = 15,
    config = {
      border = "rounded",
      style = "minimal",
      row = vim.o.lines - 18,
      col = vim.o.columns - 28,
      width = 25,
      height = 15,
      winblend = 0,
    },
  },
  options = {
    use_as_default_explorer = false,
    use_icons = true,
  },
  mappings = {
    go_in         = "l",
    go_out        = "h",
    go_in_plus    = "<CR>",
    open          = "I",
    reset         = "R",
    show_help     = "g?",
    synchronize   = "=",
    trim_left     = "<",
    trim_right    = ">",
    toggle_hidden = "H",
  },
}

M.config = function(_, opts)
  require("mini.files").setup(opts)

  -- Optional: apply highlights
  vim.cmd([[
    hi MiniFilesNormal guibg=black guifg=yellow
    hi MiniFilesBorder guibg=black guifg=black
    hi MiniFilesTitle guibg=black guifg=white
  ]])
end

M.keys = {
  {
    "<leader>ef",
    function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end,
    desc = "Open mini.files (Dir of Current File)"
  },
  {
    "<leader>ee",
    function() require("mini.files").open(vim.uv.cwd(), true) end,
    desc = "Open mini.files (cwd)"
  },
}

return M

