-- Set maplocalleader before loading plugins
vim.g.maplocalleader = ","

-- Vimtex configurations
vim.g.vimtex_view_method = "zathura"
vim.g.vimsyn_embed = "l"
vim.g.vimtex_quickfix_mode = 0

require("options")
require("keymaps")
require("plugins")
