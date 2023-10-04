-------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------

return {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    event        = { "BufReadPre", "BufNewFile" },
    config       = function ()
        local lspconfig = require("lspconfig")

        for _, server in ipairs { "clangd", "lua_ls" } do
            lspconfig[server].setup {
                settings     = require("plugins.lsp." .. server),
                capabilities = require("cmp_nvim_lsp").default_capabilities()
            }
        end
    end
}
