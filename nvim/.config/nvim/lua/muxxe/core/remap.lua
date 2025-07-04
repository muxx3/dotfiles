-- ╭───────────────────────────────────────────────╮
-- │    [ muxxe ] Neovim Keymaps and Autocmds      │
-- ╰───────────────────────────────────────────────╯
local opts = { noremap = true, silent = true }

-- ───────── Set space as leader key ──────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ╭────────────────────────────────────╮
-- │         Basic File Navigation      │
-- ╰────────────────────────────────────╯
vim.keymap.set("n", "<leader>fd", ":Ex<CR>", opts) -- File explorer (netrw)

-- ╭────────────────────────────────────╮
-- │     Cursor Movement Enhancements   │
-- ╰────────────────────────────────────╯
vim.keymap.set("n", "J", "mzJ`z")          -- Join line, keep cursor position
vim.keymap.set("n", "<C-d>", "<C-d>zz")    -- Scroll down, keep cursor centered
vim.keymap.set("n", "<C-u>", "<C-u>zz")    -- Scroll up, keep cursor centered
vim.keymap.set("n", "n", "nzzzv")          -- Center on search match
vim.keymap.set("n", "N", "Nzzzv")          -- Center on search match

-- ╭────────────────────────────────────╮
-- │        Visual Mode Movement        │
-- ╰────────────────────────────────────╯
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")  -- Move selected lines down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")  -- Move selected lines up

-- ╭────────────────────────────────────────────╮
-- │   Preserve Paste/Clipboard While Replacing │
-- ╰────────────────────────────────────────────╯
vim.keymap.set("x", "<leader>p", "\"_dP")  -- Paste without overwriting clipboard
vim.keymap.set("x", "p", "\"_dp", opts)    -- Same as above for `p`
--vim.keymap.set("v", "d", "\"_d")           -- Delete to blackhole
vim.keymap.set("n", "dd", "\"_dd")
vim.keymap.set("n", "x", "\"_x")
vim.keymap.set("n", "X", "\"_X")
vim.keymap.set("v", "x", "\"_x")
vim.keymap.set("v", "X", "\"_X")
--vim.keymap.set("n", "c", "\"_c")           -- Change to blackhole
vim.keymap.set("v", "c", "\"_c")

-- ╭────────────────────────────────────╮
-- │      Yank to System Clipboard      │
-- ╰────────────────────────────────────╯
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- ╭────────────────────────────────────╮
-- │     Miscellaneous Usability        │
-- ╰────────────────────────────────────╯
vim.keymap.set("n", "Q", "<nop>")  -- Disable annoying `Q`
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- ───────── Command mode navigation ──────────────────
vim.api.nvim_set_keymap('c', '<C-h>', '<Left>', opts)
vim.api.nvim_set_keymap('c', '<C-l>', '<Right>', opts)
vim.api.nvim_set_keymap('c', '<C-j>', '<Backspace>', opts)

-- ───────── Replace word under cursor globally ──────────────────
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- ───────── Make current file executable ──────────────────
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- ───────── C-c clears highlights ──────────────────
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clears search hl", silent = true })

-- ╭────────────────────────────────────╮
-- │        Yank Highlight on Copy      │
-- ╰────────────────────────────────────╯
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ╭────────────────────────────────────╮
-- │         Debugger (nvim-dap)        │
-- ╰────────────────────────────────────╯
vim.keymap.set("n", "<leader>dl", function() require'dap'.step_into() end, { desc = "DAP: Step into" })
vim.keymap.set("n", "<leader>dj", function() require'dap'.step_over() end, { desc = "DAP: Step over" })
vim.keymap.set("n", "<leader>dk", function() require'dap'.step_out() end, { desc = "DAP: Step out" })
vim.keymap.set("n", "<leader>dc", function() require'dap'.continue() end, { desc = "DAP: Continue" })
vim.keymap.set("n", "<leader>db", function() require'dap'.toggle_breakpoint() end, { desc = "DAP: Toggle breakpoint" })
vim.keymap.set("n", "<leader>dd", function()
  require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = "DAP: Conditional breakpoint" })
vim.keymap.set("n", "<leader>de", function() require'dap'.terminate() end, { desc = "DAP: Terminate" })
vim.keymap.set("n", "<leader>dr", function() require'dap'.run_last() end, { desc = "DAP: Run last" })

-- ───────── Rust LSP Testables ──────────────────
vim.keymap.set("n", "<leader>dt", function() vim.cmd("RustLsp testables") end, { desc = "RustLsp: Testables" })

-- ╭───────────────────────────────────────────────╮
-- │     Tmux-Aware Terminal from Project Root     │
-- ╰───────────────────────────────────────────────╯
vim.keymap.set("n", "<leader>t", function()
  local root = vim.fn.expand("%:p:h")
  if root == "" then root = vim.fn.getcwd() end
  root = vim.fn.shellescape(root)
  vim.fn.jobstart("tmux split-window -v -c " .. root, { detach = true })
end, { desc = "Open shell in tmux split (project dir)" })

-- ╭───────────────────────────────────────────────╮
-- │         FZF Wrapper: TMUX-aware open          │
-- ╰───────────────────────────────────────────────╯
vim.keymap.set("n", "<C-f>", function()
  local fzf_cmd = "/home/muxee/.scripts/fzf_wrapper.sh | xargs -r nvim"
  if vim.env.TMUX then
    vim.fn.system("tmux new-window -c $PWD '" .. fzf_cmd .. "'")
  else
    vim.fn.jobstart({ "kitty", "--detach", "sh", "-c", fzf_cmd }, { detach = true })
  end
end, { noremap = true, silent = true })


