" vi: fdm=marker

if !has('nvim')
    set nocompatible
endif

filetype off "required by plugin manager

call plug#begin('~/.vim/plugged')
" Movements: {{{
" Plug 'bkad/CamelCaseMotion'
Plug 'justinmk/vim-sneak'
Plug 'michaeljsmith/vim-indent-object'
Plug 'triglav/vim-visual-increment'
Plug 'vim-scripts/argtextobj.vim'
" Plug 'terryma/vim-expand-region'
" }}}
" TPope: {{{
Plug 'prestidigitator92/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-tbone'
" Plug 'tpope/vim-ragtag'
" Plug 'tpope/vim-flagship'
" }}}
" EditMode: {{{
Plug 'Valloric/YouCompleteMe', { 'on': [] }
Plug 'SirVer/ultisnips', { 'on': [] }
Plug 'jiangmiao/auto-pairs', { 'on': [] }
" }}}
" FZF: {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
" }}}

Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'

Plug 'godlygeek/tabular'
Plug 'prestidigitator92/vim-filebeagle'

Plug 'vim-scripts/dbext.vim', { 'for': ['sql']}
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'

Plug 'rbgrouleff/bclose.vim'

Plug 'junegunn/goyo.vim'
" Plug 'vim-scripts/listmaps.vim'
" Colorschemes: {{{
Plug 'altercation/vim-colors-solarized'
" Plug 'chriskempson/vim-tomorrow-theme'
" Plug 'jnurmine/Zenburn'
" Plug 'jonathanfilip/vim-lucius'
" Plug 'junegunn/seoul256.vim'
" Plug 'morhetz/gruvbox'
" Plug 'prestidigitator92/vim-hybrid'
" Plug 'prestidigitator92/vim-wombat256i'
" Plug 'tomasr/molokai'
" Plug 'vim-scripts/wombat256.vim'
" }}}
" Languages: {{{
" Plug 'tobyS/pdv'
" Plug 'artur-shaik/vim-javacomplete2'
" Plug 'shawncplus/phpcomplete.vim', { 'for': ['php'] }
" Plug 'leafgarland/typescript-vim'
" Plug 'tpope/vim-git'
" Plug 'othree/html5.vim', {'for': ['html']}
" Plug 'tpope/vim-markdown'
" Plug 'StanAngeloff/php.vim', { 'for': ['php']}
" Plug 'vim-scripts/phpfolding.vim', { 'for': ['php']}
Plug 'beyondwords/vim-twig'
Plug 'leshill/vim-json', {'for': ['json', 'javascript']}
" Plug 'groenewege/vim-less', { 'for': ['less'] }
" Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript'] }
" Plug 'othree/yajs.vim'
" Plug 'dart-lang/dart-vim-plugin'
" Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['cpp', 'hpp']}
" Plug 'fatih/vim-go'
" Plug 'keith/tmux.vim'
" }}}
call plug#end()

filetype plugin indent on
