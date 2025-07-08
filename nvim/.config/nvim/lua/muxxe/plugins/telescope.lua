local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function project_root()
  return vim.fs.root(0, { ".git", "Cargo.toml", "package.json" }) or vim.loop.cwd()
end

-- Get current tmux session if in tmux
local function current_tmux_session()
  local handle = io.popen("tmux display-message -p '#S' 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result and #result > 0 then
      return result:gsub("%s+", "")
    end
  end

  -- Not in tmux — try to pick first attached session
  local list_handle = io.popen("tmux list-sessions -F '#S' 2>/dev/null")
  if list_handle then
    local list = list_handle:read("*a")
    list_handle:close()
    local first = list:match("([^\n]+)")
    if first then
      return first
    end
  end

  return nil
end

-- Open in current nvim window if everything else fails
local function open_with_tmux_or_nvim(file)
  local session = current_tmux_session()
  if session then
    os.execute("tmux new-window -t " .. session .. " 'nvim " .. vim.fn.fnameescape(file) .. "'")
    os.execute("i3-msg workspace 1")  -- optionally focus i3 workspace
  else
    vim.cmd("edit " .. vim.fn.fnameescape(file))
  end
end

local function create_picker_with_tmux(opts)
  opts = opts or {}
  opts.attach_mappings = function(_, map)
    map("i", "<CR>", function(prompt_bufnr)
      local entry = action_state.get_selected_entry()
      local file = entry.path or entry[1]
      actions.close(prompt_bufnr)
      open_with_tmux_or_nvim(file)
    end)
    return true
  end
  builtin.find_files(opts)
end

-- 🗂 Git-Repos
vim.keymap.set("n", "<leader>pr", function()
  create_picker_with_tmux({
    find_command = {
      "fd", "--type", "f", "--hidden", ".", vim.fn.expand("~/Desktop/My-Repos"),
    },
    prompt_title = "Search My Git Repos",
  })
end, { desc = "Find files in ~/Desktop/My-Repos" })

-- 🗂 Desktop
vim.keymap.set("n", "<leader>pd", function()
  create_picker_with_tmux({
    find_command = {
      "fd", "--type", "f", "--hidden", ".", vim.fn.expand("~/Desktop"),
    },
    prompt_title = "Search Desktop",
  })
end, { desc = "Find files in ~/Desktop" })

-- ⚙️ Config & Scripts
vim.keymap.set("n", "<leader>pc", function()
  create_picker_with_tmux({
    find_command = {
      "fd", "--type", "f", "--hidden", ".", vim.fn.expand("~/dotfiles"),
    },
    prompt_title = "Search dotfiles",
  })
end, { desc = "Find configs and scripts in dofiles folder" })

-- 🗃 Project files (buffer dir logic)
vim.keymap.set("n", "<leader>pf", function()
  local dir = vim.fn.expand("%:p")
  local stat = vim.loop.fs_stat(dir)

  if stat and stat.type == "file" then
    dir = vim.fn.fnamemodify(dir, ":h")
  elseif not stat then
    dir = vim.loop.cwd()
  end

  create_picker_with_tmux({
    cwd = dir,
    prompt_title = "Current Project Files",
    hidden = true,
  })
end, { desc = "Find project files with tmux logic" })

-- 🔥 Git files (no tmux logic)
vim.keymap.set("n", "<leader>pg", function()
  builtin.git_files({
    cwd = project_root(),
    prompt_title = "CWD Git Files",
  })
end, { desc = "Find git files in cwd" })

