local function concat(...)
    local result = {}
    local sources = { ... }

    for _, source in ipairs(sources) do
        for _, value in ipairs(source) do
            result[#result + 1] = value 
        end
    end

    return result
end

return {
    Lua = {
        runtime = { version = "Lua 5.4", pathStrict = true },
        workspace = {
            library = concat(vim.api.nvim_get_runtime_file("", true), {
                "/usr/share/lua/5.4", "/usr/share/awesome/lib"
            }),
            checkThirdParty = false
        },
        completion = { enable = true },
        diagnostics = {
            enable  = true,
            disable = { "lowercase-global" },
            globals = {
                "vim", "awesome", "button", "client", "dbus", "drawable", "drawin", "key",
                "keygrabber", "mouse", "mousegrabber", "root", "screen", "selection", "tag", "window"
            }
        },
        telemetry = { enable = false }
    }
}
