-------------------------------------------------------------------------------
-- オプション
-------------------------------------------------------------------------------

for option, value in pairs {
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
} do
    vim.o[option] = value
end
