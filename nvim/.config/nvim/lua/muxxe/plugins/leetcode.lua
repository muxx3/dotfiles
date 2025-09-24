return function()
    local status_ok, leetcode = pcall(require, "leetcode")
    if not status_ok then
        return
    end

    leetcode.setup({
        ---@type string
        arg = "leetcode.nvim",

        ---@type lc.lang
        lang = "rust",

        cn = {
            enabled = false,
            translator = true,
            translate_problems = true,
        },

        storage = {
            home = vim.fn.stdpath("data") .. "/leetcode",
            cache = vim.fn.stdpath("cache") .. "/leetcode",
        },

        plugins = {
            non_standalone = false,
        },

        logging = true,
        injector = {},

        cache = {
            update_interval = 60 * 60 * 24 * 7, -- 7 days
        },

        editor = {
            reset_previous_code = false,
            fold_imports = false,
        },

        console = {
            open_on_runcode = true,
            dir = "row",
            size = { width = "90%", height = "75%" },
            result = { size = "60%" },
            testcase = { virt_text = true, size = "40%" },
        },

        description = { position = "left", width = "40%", show_stats = true },

        picker = { provider = nil },

        hooks = {
            enter = {},
            question_enter = {},
            leave = {},
        },

        keys = {
            toggle = { "q" },
            confirm = { "<CR>" },
            reset_testcases = "r",
            use_testcase = "U",
            focus_testcases = "H",
            focus_result = "L",
        },

        theme = {},
        image_support = false,
    })
end

