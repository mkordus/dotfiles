" vi: fdm=marker

if !has('nvim')
    set nocompatible
endif

filetype off "required by plugin manager

call plug#begin('~/.vim/plugged')

" dispatch: {{{
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
" }}}
" Plug 'prestidigitator92/vim-phpunitqf'
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'jlanzarotta/bufexplorer' - replaced with unite
Plug 'terryma/vim-expand-region'
Plug 'triglav/vim-visual-increment'

Plug 'prestidigitator92/mru'
Plug 'tpope/vim-abolish'
Plug 'godlygeek/tabular'
Plug 'mileszs/ack.vim'
Plug 'prestidigitator92/vim-filebeagle'
Plug 'jimsei/winresizer'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

" Plug 'artur-shaik/vim-javacomplete2'

Plug 'tpope/vim-tbone'
Plug 'tpope/vim-projectionist'

Plug 'michaeljsmith/vim-indent-object'

" Plug 'christoomey/vim-tmux-navigator'

Plug 'prestidigitator92/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'

Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-fnr'

Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-flagship'

Plug 'vim-scripts/dbext.vim', { 'for': ['sql']}
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', { 'on': [] }
Plug 'SirVer/ultisnips', { 'on': [] }
Plug 'jiangmiao/auto-pairs', { 'on': [] }
Plug 'majutsushi/tagbar'

Plug 'airblade/vim-gitgutter'

" Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
" Plug 'junegunn/rainbow_parentheses.vim'

Plug 'justinmk/vim-sneak'

" Plug 'vim-scripts/listmaps.vim'
" Colorschemes: {{{
Plug 'jonathanfilip/vim-lucius'
Plug 'prestidigitator92/vim-wombat256i'
Plug 'vim-scripts/wombat256.vim'
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'
Plug 'tomasr/molokai'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'prestidigitator92/vim-hybrid'
" }}}
" Syntax: {{{
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-git'
" Plug 'othree/html5.vim', {'for': ['html']}
Plug 'tpope/vim-markdown'
" Plug 'StanAngeloff/php.vim', { 'for': ['php']}
" Plug 'vim-scripts/phpfolding.vim', { 'for': ['php']}
Plug 'beyondwords/vim-twig'
Plug 'leshill/vim-json', {'for': ['json', 'javascript']}
Plug 'groenewege/vim-less', { 'for': ['less'] }
" Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript'] }
Plug 'othree/yajs.vim'
" Plug 'dart-lang/dart-vim-plugin'
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['cpp', 'hpp']}
" Plug 'fatih/vim-go'
Plug 'keith/tmux.vim'
" }}}
call plug#end()

filetype plugin indent on
