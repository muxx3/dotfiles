-- ~/.config/nvim/lua/muxxe/lazy.lua
-- Plugin loader setup and plugin registry

-- ╭──────────────────────────────────────────────────────────╮
-- │              [ muxxe ] Lazy.nvim Bootstrap               │
-- ╰──────────────────────────────────────────────────────────╯

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    error("lazy.nvim is not installed")
end
vim.opt.rtp:prepend(lazypath)

-- ╭────────────────────────────────────────╮
-- │             Plugin Setup               │
-- ╰────────────────────────────────────────╯
require("lazy").setup({

    -- ───────── Appearance / UI ─────────
    { "ellisonleao/gruvbox.nvim", priority = 999, config = function() require("muxxe.plugins.gruvbox")() end },
    { "folke/snacks.nvim", priority = 1000, lazy = false, opts = require("muxxe.plugins.snacks").opts, keys = require("muxxe.plugins.snacks").keys },
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("muxxe.plugins.lualine") end },
    { "nvim-tree/nvim-web-devicons", lazy = true, config = function() require("nvim-web-devicons").setup({ default = true }) end },
    { "nvzone/showkeys", lazy = false, opts = require("muxxe.plugins.showkeys").opts, config = function(_, opts) require("muxxe.plugins.showkeys").config(_, opts) end },

    -- ───────── Development Tools ─────────
    { "mason-org/mason.nvim", config = function() require("muxxe.plugins.mason") end },
    { "mason-org/mason-lspconfig.nvim", dependencies = { "mason.nvim" } },
    { "neovim/nvim-lspconfig", config = function() require("muxxe.plugins.lspconfig"); require("muxxe.plugins.diagnostics"); require("muxxe.plugins.lspkeymaps") end },
    { "hrsh7th/nvim-cmp", dependencies = { "L3MON4D3/LuaSnip", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-buffer", "saadparwaiz1/cmp_luasnip" }, config = function() require("muxxe.plugins.nvim-cmp") end },
    { "hrsh7th/cmp-nvim-lsp" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
    { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },

    -- ───────── Language Specific: Rust ─────────
    { "mrcjkb/rustaceanvim", version = "^6", lazy = false, config = function() require("muxxe.plugins.rustaceanvim") end },
    { "rust-lang/rust.vim", ft = "rust", init = function() vim.g.rustfmt_autosave = 1 end },
    { "mfussenegger/nvim-dap", config = function() require("muxxe.plugins.dap")() end },
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, config = function() require("dapui").setup() end },
    { "saecki/crates.nvim", ft = { "toml" }, config = function() require("muxxe.plugins.crates")() end },

    -- ───────── Telescope ─────────
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("muxxe.plugins.telescope") end },

    -- ───────── Treesitter ─────────
    { "nvim-treesitter/nvim-treesitter", build = function() require("muxxe.plugins.treesitter")() end },
    { "nvim-treesitter/nvim-treesitter-context" },

    -- ───────── Utility ─────────
    { "epwalsh/obsidian.nvim", config = function() require("muxxe.plugins.obsidian") end },
    { "echasnovski/mini.files", version = "*", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = require("muxxe.plugins.mini-files").opts, config = function(_, opts) require("muxxe.plugins.mini-files").config(_, opts) end, keys = require("muxxe.plugins.mini-files").keys },

    -- ───────── Misc ─────────
    { "christoomey/vim-tmux-navigator", lazy = false },
    { "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("muxxe.plugins.harpoon") end },
    { "mbbill/undotree", config = function() vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) end },
    { "ThePrimeagen/vim-be-good" },
    { "kylechui/nvim-surround", version = "^3.0.0", event = "VeryLazy", config = function() require("nvim-surround").setup({ }) end },
    { "windwp/nvim-autopairs", event = {"InsertEnter"}, dependencies = { "hrsh7th/nvim-cmp" }, config = function() require("muxxe.plugins.autopairs")() end },
    { "folke/todo-comments.nvim", event = { "BufReadPre", "BufNewFile" }, dependencies = { "nvim-lua/plenary.nvim"}, config = function() require("muxxe.plugins.todo-comments")() end },
    { 'brianhuster/live-preview.nvim', dependencies = { 'folke/snacks.nvim', }, }


})

-- ╭─────────────────────────────────────────────────╮
-- │         Autocommands & Theme Persistence        │
-- ╰─────────────────────────────────────────────────╯
local persist = require("muxxe.plugins.snacks_theme_persist")

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(ev)
        persist.save(ev.match)
    end,
})

vim.schedule(function()
    local last_theme = persist.load()
    if last_theme then
        if pcall(vim.cmd, "colorscheme " .. last_theme) then
            vim.notify("Loaded last theme → " .. last_theme)
        else
            vim.notify("⚠️ Could not load theme “" .. last_theme .. "”", vim.log.levels.WARN)
        end
    end
end)

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "Normal",         { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat",    { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder",    { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeNormal",{ bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeBorder",{ bg = "none" })
    end,
})
