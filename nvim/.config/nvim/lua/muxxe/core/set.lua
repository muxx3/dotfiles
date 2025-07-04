-- ╭────────────────────────────────────────────────────╮
-- │  [ muxxe ] Neovim Settings & Autocommands          │
-- ╰────────────────────────────────────────────────────╯

-- ╭──────────────────────────────────╮
-- │    Environment and UI Basics     │
-- ╰──────────────────────────────────╯
vim.env.TERM = "kitty"                         -- Set TERM environment (for truecolor, etc.)
vim.opt.termguicolors = true                   -- Enable 24-bit color in terminal
vim.opt.syntax = "enable"                      -- Enable syntax highlighting
vim.opt.conceallevel = 2                       -- Conceal markdown and other syntax content
-- ╭─────────────────────────────────╮
-- │     Buffer & File Behavior      │
-- ╰─────────────────────────────────╯
vim.opt.hidden = true                          -- Allow switching buffers without saving; false negates it
vim.opt.autowriteall = true                    -- Auto-save on :next, etc.
vim.opt.confirm = true                         -- Confirm before closing unsaved changes
vim.g.editorconfig = true                      -- Enable .editorconfig support

-- ─────── Wipe unnamed empty buffers on quit ───────────────────
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local name = vim.api.nvim_buf_get_name(buf)
            local modified = vim.api.nvim_buf_get_option(buf, "modified")
            if name == "" and modified then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end,
})
-- ╭──────────────────────────────────────╮
-- │           Netrw Behavior             │
-- ╰──────────────────────────────────────╯
vim.g.netrw_banner = 0                          -- Disable netrw banner

-- ╭────────────────────────────────────────╮
-- │     Clipboard / Mouse / UI Style       │
-- ╰────────────────────────────────────────╯
vim.opt.mouse = "a"                             -- Enable mouse in all modes
vim.opt.clipboard = ''                          -- Do not sync with system clipboard by default

vim.opt.title = true
vim.opt.titlestring = "Neovim %t"               -- Custom terminal title

vim.opt.signcolumn = "yes"                      -- Always show the sign column
vim.opt.scrolloff = 8                           -- Keep 8 lines above/below cursor
vim.opt.colorcolumn = "80"                      -- Highlight column 80
vim.opt.isfname:append("@-@")                   -- Treat @ as filename character

vim.opt.spell = true                            -- Set spell check to true (on)
vim.opt.spelllang = "en_us"                     -- You can replace "en_us" with your desired language


-- ╭───────────────────────────╮
-- │   Numbering & Searching   │
-- ╰───────────────────────────╯
vim.opt.nu = true                               -- Show line numbers
vim.opt.relativenumber = true                   -- Show relative line numbers

vim.opt.hlsearch = true                         -- Highlight search results
vim.opt.incsearch = true                        -- Show search results as you type

-- ╭────────────────────────╮
-- │  Indentation and Tabs  │
-- ╰────────────────────────╯
vim.opt.tabstop = 4                             -- Display 4 spaces for a tab
vim.opt.softtabstop = 4                         -- Use 4 spaces when tabbing
vim.opt.shiftwidth = 4                          -- Use 4 spaces when auto-indenting
vim.opt.expandtab = true                        -- Convert tabs to spaces
vim.opt.smartindent = true                      -- Auto-indent new lines intelligently
vim.opt.wrap = false

-- ╭──────────────────────────────╮
-- │    File Storage & Backups    │
-- ╰──────────────────────────────╯
vim.opt.swapfile = false                        -- Disable swapfile
vim.opt.backup = false                          -- Disable backup
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Persistent undo dir
vim.opt.undofile = true                         -- Enable persistent undo

-- ╭─────────────────╮
-- │   Performance   │
-- ╰─────────────────╯
vim.opt.updatetime = 50                         -- Faster updates (good for plugins like gitgutter)

