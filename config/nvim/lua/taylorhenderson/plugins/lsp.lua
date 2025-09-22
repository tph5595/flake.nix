return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            -- "L3MON4D3/LuaSnip",
            -- "saadparwaiz1/cmp_luasnip"
        },
        config = function ()
            require("mason").setup()
            require("mason-lspconfig").setup {
                -- ensure_installed = {
                --     "lua_ls",
                --     "texlab",
                --     "ltex",
                --     "pylsp",
                -- },
                handlers = {
                    function (server_name)
                        vim.lsp.config(server_name, {})
                    end,
                    ["lua_ls"] = function ()
                        vim.lsp.config("lua_ls", {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    }
                                }
                            }
                        })
                        vim.lsp.enable("lua_ls")
                    end,
                }
            }

            -- OCaml
            vim.lsp.config("ocamllsp", {})
            vim.lsp.enable("ocamllsp")
            -- Python
            vim.lsp.config("pylsp", {})
            vim.lsp.enable("pylsp")
            vim.lsp.config("ruff", {})
            vim.lsp.enable("ruff")
            -- Latex/Markdown
            vim.lsp.config("ltex", {})
            vim.lsp.enable("ltex")
            vim.lsp.config("texlab", {})
            vim.lsp.enable("texlab")
            vim.lsp.config("marksman", {})
            vim.lsp.enable("marksman")
            -- Rust
            vim.lsp.config("rust_analyzer", {})
            vim.lsp.enable("rust_analyzer")
            -- Lua
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })
            vim.lsp.enable("lua_ls")

            local cmp = require("cmp")
            local cmp_select = {behavior = cmp.SelectBehavior.Select}
            cmp.setup({
                -- snippet = {
                --     expand = function(args)
                --         require('luasnip').lsp_expand(args.body)
                --     end,
                -- },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    -- { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                })
            })
            vim.diagnostic.config({
                -- virtual_text = true,
                update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = ""
                }
            })
        end
    }
}
