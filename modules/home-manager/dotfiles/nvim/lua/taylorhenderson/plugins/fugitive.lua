return {
    {
        "tpope/vim-fugitive",
        lazy = true,
        keys = {
            { "<leader>gg", "", desc = "fugitive toggle" },
        },
        config = function ()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
            vim.keymap.set("n", "<leader>gp", function () vim.cmd("Git push")end )
        end,
    }
}
