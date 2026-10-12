local ls = require("luasnip")

-- Tab to expand/jump forward in snippets
vim.keymap.set({"i", "s"}, "<Tab>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    else
        local keys = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
        vim.api.nvim_feedkeys(keys, "n", false)
    end
end, { silent = true })

-- Shift-Tab to go backwards in snippets
vim.keymap.set({"i", "s"}, "<S-Tab>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })
