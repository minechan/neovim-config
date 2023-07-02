for key, value in pairs {
    -- 行番号
    number     = true,
    signcolumn = "yes",
    -- タブ
    expandtab  = true,
    tabstop    = 4,
    shiftwidth = 4,
    -- インデント
    autoindent  = true,
    breakindent = true,
    -- 検索
    ignorecase = true,
    hlsearch   = true,
    -- その他
    mouse          = "a",
    mousemoveevent = true,
    clipboard      = "unnamedplus",
    cursorline     = true,
    updatetime     = 10,
    cmdheight      = 0,
    background     = "light"
} do vim.o[key] = value end

-- プラグイン
require("plugins")

-- 補完
require("completion")

-- ハイライト
vim.api.nvim_create_autocmd("LspAttach", {
    group    = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function (ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.server_capabilities.documentHighlightProvider then
            vim.cmd([[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]])
        end
    end
})
