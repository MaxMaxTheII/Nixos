{ config, pkgs, ... }:

{
programs.zathura = {
    enable = true;
    options = {
      synctex = true;
      synctex-editor-command = "nvim --remote-silent +%{line} %{input}";
      selection-clipboard = "clipboard";
#      recolor = true; # Allows for dark mode/custom colors
#      recolor-keephue = true;
    
      # Matching your 0.75 opacity vibe (pseudo-transparent)
    /*  default-bg = "#1e1e1e";
      default-fg = "#d4d4d4";
      recolor-lightcolor = "#1e1e1e";
      recolor-darkcolor = "#d4d4d4";*/
    };
  };
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      vimtex
      nvim-lspconfig
      luasnip
      friendly-snippets
      nvim-cmp
      cmp-nvim-lsp
      cmp_luasnip
      cmp-path
      (nvim-treesitter.withPlugins (p: [ p.latex p.bibtex p.lua p.vim p.bash p.markdown]))
    ];
    extraLuaConfig = ''
  local ts_path = "${pkgs.vimPlugins.nvim-treesitter.withAllGrammars}"
  vim.opt.runtimepath:append(ts_path)
  vim.opt.runtimepath:append(ts_path .."/queries")
  vim.treesitter.language.register('latex', 'tex')


  -- 2. Snippet Engine Setup
  local ls = require("luasnip")
  local cmp = require('cmp')
  local s = ls.snippet
  local t = ls.text_node
  local i = ls.insert_node


require('nvim-treesitter.configs').setup({
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "latex" }, -- Required for VimTeX to stay happy
  },
})
  require("luasnip.loaders.from_vscode").lazy_load({ 
    paths = { "${pkgs.vimPlugins.friendly-snippets}" } 
  })

  ls.filetype_extend("tex", {"latex"})
  

  vim.lsp.enable('texlab')
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

cmp.setup({
  snippet = {
    expand = function(args) ls.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(), -- Manually trigger menu
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter to select
    ['<Tab>'] = cmp.mapping(function(fallback)
      if ls.expand_or_jumpable() then ls.expand_or_jump()
      elseif cmp.visible() then cmp.select_next_item()
      else fallback() end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  })
})

vim.keymap.set({"i", "s"}, "<Tab>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    else
      -- Regular tab if no snippet is active
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

  -- 5. UI Polish
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = "rounded" }
  )

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
    integrations = {
        cmp = true,
        treesitter = true,
        vimtex = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
    },
})
vim.cmd.colorscheme "catppuccin"
'';
    extraConfig = ''
      " --- VIMTEX SETTINGS ---
      let g:vimtex_view_method = 'zathura'
      let g:vimtex_quickfix_mode = 0
      let maplocalleader = ","
      set completeopt=menu,menuone,noselect

      " --- GENERAL SETTINGS ---
      set number
      set relativenumber
      
      " Enable spellcheck for LaTeX
      autocmd FileType tex setlocal spell spelllang=en_us,de_at

    '';
      #" Use <Tab> to navigate the completion menu
      #inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
      #inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  };
}
