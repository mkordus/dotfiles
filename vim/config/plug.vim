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
let g:ycm_collect_identifiers_from_comments_and_strings = 0
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
" Oblique: {{{
let g:oblique#incsearch_highlight_all=1
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

nnoremap <leader>a :Ag! <right>
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
    execute 'Ag' expand('<cword>')
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
    execute 'Ag' selection
endfunction
" }}}
" }}}
" FileBeagle: {{{
let loaded_netrwPlugin = 1
let g:filebeagle_suppress_keymaps = 1

map <silent> _ <Plug>FileBeagleOpenCurrentWorkingDir
map <silent> - <Plug>FileBeagleOpenCurrentBufferDir
nmap <silent> <BS> <Plug>FileBeagleOpenCurrentBufferDir
nmap <silent> <c-h> <Plug>FileBeagleOpenCurrentBufferDir
" }}}
" GitGutter: {{{
let g:gitgutter_enabled = 1
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
" }}}
" Bclose {{{
nnoremap <silent> <c-d> :Bclose<CR>
" }}}
" Hardtime: {{{
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_ignore_buffer_patterns = ["filebeagle"]
" }}}
" Tbone: {{{
function! TmuxSetPaneSize(size)
    redir => panesSize
        silent execute "Tmux list-panes -F '#{pane_width}'"
    redir END
    let panesSizeList = split(panesSize, "\n")
    let totalWidth = 0
    for i in panesSizeList
        let totalWidth = i + totalWidth
    endfor

    let marginSize = (totalWidth - a:size) / 2

    " echo marginSize
    silent execute "Tmux resize-pane -t 1 -x " . marginSize
    silent execute "Tmux resize-pane -t 3 -x " . marginSize
endfunction
" }}}

Plug 'takac/vim-hardtime'
" Plug 'bkad/CamelCaseMotion'
" Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-tbone'
" Other: {{{
" }}}
Plug 'prestidigitator92/vim-colors-solarized'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'beyondwords/vim-twig'
Plug 'leshill/vim-json'
Plug 'groenewege/vim-less'
Plug 'othree/html5.vim', {'for': ['html']}
Plug 'keith/tmux.vim'
