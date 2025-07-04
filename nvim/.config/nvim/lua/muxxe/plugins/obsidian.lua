-- lua/plugins/obsidian.lua

local obsidian = require("obsidian")

obsidian.setup({
  workspaces = {
    {
      name = "notes",
      path = "~/Desktop/notes",
    },
  },
  completion = { nvim_cmp = true },
  picker = { name = "telescope.nvim" },
  sort_by = "modified",
  new_notes_location = "notes_subdir",
  templates = {
    subdir = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    substitutions = {},
  },
  note_id_func = function(title)
    return title
      and title:gsub(" ", "-")
               :gsub("[^a-zA-Z0-9%-]", "")
               :lower()
      or tostring(os.time())
  end,
})

