" vi: fdm=marker

" JavascriptLibrariesSyntax: {{{
let g:used_javascript_libs = 'jquery,angularjs,jasmine'
" }}}
" Tagbar: {{{
let g:tagbar_width = 85
let g:tagbar_compact = 1
let g:tagbar_sort = 0

nnoremap <leader>T :TagbarOpenAutoClose<CR>
" }}}
" UltiSnips: {{{
" cannot use '<nop>' in ultisnips mappings
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<c-b>"
let g:UltiSnipsEditSplit = "vertical"
" }}}
" Syntastic: {{{
let g:syntastic_php_checkers = ['php']
let g:syntastic_check_on_open = 0
let g:syntastic_enable_signs = 0
let g:syntastic_always_populate_loc_list = 0

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" }}}
" YouCompleteMe: {{{
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_global_ycm_extra_conf = '~/dotfiles/vim/ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_key_list_previous_completion = ['<c-k>']
let g:ycm_key_list_select_completion = ['<c-j>']

let g:ycm_filetype_specific_completion_to_disable = {
    \ 'php': 1
    \}

let g:ycm_key_detailed_diagnostics = '<leader>y'
" }}}
" DBext: {{{
function! DBextPostResult(db_type, buf_nr)
    set syntax=sql
endfunction
" }}}
" FZF: {{{
let g:fzf_layout = {'down': '80%'}
let g:fzf_buffers_jump = 0

function! FZFTagClass(initialQuery)
    if !empty(tagfiles()) | call fzf#run({
        \'source': "cat " . join(tagfiles()) . ' | ~/dotfiles/pickClass.sh',
        \'sink': function('EditTag'),
        \'down': '80%',
        \'options': '--ansi --tiebreak=begin --query=' . a:initialQuery
    \}) | else | echo 'No tags' | endif
endfunction

command! FZFTagClassC call FZFTagClass('')

function! EditTag(line)
    execute 'edit ' . matchstr(a:line, '[^ ]\+$')
endfunction

nnoremap <silent> <leader>a :call SearchWordWithAg()<CR>
vnoremap <silent> <leader>a :call SearchVisualSelectionWithAg()<CR>
nnoremap <leader>ff :Files!<CR>
nnoremap <leader>fe :Files! /etc<CR>
nnoremap <leader>fd :Files! ~/dotfiles<CR>
nnoremap <leader>fl :Files! /var/log<CR>
nnoremap <leader>fs :BLines!<CR>
nnoremap <leader>ft :BTags!<CR>
nnoremap <leader>fh :History!<CR>

" github.com/zenbro/dotfiles {{{
function! SearchWordWithAg()
    execute 'Ag! ' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag! ' selection
endfunction
" }}}
" }}}
" FileBeagle: {{{
let loaded_netrwPlugin = 1
let g:filebeagle_suppress_keymaps = 1

" map <silent> _ <Plug>FileBeagleOpenCurrentWorkingDir
" map <silent> - <Plug>FileBeagleOpenCurrentBufferDir
" nmap <silent> <BS> <Plug>FileBeagleOpenCurrentBufferDir
" nmap <silent> <c-h> <Plug>FileBeagleOpenCurrentBufferDir
map <silent> _ :EditVifm<CR>
map <silent> - :EditVifm<CR>
nmap <silent> <BS> :EditVifm<CR>
nmap <silent> <c-h> :EditVifm<CR>
" }}}
" GitGutter: {{{
let g:gitgutter_enabled = 0
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_sign_column_always = 1
let g:gitgutter_max_signs = 1500
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0

