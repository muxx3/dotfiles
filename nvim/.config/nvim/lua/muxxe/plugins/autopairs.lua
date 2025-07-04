return function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
        check_ts = true, -- enable treesitter
        ts_config = {
            lua = { "string" },
            javascript = { "template_string" },
            java = false,
        },
        fast_wrap = {}, -- optional, for <M-e> wrapping
    })

    -- Integrate with nvim-cmp
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if cmp_status_ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
end

