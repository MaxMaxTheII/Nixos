-- General Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = false

-- Tab Behavior
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Completion options
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- vim.cmd.colorscheme("base16-neon-zerg") -- Stylix generates/maps base16 names here

-- LSP Hover Border UI Polish
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
    config = config or {}
    config.border = "rounded"
    return vim.lsp.handlers.hover(_, result, ctx, config)
end

-- Enable spellcheck for LaTeX and Markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "tex", "markdown" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = { "en_us", "de_at" }
    end,
})
