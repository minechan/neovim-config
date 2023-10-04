-------------------------------------------------------------------------------
-- lazy.nvimの初期化
-------------------------------------------------------------------------------

if pcall(require, "lazy") then return {} end

local lazy_path = vim.fn.stdpath("data") .. "lazy/lazy.nvim"

-- リポジトリが存在しない場合クローン
if not vim.loop.fs_stat("lazy_path") then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazy_path
    }
end

-- lazy.nvimの読み込み
vim.opt.rtp:prepend(lazy_path)

-- プラグインの読み込み
require("lazy").setup("plugins", {
    defaults    = { lazy = true },
    performance = { cache = { enabled = true } }
})
