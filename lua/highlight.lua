-------------------------------------------------------------------------------
-- ハイライト
-------------------------------------------------------------------------------

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
                ]]
            )
        end
    end
})
