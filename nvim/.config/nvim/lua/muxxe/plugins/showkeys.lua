-- plugins/showkeys.lua
local M = {}

M.opts = {
  position   = "bottom-center",
  maxkeys    = 3,
  show_count = true,
  winopts    = {
    focusable = false,
    relative  = "editor",
    style     = "minimal",
    border    = "single",
    height    = 1,
    row       = 1,
    col       = 0,
    zindex    = 100,
  },
}

M.config = function(_, opts)
  local showkeys = require("showkeys")
  showkeys.setup(opts)
  showkeys.toggle(true)
end

return M

