" vi: fdm=marker

set noruler

if !has('nvim')
    set encoding=utf-8
endif
set undolevels=1000
set showmode
set noshowcmd

" set cpoptions+=n
set nonumber
set numberwidth=5

set splitbelow
set splitright

"command line mode
set wildmenu
set wildmode=longest,list
set wildcharm=<tab>
set wildignorecase
set wildignore+=*/tmp/*,*/cache/*

"matchparen
let loaded_matchparen = 1
set noshowmatch

"indent
set breakindent
set autoindent
set copyindent
set smartindent
set smarttab
set expandtab
set shiftwidth=4
set tabstop=4

"searching
set ignorecase
set smartcase
set incsearch
set magic
" set nowrapscan

"substitute
set gdefault

"Don't redraw while executing macros(performace)
set lazyredraw
if !has('nvim')
    set ttyfast
endif

"no anoying sound on errors
set noerrorbells
set novisualbell

"turn off backup
set nobackup
set noswapfile
set nowb

set lbr
set tw=500
set wrap

"speed up scrolling
set scrolloff=3
set sidescrolloff=10

" use system clipboard instead of default vim
set clipboard=unnamedplus

set laststatus=1

if has('php_sql_query')
    unlet php_sql_query
endif

set mouse=a

set nolist
set foldmethod=manual
set completeopt=longest,menuone

set wildignorecase

let php_minlines=1000

set virtualedit=block

set hidden
set shortmess=aIT

set foldcolumn=0

set updatetime=500
" let &showbreak = '↳ '
let &showbreak = '↓↓  '
set nostartofline

set nocursorline
set nocursorcolumn

set showtabline=0

set previewheight=20

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" highlight last inserted text
noremap gV `[v`]

map Q @q

" no idea what it does
nnoremap > ]mzt
nnoremap < [mzt

" wrapping lines in visual mode
vnoremap < <gv
vnoremap > >gv

nnoremap <c-l> :b#<cr>

noremap j gj
noremap k gk

nnoremap gG ggVG

nnoremap <leader>c <c-w>c
nnoremap <leader>wh <c-w>H
nnoremap <leader>wj <c-w>J
nnoremap <leader>wk <c-w>K
nnoremap <leader>wl <c-w>L
nnoremap <leader>wo <c-w>o

inoremap jk <esc>

" JumpOrOpenNewSplit: {{{
function! JumpOrOpenNewSplit(key, cmd) " {{{
    let current_window = winnr()
    execute 'wincmd' a:key
    if current_window == winnr()
        if (a:key == 'h' || a:key == 'l') && TmuxHasMargin()
            call TmuxSetPaneSize(250)
        endif
        execute a:cmd
    endif
endfunction " }}}

nnoremap <silent> <Leader>h :call JumpOrOpenNewSplit('h', ':leftabove vsplit')<CR>
nnoremap <silent> <Leader>l :call JumpOrOpenNewSplit('l', ':rightbelow vsplit')<CR>
nnoremap <silent> <Leader>k :call JumpOrOpenNewSplit('k', ':leftabove split')<CR>
nnoremap <silent> <Leader>j :call JumpOrOpenNewSplit('j', ':rightbelow split')<CR>
" }}}

function! CloseOtherWindows()
    if TmuxHasMargin()
        call TmuxSetPaneSize(120)
    endif
    only
endfunction

nnoremap <silent> <leader>o :call CloseOtherWindows()<CR>

nnoremap <leader>n :noh<CR>

nnoremap <c-f> <c-f>2<c-e>
nnoremap <c-b> <c-b>2<c-y>

nnoremap gf gF

" Y behave like D or C
nnoremap Y y$

" Copy current file path to clipboard
nnoremap <leader>% :call CopyCurrentFilePath()<CR>
function! CopyCurrentFilePath() " {{{
  let @+ = expand('%')
  echo @+
endfunction
" }}}

function! NeatFoldText() "{{{
"http://dhruvasagar.com/2013/03/28/vim-better-foldtext
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%9s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}

nnoremap ; :
set autowrite
