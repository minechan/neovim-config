-------------------------------------------------------------------------------
-- カラースキーム
-------------------------------------------------------------------------------

local rose_pine = {
    "rose-pine/neovim",
    name     = "rose-pine",
    lazy     = false,
    priority = 1000,
    config   = function ()
        require("rose-pine").setup {
            variant = "dawn",
            highlight_groups = {
                IndentBlanklineChar        = { fg = "highlight_med" },
                IndentBlanklineContextChar = { fg = "highlight_high" }
            }
        }

        vim.o.termguicolors = true
        vim.cmd.colorscheme("rose-pine")
    end
}

-------------------------------------------------------------------------------
-- インデント
-------------------------------------------------------------------------------

local indent_blankline = {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    lazy = false,
    config = function ()
        require("ibl").setup {
            indent = {
                char      = "▏",
                highlight = "IndentBlanklineChar",

            },
            scope = {
                show_start = false,
                highlight = "IndentBlanklineContextChar"
            }
        }
    end
}

-------------------------------------------------------------------------------
-- Treesitter
-------------------------------------------------------------------------------

local nvim_treesitter =  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = function ()
        require("nvim-treesitter.install").update { with_sync = true } ()
    end,
    config = function ()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "c", "lua" },
            auto_install     = false,
            highlight        = { enable = true }
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

-------------------------------------------------------------------------------

return { rose_pine, indent_blankline, nvim_treesitter }
