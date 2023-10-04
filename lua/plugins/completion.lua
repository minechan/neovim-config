-------------------------------------------------------------------------------
-- 補完
-------------------------------------------------------------------------------

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-vsnip" },
        { "hrsh7th/vim-vsnip" },
        { "onsails/lspkind.nvim" }
    },
    event  = { "InsertEnter", "CmdlineEnter" },
    config = function ()
        local cmp = require("cmp")

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
                format = require("lspkind").cmp_format {
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
