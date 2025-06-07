return {
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>tt",
                "<cmd>Trouble todo toggle focus=true<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>td",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>tn",
                "<cmd>Trouble diagnostics next follow=true<cr>",
                desc = "Next Diagnostic (Trouble)",
            },
            {
                "<leader>tp",
                "<cmd>Trouble diagnostics prev follow=true<cr>",
                desc = "Next Diagnostic (Trouble)",
            },
        }
        -- config = function ()
        --     -- jump to the next item, skipping the groups
        --     vim.keymap.set("n", "<leader>[d", function()
        --         require("trouble").next({skip_groups = true, jump = true})
        --     end);

        --     -- jump to the previous item, skipping the groups
        --     vim.keymap.set("n", "<leader>]d", function()
        --         require("trouble").previous({skip_groups = true, jump = true})
        --     end);
        -- end
    },
}
