-- tabs
vim.bo.tabstop = 2              -- show tab as 2 spaces
vim.bo.softtabstop = 2          -- insert spaces
vim.bo.shiftwidth = 2           -- indent >> <<
vim.bo.expandtab = false        -- keep tabs
-- format
vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("o")
-- folding
vim.opt.foldmethod = 'syntax'
