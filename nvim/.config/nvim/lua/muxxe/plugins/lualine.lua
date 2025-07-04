local lualine = require("lualine")
local lazy_status = require("lazy.status")

local colors = {
  bg0 = "#282828",
  bg1 = "#3c3836",
  fg0 = "#fbf1c7",
  fg1 = "#ebdbb2",
  gray = "#928374",
  red = "#fb4934",
  green = "#b8bb26",
  yellow = "#fabd2f",
  pink = "#ff6eb4",
  purple = "#d3869b",
  orange = "#ff6700",
  cmd_fg = "#282828",
  cmd_bg = "#fffb00",
  cyan = "#0fb75d",
  vibrant_purple = "#ae81ff",
}

local theme = {
  normal = {
    a = { fg = colors.bg0, bg = colors.cyan, gui = "bold" },
    b = { fg = colors.fg1, bg = colors.bg1 },
    c = { fg = colors.fg1, bg = colors.bg1 },
  },
  insert = {
    a = { fg = colors.bg0, bg = colors.orange, gui = "bold" },
    b = { fg = colors.fg1, bg = colors.bg1 },
  },
  visual = {
    a = { fg = colors.bg0, bg = colors.vibrant_purple, gui = "bold" },
    b = { fg = colors.fg1, bg = colors.bg1 },
  },
  replace = {
    a = { fg = colors.bg0, bg = colors.red, gui = "bold" },
    b = { fg = colors.fg1, bg = colors.bg1 },
  },
  command = {
    a = { fg = colors.cmd_fg, bg = colors.cmd_bg, gui = "bold" },
    b = { fg = colors.cmd_fg, bg = colors.cmd_bg },
  },
  inactive = {
    a = { fg = colors.gray, bg = colors.bg1, gui = "bold" },
    b = { fg = colors.gray, bg = colors.bg1 },
    c = { fg = colors.gray, bg = colors.bg1 },
  },
}

local mode = {
  "mode",
  fmt = function(str) return " " .. str end,
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " },
}

local filename = {
  "filename",
  file_status = true,
  path = 0,
}

local branch = {
  "branch",
  icon = { "", color = { fg = colors.pink } },
  separator = "|",
}

lualine.setup({
  options = {
    theme = theme,
    icons_enabled = true,
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "|", right = "" },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch },
    lualine_c = { diff, filename },
    lualine_x = {
      {
        lazy_status.updates,
        cond = lazy_status.has_updates,
        color = { fg = colors.yellow },
      },
      "filetype",
    },
  },
})

