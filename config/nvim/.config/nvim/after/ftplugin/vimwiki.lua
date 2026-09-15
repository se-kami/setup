-- folding
vim.opt_local.foldmethod = 'marker'

-- follow link
vim.cmd([[autocmd FileType vimwiki map <leader><leader> <Plug>VimwikiTabnewLink]], false)

-- colors
vim.cmd([[hi VimwikiHeader1 guifg=#d08770 ctermfg=173 guibg=NONE ctermbg=NONE gui=bold cterm=bold]])
vim.cmd([[hi VimwikiHeader2 guifg=#a3be8c ctermfg=144 guibg=NONE ctermbg=NONE gui=bold cterm=bold]])
vim.cmd([[hi VimwikiHeader3 guifg=#5e81ac ctermfg=67 guibg=NONE ctermbg=NONE gui=bold cterm=bold]])
vim.cmd([[hi VimwikiHeader4 guifg=#8fbcbb ctermfg=109 guibg=NONE ctermbg=NONE gui=bold cterm=bold]])
vim.cmd([[hi VimwikiHeader5 guifg=#ebcb8b ctermfg=222 guibg=NONE ctermbg=NONE gui=bold cterm=bold]])
vim.cmd([[hi VimwikiHeader6 guifg=#b48ead ctermfg=139 guibg=NONE ctermbg=NONE gui=bold cterm=bold]])
vim.cmd([[hi VimwikiLink guifg=#88c0d0 ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE]])
vim.cmd([[hi VimwikiHeaderChar guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE]])
vim.cmd([[hi VimwikiHR guifg=#ebcb8b ctermfg=222 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE]])
vim.cmd([[hi VimwikiList guifg=#d08770 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE]])
vim.cmd([[hi VimwikiTag guifg=#d08770 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE]])
vim.cmd([[hi VimwikiMarkers guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE]])
