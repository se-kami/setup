" START
set nocompatible
set fsync
filetype off
filetype plugin indent on

let mapleader=","
set number
set relativenumber
syntax enable
" python style by default
set tabstop=4 " how many columns is one tab
set softtabstop=4 " how many columns for tab
set shiftwidth=4 " how many columns are indented
set expandtab " replace tabs for spaces
" python
autocmd BufEnter *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab " python style tabs
" make file
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0 " don't expand tabs in makefile
" smart tabs
set smarttab
set smartindent " smart indent
" fold methods
autocmd BufEnter *.notes set foldmethod=marker
autocmd BufEnter *.py set foldmethod=indent
autocmd BufEnter *.c set foldmethod=indent
autocmd BufEnter *.tex set foldmethod=marker
let g:vimwiki_folding = 'custom'
autocmd BufEnter *.wiki set foldmethod=marker
autocmd BufEnter *.vim set foldmethod=marker
autocmd BufEnter *.zshrc set foldmethod=marker
autocmd BufEnter *.java set foldmethod=syntax
" search higlighting
set hlsearch
nnoremap <C-S> :nohl<CR><C-L>
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" blink the line
function! HLNext(blinktime)
    set invcursorline
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    set invcursorline
    redraw
endfunction
" zzzv keeps the cursor cetered
nnoremap <silent> n nzzzv:call HLNext(0.4)<CR>
nnoremap <silent> N Nzzzv:call HLNext(0.4)<CR>

" persistent undo
:set undofile
" undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
" encoding
scriptencoding utf-8
set encoding=utf-8
" file format
set fileformat=unix
" completion
set wildmenu " better completion
set omnifunc=syntaxcomplete#Complete
" default clipboard
set clipboard=unnamedplus
" better splits
set splitbelow
set splitright
" scrolling
set scrolloff=5 " don't scroll to bottom
" color
if (has("termguicolors"))
    set termguicolors
