local parentheses = { { "(", ")" }, { "[", "]" }, { "{", "}" }, { "<", ">" } }
local quotations  = { "'", '"' }

-- かっこ
for _, pair in ipairs(parentheses) do
    -- 開き
    vim.keymap.set("i", pair[1], function ()
        local pos  = vim.fn.getpos(".")
        local line = vim.fn.getline(pos[2])

        --[[
        if pos[3] > #line or line:sub(pos[3], pos[3]) ~= pair[2] then
            return pair[1] .. pair[2] .. "<Left>"
        else
            return pair[1]
        end
        ]]
        return pair[1] .. pair[2] .. "<Left>"
    end, { expr = true })
    -- 閉じ
    vim.keymap.set("i", pair[2], function ()
        local pos  = vim.fn.getpos(".")
        local line = vim.fn.getline(pos[2])

        if pos[3] > #line or line:sub(pos[3], pos[3]) ~= pair[2] then
            return pair[2]
        else
            return "<Right>"
        end
    end, { expr = true })
end

-- 引用符
for _, quotation in ipairs(quotations) do
    vim.keymap.set("i", quotation, function ()
        local pos  = vim.fn.getpos(".")
        local line = vim.fn.getline(pos[2])

        if pos[3] > #line or line:sub(pos[3], pos[3]) ~= quotation then
            return quotation .. quotation .. "<Left>"
        else
            return "<Right>"
        end
    end, { expr = true })
end

-- 等号
vim.keymap.set("i", "=", function ()
    local pos = vim.fn.getpos(".")
    local line = vim.fn.getline(pos[2])

    if pos[3] >= 2 and line:sub(pos[3] - 1, pos[3] - 1) == "<" then
        return "<Right><BS>="
    else
        return "="
    end
end, { expr = true })

-- スペース
vim.keymap.set("i", " ", function ()
    local pos  = vim.fn.getpos(".")
    local line = vim.fn.getline(pos[2])

    if pos[3] >= 2 and pos[3] <= #line then
        if line:sub(pos[3], pos[3]) == ">" then
            return "<Right><BS> "
        else
            for _, pair in ipairs(parentheses) do
                if line:sub(pos[3] - 1, pos[3]) == pair[1] .. pair[2] then
                    return "  <Left>"
                end
            end
        end
    end

    return " "
end, { expr = true })

-- バックスペース
vim.keymap.set("i", "<BS>", function ()
    local pos  = vim.fn.getpos(".")
    local line = vim.fn.getline(pos[2])

    if pos[3] >= 2 and pos[3] <= #line then
        for _, pair in ipairs(parentheses) do
            if line:sub(pos[3] - 1, pos[3]) == pair[1] .. pair[2] then
                return "<Right><BS><BS>"
            end
        end
        for _, pair in ipairs(quotations) do
            if line:sub(pos[3] - 1, pos[3]) == pair .. pair then
                return "<Right><BS><BS>"
            end
        end
    end
    if pos[3] >= 3 and pos[3] < #line then
        for _, pair in ipairs(parentheses) do
            if line:sub(pos[3] - 2, pos[3] + 1) == pair[1] .. "  " .. pair[2] then
                return "<Right><BS><BS>"
            end
        end
    end
    return "<BS>"
end, { expr = true })
