local dap_on = false
vim.api.nvim_create_user_command("DapToggle", function()
	if dap_on then
        require("dapui").close()
	else
        require("dapui").open()
	end
	dap_on = not dap_on
end, { nargs = 0 })

return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
        },
        lazy = true,
        keys = {
            { "<leader>du", "<cmd>DapToggle<cr>", desc = "dap toggle" },
        },
        config = function ()
            local dap, dapui = require("dap"), require("dapui")
            require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

            vim.keymap.set("n", '<leader>dc', function() dap.continue() end)
            vim.keymap.set("n", '<leader>dr', function() dap.run_last() end)
            vim.keymap.set("n", '<leader>b', function() dap.toggle_breakpoint() end)

            -- nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
            -- nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
            -- vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>

            dapui.setup({
                controls = {
                    icons = {
                        disconnect = "",
                        pause = "󰏤",
                        play = "󰐊",
                        run_last = "",
                        step_back = "",
                        step_into = "󰆹",
                        step_out = "",
                        step_over = "",
                        terminate = ""
                    }
                },
                icons = {
                    collapsed = "󰐊",
                    current_frame = "",
                    expanded = ""
                },
            }
            )

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
