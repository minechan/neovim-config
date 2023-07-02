vim.cmd("packadd packer.nvim")

return require("packer").startup(function (use)
    use { "wbthomason/packer.nvim", opt = true }

    -- カラースキーム
    use {
        "rose-pine/neovim",
        as     = "rose-pine",
        config = function ()
            require("rose-pine").setup {
                highlight_groups = {
                    IndentBlanklineChar        = { fg = "highlight_med" },
                    IndentBlanklineContextChar = { fg = "highlight_high" }
                }
            }

            vim.o.termguicolors = true
            vim.cmd.colorscheme("rose-pine")
        end
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function ()
            require("nvim-treesitter.install").update { with_sync = true } ()
        end,
        config = function ()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "c", "lua" },
                auto_install     = true,
                highlight        = {
                    enable = true
                }
            }

            vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
                group    = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
                callback = function ()
                    vim.o.foldmethod = "expr"
                    vim.o.foldexpr   = "nvim_treesitter#foldexpr()"
                end
            })
        end
    }

    -- 外観
    use {
        "lukas-reineke/indent-blankline.nvim",
        requires = { "nvim-treesitter/nvim-treesitter" },
        config   = function ()
            require("indent_blankline").setup {
                char                 = "▏",
                show_current_context = true
            }
        end
    }

    -- 補完
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/vim-vsnip" },
            { "onsails/lspkind.nvim" }
        },
        config = function ()
            local cmp     = require("cmp")
            local lspkind = require("lspkind")

            local cmdline_mapping = {
                ["<Down>"]  = { i = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select } },
                ["<Up>"]    = { i = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select } },
                ["<C-n>"]   = { i = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select } },
                ["<C-p>"]   = { i = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select } },
                ["<Tab>"]   = { i = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select } },
                ["<S-Tab>"] = { i = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select } },
            }

            cmp.setup {
                snippet = { expand = function (args) vim.fn["vsnip#anonymous"](args.body) end },
                mapping = {
                    ["<Down>"] = { i = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select } },
                    ["<Up>"]   = { i = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select } },
                    ["<C-n>"]  = { i = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select } },
                    ["<C-p>"]  = { i = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select } },
                    ["<CR>"]   = { i = cmp.mapping.confirm { select = true } },
                    ["<Tab>"]  = { i = cmp.mapping.confirm { select = true } },
                    ["<C-m>"]  = { i = cmp.mapping.confirm { select = true } },
                    ["<C-j>"]  = { i = cmp.mapping.confirm { select = true } },
                    ["<Esc>"]  = { i = cmp.mapping.abort() },
                    ["<C-c>"]  = { i = cmp.mapping.abort() }
                },
                sources = cmp.config.sources {
                    { name = "nvim_lsp" },
                    { name = "vsnip" }
                },
                formatting = {
                    format = lspkind.cmp_format {
                        mode          = "symbol",
                        maxwidth      = 50,
                        ellipsis_char = "..."
                    }
                }
            }

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmdline_mapping,
                sources = { { name = "buffer" } }
            })
            cmp.setup.cmdline(":", {
                mapping = cmdline_mapping,
                sources = cmp.config.sources {
                    { name = "path" },
                    { name = "cmdline" }
                }
            })
        end
    }

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        requires = { "hrsh7th/nvim-cmp" },
        config   = function ()
            local lspconfig = require("lspconfig")

            for _, server in ipairs { "clangd", "lua_ls" } do
                lspconfig[server].setup {
                    settings     = require("lsp." .. server),
                    capabilities = require("cmp_nvim_lsp").default_capabilities()
                }
            end
        end
    }
end)