nnoremap ]c :GitGutterNextHunk<CR>zz
nnoremap [c :GitGutterPrevHunk<CR>zz
nnoremap gp :GitGutterPreviewHunk<CR>
nnoremap cog :GitGutterToggle<CR>
" }}}
" Fugitive: {{{
nnoremap <silent> gs :Gstatus<CR>
nnoremap <silent> gvd :Gvdiff<CR>
nnoremap <silent> <leader>gd :Git! diff<CR>
nnoremap <silent> <leader>gds :Git! diff --staged --patch-with-stat<CR>:set modifiable<CR>:set noreadonly<CR>:%g/^\(---\\|+++\\|index\\|@@\\|new file mode\)/d<CR>gg
nnoremap <silent> <leader>gda :Git! diff HEAD<CR>
nnoremap <silent> gb :Gblame<CR>
nnoremap <silent> gl :silent Glog -n 10 --no-merges
" }}}
" Sneak: {{{
let g:sneak#streak = 1
let g:sneak#use_ic_scs = 1

hi link SneakPluginTarget Search
hi link SneakPluginScope  IncSearch

" nmap <expr> N sneak#is_sneaking() ? '<Plug>SneakPrevious' : '<Plug>(Oblique-N)'
" nmap <expr> n sneak#is_sneaking() ? '<Plug>SneakNext' : '<Plug>(Oblique-n)'

nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
" }}}
" Dispatch: {{{
nnoremap <leader>d :Dispatch!<CR>

nnoremap <leader>dsc :Dispatch php app/console ca:cl -e dev<CR>
nnoremap <leader>dsa :Dispatch php app/console assetic:dump -e dev<CR>
nnoremap <leader>dsi :Dispatch php app/console assets:install -e dev<CR>
" }}}
" Bclose {{{
" nnoremap <silent> <c-d> :Bclose<CR>
" }}}
" Hardtime: {{{
let g:hardtime_default_on = 0
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_ignore_buffer_patterns = ["filebeagle"]
" }}}
" Tbone: {{{
function! TmuxHasMargin()
    redir => panesSize
        silent execute "Tmux list-panes -F '#{pane_width}'"
    redir END
    let numberOfPanes = len(split(panesSize, "\n"))

    return numberOfPanes >= 3
endfunction

function! TmuxSetPaneSize(size)
    let marginSize = TmuxGetMarginSize(a:size)

    silent execute "Tmux select-pane -L"
    silent execute "Tmux resize-pane -x " . marginSize
    silent execute "Tmux select-pane -R"
    silent execute "Tmux select-pane -R"
    silent execute "Tmux resize-pane -x " . marginSize
    silent execute "Tmux select-pane -L"
endfunction

command! -nargs=1 TT call TmuxSetPaneSize(<f-args>)

function! TmuxMarginInit(size)
    let marginSize = TmuxGetMarginSize(a:size)

    silent execute "Tmux split-window -bdh -l " . marginSize . " 'sleep 999999'"
    silent execute "Tmux split-window -dh -l " . marginSize . " 'sleep 999999'"
endfunction

function! TmuxGetMarginSize(size)
    redir => panesSize
        silent execute "Tmux list-panes -F '#{pane_width}'"
    redir END
    let panesSizeList = split(panesSize, "\n")
    let totalWidth = 0
    for i in panesSizeList
        let totalWidth = i + totalWidth
    endfor

    if a:size >= totalWidth
        let marginSize = 2
    else
        let marginSize = (totalWidth - a:size) / 2
    endif

    return marginSize
endfunction
" }}}
" BufferExplorer: {{{
let g:bufExplorerDefaultHelp=0
let g:bufExplorerDisableDefaultKeyMapping=1
let g:bufExplorerShowNoName=1
let g:bufExplorerShowRelativePath=1
let g:bufExplorerShowTabBuffer=1
let g:bufExplorerSortBy='fullpath'
nnoremap <leader>e :BufExplorer<CR>
"}}}
" IncSearch: {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)ncsearch-stay)
" }}}

if !has('nvim')
    set nocompatible
endif
filetype off "required by plugin manager

call plug#begin('~/.vim/plugged')
" Movements: {{{
Plug 'takac/vim-hardtime'
Plug 'justinmk/vim-sneak'
Plug 'michaeljsmith/vim-indent-object'
Plug 'triglav/vim-visual-increment'
Plug 'vim-scripts/argtextobj.vim'
" Plug 'bkad/CamelCaseMotion'
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
Plug 'tpope/vim-repeat'
" Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-tbone'
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
" Other: {{{
Plug 'jlanzarotta/bufexplorer'
Plug 'haya14busa/incsearch.vim'

Plug 'godlygeek/tabular'
Plug 'vifm/vifm.vim'
Plug 'prestidigitator92/vim-filebeagle'

Plug 'vim-scripts/dbext.vim'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'

Plug 'rbgrouleff/bclose.vim'
" }}}
" Colorschemes: {{{
Plug 'prestidigitator92/vim-colors-solarized'
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
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'beyondwords/vim-twig'
Plug 'leshill/vim-json'
Plug 'groenewege/vim-less'
Plug 'othree/html5.vim', {'for': ['html']}
Plug 'keith/tmux.vim'
" Plug 'artur-shaik/vim-javacomplete2'
" Plug 'shawncplus/phpcomplete.vim', { 'for': ['php'] }
" Plug 'leafgarland/typescript-vim'
" Plug 'StanAngeloff/php.vim', { 'for': ['php']}
" Plug 'vim-scripts/phpfolding.vim', { 'for': ['php']}
" Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript'] }
" Plug 'othree/yajs.vim'
" Plug 'dart-lang/dart-vim-plugin'
" Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['cpp', 'hpp']}
" Plug 'fatih/vim-go'
" }}}
call plug#end()

filetype plugin indent on

