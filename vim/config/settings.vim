" vi: fdm=marker

" VimSettings: {{{

set noruler

if !has('nvim')
    set encoding=utf-8
endif
set undolevels=1000
set showmode
set noshowcmd

" set cpoptions+=n
set number
set numberwidth=4

set splitbelow
set splitright

"command line mode
set wildmenu
set wildmode=longest,list
set wildcharm=<tab>
set wildignorecase
set wildignore+=*/tmp/*,*/cache/*

nnoremap <leader>e :b<space><tab>

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
set scrolloff=2
set sidescrolloff=10

" use system clipboard instead of default vim
set clipboard=unnamedplus

set laststatus=2

let g:php_sql_query=0

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
let &showbreak = '↳ '
set nostartofline

set nocursorline
set nocursorcolumn

set showtabline=0

set previewheight=25

" }}}
