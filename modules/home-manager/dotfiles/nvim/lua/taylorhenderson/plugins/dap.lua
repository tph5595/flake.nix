return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        lazy = true,
        keys = {
            { "<leader>du", "", desc = "dap toggle" },
        },
        config = function ()
            local dap, dapui = require("dap"), require("dapui")
            vim.keymap.set("n", '<leader>dc', function() dap.continue() end)
            vim.keymap.set("n", '<leader>dr', function() dap.run_last() end)
            vim.keymap.set("n", '<leader>b', function() dap.toggle_breakpoint() end)

            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
}
