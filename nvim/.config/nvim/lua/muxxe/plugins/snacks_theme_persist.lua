local M = {}

-- We’ll store last_snacks_theme.txt in your config root (~/config/nvim/)
local theme_file = vim.fn.stdpath("config") .. "/last_snacks_theme.txt"

function M.save(theme_name)
  local f = io.open(theme_file, "w")
  if f then
    f:write(theme_name)
    f:close()
    vim.notify("⚡ Saved theme → " .. theme_name)
  else
    vim.notify("⚠️  Failed to write " .. theme_file, vim.log.levels.ERROR)
  end
end

function M.load()
  local f = io.open(theme_file, "r")
  if f then
    local theme_name = f:read("*l")
    f:close()
    return theme_name
  end
  return nil
end

return M

