return function()
  local todo_comments = require("todo-comments")

  todo_comments.setup({
    keywords = {
      FIX = {
        icon = " ",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning", alt = { "DON SKIP" } },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO", "READ", "COLORS" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
  })

  -- All keymaps go here if you're returning a function:
  vim.keymap.set("n", "]t", function()
    todo_comments.jump_next()
  end, { desc = "Next todo comment" })

  vim.keymap.set("n", "[t", function()
    todo_comments.jump_prev()
  end, { desc = "Previous todo comment" })

  vim.keymap.set("n", "<leader>pt", function()
    require("snacks").picker.todo_comments()
  end, { desc = "Todo" })

  vim.keymap.set("n", "<leader>pT", function()
    require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
  end, { desc = "Todo/Fix/Fixme" })
end