endif
# merge lines
nnoremap J mzJ'z
" jumplist
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
" move line up or down
vnoremap J :M '>+1<CR>gv=gv
vnoremap K :M '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==li
inoremap <C-k> <esc>:m .-2<CR>==li
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
" no line wrapping
set nowrap
" disable automatic commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
" Stop certain movements from always going to the first character of a line.
set nostartofline
set autoindent
set colorcolumn=80
set mouse=a
set visualbell
set t_vb=
set shortmess=Il
set laststatus=2
set hidden
set ruler
inoremap <C-e> <c-g>u<Esc>[s1z=`]a<c-g>u
map <F7> :setlocal spell! spelllang=en_us<CR>
inoremap <F7> <C-\><C-O>:setlocal spelllang=en_us spell! spell?<CR>
set pastetoggle=<F11>
set cmdheight=1
set showcmd
set signcolumn=yes
" Plug
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim' " seoul theme
Plug 'morhetz/gruvbox' " gruvbox theme
Plug 'lervag/vimtex' " vimtex, \ll to compile
Plug 'preservim/nerdtree' " nerd tree
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "fuzzy finder
Plug 'junegunn/fzf.vim' " fuzzy finder
Plug 'tpope/vim-commentary' " gcc to comment out a line, gcap to comment out a paragraph, gc in visual mode to comment out a selection
Plug 'tpope/vim-surround' " surrounding with quotes
Plug 'vimwiki/vimwiki' " vimwiki
Plug 'chrisbra/csv.vim' " csv
Plug 'jeetsukumaran/vim-pythonsense' " text objects and motions for python
Plug 'jiangmiao/auto-pairs' " auto pair (){}[]''
Plug 'lambdalisue/suda.vim' " write files with sudo
Plug 'junegunn/vim-peekaboo' " expand registers
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'dense-analysis/ale' "linting
Plug 'junegunn/goyo.vim' " goyo, distraction free writing
let g:goyo_width=100
let g:goyo_height=35
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" vimwiki
autocmd BufEnter *.wiki map <leader><leader> <Plug>VimwikiTabnewLink
" tex conceal
Plug 'KeitaNakamura/tex-conceal.vim'
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
let g:tex_conceal_frac=1
" snippets
Plug 'sirver/ultisnips'
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
call plug#end()
" theme
set background=dark
" gruvbox
let g:gruvbox_contrast_dark = "hard"
colo gruvbox
" latex flavor
let g:tex_flavor = "latexmk -pdf"
" latex pdf reader
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_automatic = 0
" other vimtex settings
" let g:vimtex_quickfix_mode=0
set conceallevel=2
let g:tex_conceal='abdmg'
let g:vimtex_quickfix_ignore_filters = [
          \ 'Underfull \\hbox (badness',
          \ 'Overfull \\hbox',
          \]
let g:vimtex_quickfix_autoclose_after_keystrokes = 1
" TOC settings
let g:vimtex_toc_config = {
    \ 'name' : 'TOC',
    \ 'layers' : ['content', 'todo', 'include'],
    \ 'resize' : 1,
    \ 'split_width' : 30,
    \ 'todo_sorted' : 0,
    \ 'show_help' : 1,
    \ 'show_numbers' : 1,
    \ 'mode' : 2,
    \ }
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : 'build',
    \ }
" fzf
let g:fzf_action = { 'enter': 'tab split' } " by default opens in new tab
let g:fzf_preview_window = 'right:60%'
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :GFiles<CR>
nnoremap <silent> <C-o> :Buffers<CR>
nnoremap <C-f> :Rg!
nnoremap <silent> <C-w> :Files ~/Documents/vimwiki/<CR>
" NERDTree
map <C-n> :NERDTreeToggle<CR>
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" calcurse
autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=notes
autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=notes
" }}}
" color
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
" }}}
" linter
" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
nnoremap <leader>ale :ALEFix <CR>

" new tab
map <leader>tn :tabnew<CR>
" move between tabs
map  <A-l> :tabn<CR>
map  <A-h> :tabp<CR>
" move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" yanking {{{
vnoremap <C-y> "+y
noremap <leader>u :w<Home>silent <End> !urlview<CR>
" disable arrows {{{
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
" tab or buf 1
nnoremap <leader>1 :call functions#tab_buf_switch(1)<cr>
" tab or buf 2
nnoremap <leader>2 :call functions#tab_buf_switch(2)<cr>
" tab or buf 3
nnoremap  <leader>3 :call functions#tab_buf_switch(3)<cr>
" tab or buf 4
nnoremap  <leader>4 :call functions#tab_buf_switch(4)<cr>
" tab or buf 5
nnoremap  <leader>5 :call functions#tab_buf_switch(5)<cr>
" tab or buf 6
nnoremap  <leader>6 :call functions#tab_buf_switch(6)<cr>
" tab or buf 7
nnoremap  <leader>7 :call functions#tab_buf_switch(7)<cr>
" tab or buf 8
nnoremap  <leader>8 :call functions#tab_buf_switch(8)<cr>
" tab or buf 9
nnoremap  <leader>9 :call functions#tab_buf_switch(9)<cr>
" tabs
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
" tab navigation like zsh
nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>
" nnoremap <leader>w :call functions#tab_buf_close()<CR>
" csv opener, first field
map <leader>f :exec '!nsxiv "$(echo ' . shellescape(getline('.')) . ' \| cut -d, -f1)" 2>/dev/null' <CR><CR>
" whole line in feh
map <leader>pl :exec '!nsxiv ' . shellescape(getline('.')) <CR><CR>
" word in feh
map <leader>pw :exec '!nsxiv ' . shellescape(expand('<cWORD>')) <CR><CR>
" line in mpv
map <leader>ml :exec '!mpv ' . shellescape(getline('.')) <CR><CR>
" word in mpv
map <leader>mw :exec '!mpv ' . shellescape(expand('<cWORD>')) <CR><CR>
" line in zat
map <leader>za :exec '!zathura ' . shellescape(getline('.')) <CR><CR>
" echo line
map <leader>me :exec '.!echo ' . shellescape(getline('.')) '&& youtube-dl --skip-download --get-title -- ' . shellescape(getline('.')) <CR><CR>J
" reload vimrc
nnoremap <leader>rv :source $myVIMRC<CR>
" folding
nnoremap <leader>mf :set foldmethod=marker<CR>
nnoremap <leader>mi :set foldmethod=indent<CR>

" delete trailing whitespace
autocmd BufWritePre * %s/\s\+$//e
"
set confirm
" filetype
filetype on
filetype plugin on
filetype indent on " file type based indentation
