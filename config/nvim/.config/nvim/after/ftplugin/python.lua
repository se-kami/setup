-- indent
vim.opt_local.expandtab = true -- replace tabs with spaces
vim.opt_local.tabstop = 4 -- tab shows as 4 spaces
vim.opt_local.softtabstop = 4 -- tab press = insert 4 spaces
vim.opt_local.shiftwidth = 4 -- indent >> <<
vim.opt.smartindent = true
-- folding
vim.opt.foldmethod = "indent"
-- format
vim.opt_local.formatoptions:remove({ "c", "r", "o" })
-- colored line
vim.o.colorcolumn = "80"
