vim.api.nvim_create_user_command("ZenToggle", function()
    require("zen-mode").toggle({
        window = {
            width = .85 -- width will be 85% of the editor width
        }
    })
end, { nargs = 0 })

return {
    {
        "mbbill/undotree",
        lazy = true,
        keys = {
            { "<leader>u", "<cmd> UndotreeToggle <cr>", desc = "Copilot toggle" },
        },
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    {
        -- comment da tings
        "tpope/vim-commentary",
        event = "VeryLazy",
    },
    {
        'j-hui/fidget.nvim',
        config = function()
            require("fidget").setup({})
        end
    },
    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },
    {
        "folke/zen-mode.nvim",
        lazy = true,
        keys = {
            { "<leader><leader>", "<cmd> ZenToggle<cr>", desc = "zen-mode toggle" },
        },
    },
    -- Good markdown stuff <leader>e for code block editing with syntax highitng in
    -- sepereate window
    -- "gabrielelana/vim-markdown"
    {
        "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
        config = function ()
            require'nvim-web-devicons'.setup()
            require'nvim-web-devicons'.get_icons()
        end
    },
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        "NoahTheDuke/vim-just",
        ft = { "just" },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { "markdown" },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        opts = {},
    }
}
