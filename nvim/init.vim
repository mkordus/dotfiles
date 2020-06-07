" vi: fdm=marker

set clipboard=unnamedplus

call plug#begin()
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-projectionist'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-slash'
Plug 'neovimhaskell/haskell-vim'
Plug 'derekwyatt/vim-scala'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mkordus/goyo.vim'
Plug 'gabenespoli/vim-mutton'
Plug 'easymotion/vim-easymotion'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'jlanzarotta/bufexplorer'
Plug '907th/vim-auto-save'
Plug 'janko/vim-test'
Plug 'kassio/neoterm'
call plug#end()

let g:mapleader = "\<Space>"

set termguicolors
colorscheme gruvbox
hi clear SignColumn
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
hi EndOfBuffer ctermfg=235 guifg=#282828

set clipboard=unnamedplus
set mouse=a
set virtualedit=block
set signcolumn=yes
let &showbreak = '↓↓  '

" Goyo: {{{
" Enable Goyo at startup Vim
autocmd VimEnter * Goyo
" Exit Vim at exitting Goyo
autocmd! User GoyoLeave q
let g:goyo_width = 110
let g:goyo_height = "100%"
" }}}
" FZF: {{{
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_preview_window = ''
nnoremap <silent> <c-p> :GFiles<CR>
nnoremap <silent> <c-space> :Buffers<CR>
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
" FileBeagle: {{{
let loaded_netrwPlugin = 1
let g:filebeagle_suppress_keymaps = 1

map <silent> _ <Plug>FileBeagleOpenCurrentWorkingDir
map <silent> - <Plug>FileBeagleOpenCurrentBufferDir
nmap <silent> <BS> <Plug>FileBeagleOpenCurrentBufferDir
map <silent> <c-h> <Plug>FileBeagleOpenCurrentBufferDir
" nmap <silent> <c-h> :CocCommand explorer --open-action-strategy sourceWindow --position floating<CR>
"}}}
" Coc.vim: {{{

" GoTo code navigation.
nmap <leader>d <Plug>(coc-definition)
nmap <leader>t <Plug>(coc-type-definition)
nmap <leader>i <Plug>(coc-implementation)
nmap <leader>u <Plug>(coc-references)
nmap <leader>r <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" }}}
" Fugitive: {{{
nnoremap <silent> gs :Ge :<CR>
nnoremap <silent> gd :Git! diff<CR>
nnoremap <silent> ga :Gblame<CR>
nnoremap <silent> gl :Glog -n 10 --no-merges<CR>
autocmd! FileType fugitive nnoremap <buffer> <esc> :b#<CR>
" }}}
" AutoSave: {{{
let g:auto_save        = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]
" }}}
" EasyMotion: {{{
nmap s <Plug>(easymotion-s2)
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)
" }}}
" VimTest: {{{
function! VimTestCustom(cmd)
  let originBuffer = bufnr("%")
  call neoterm#open({ 'mod': '', 'target': 0})
  call neoterm#clear({ 'target': 0})
  execute 'nnoremap <buffer> <esc> :b ' . originBuffer . '<CR>'
  execute 'tnoremap <buffer> <c-space> <C-\><C-n>:b ' . originBuffer . '<CR>'
  call neoterm#do({ 'cmd': a:cmd, 'target': 0})
endfunction

let test#scala#runner = 'blooptest'

let g:test#custom_strategies = {'custom': function('VimTestCustom')}
let g:test#strategy = 'custom'

nnoremap <leader>f :call SetBloopProject(g:bloopProjects)<CR>:TestFile<CR>
nnoremap <leader>s :call SetBloopProject(g:bloopProjects)<CR>:TestSuite<CR>

func! ParseBloop()
  let configs = globpath('.bloop', '*.json', 0, 1)
  let projects = []

  for path in configs
    let json = json_decode(readfile(path))
    if has_key(json, 'project')
      let project = json['project']
      let sources = project['sources']
      let name = project['name']
      call add(projects, {'name': name, 'sources': sources})
    endif
  endfor

  return projects
endfunc

autocmd VimEnter * let g:bloopProjects = ParseBloop()

func! SetBloopProject(projects)
  if (&filetype == 'scala')
    let file = expand('%:p')
    for project in a:projects
      for path in project['sources']
        if stridx(file, path) == 0
          let g:test#scala#blooptest#project_name = project['name']
          return
        endif
      endfor
    endfor
  endif
endfunc

" }}}
" NeoTerm: {{{
let g:neoterm_autojump = 1
let g:neoterm_autoscroll = 1

function! OpenTerminal()
  let originBuffer = bufnr("%")
  call neoterm#open({ 'mod': '', 'target': 0})
  execute 'nnoremap <buffer> <esc> :b ' . originBuffer . '<CR>'
  execute 'tnoremap <buffer> <c-space> <C-\><C-n>:b ' . originBuffer . '<CR>'
  startinsert
endfunction

nnoremap <c-space> :call OpenTerminal()<CR>

" }}}
" github.com/zenbro/dotfiles {{{
function! SearchWordWithAg()
    execute 'Ag ' expand('<cword>')
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
    execute 'Ag ' selection
endfunction
" }}}
" VimProjectionist: {{{
let g:projectionist_heuristics = {
      \ "package.json": {
      \   "README.md": { "type": "doc" },
      \   "*": {
      \     "console": "node",
      \     "make": "npm",
      \     "start": "npm start"
      \   },
      \   "lib/*.js": {
      \     "type": "src",
      \     "alternate": "test/{}.js"
      \   },
      \   "test/*.js": {
      \     "type": "test",
      \     "alternate": "lib/{}.js",
      \     "dispatch": "yarn test {}"
      \   },
      \   "package.json": { "type": "package" }
      \ },
      \ "build.sbt": {
      \   "README.md": { "type": "doc" },
      \   "*": {
      \     "console": "bloop console",
      \     "make": "bloop compile",
      \     "start": "bloop run"
      \   },
      \   "src/main/scala/*.scala": {
      \     "alternate": "src/test/scala/{}Spec.scala",
      \     "type": "src"
      \   },
      \   "src/test/scala/*Spec.scala": {
      \     "alternate": "src/main/scala/{}.scala",
      \     "type": "test"
      \   },
      \   "build.sbt": { "type": "config" },
      \   "*.sbt": { "type": "config" },
      \ }
      \}
" }}}
nnoremap <silent> <leader>a :call SearchWordWithAg()<CR>
vnoremap <silent> <leader>a :call SearchVisualSelectionWithAg()<CR>

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]


set updatetime=300

"searching
set ignorecase
set smartcase
set incsearch
set magic

"substitute
set gdefault

" no idea what it does
nnoremap > ]mzt
nnoremap < [mzt

" wrapping lines in visual mode
vnoremap < <gv
vnoremap > >gv

" uppercase last word
inoremap <c-u> _<Esc>mzi<S-Right><C-o>b<C-o>gUiw<C-o>`z<Del>
