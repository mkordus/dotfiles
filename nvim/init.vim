" vi: fdm=marker


set clipboard=unnamedplus

call plug#begin()
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary' 
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion', {'do': 'yarn install --frozen-lockfile'}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-slash'
Plug 'neovimhaskell/haskell-vim'
Plug 'derekwyatt/vim-scala'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'scalameta/nvim-metals'
Plug 'glepnir/lspsaga.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'phaazon/hop.nvim'
Plug 'jlanzarotta/bufexplorer'
Plug '907th/vim-auto-save'
Plug 'janko/vim-test'
Plug 'kassio/neoterm'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'jmckiern/vim-venter'
Plug 'sirtaj/vim-openscad'
Plug 'tmhedberg/SimpylFold'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

if filereadable(expand('~/dotfiles/nvim/local.vim'))
    source ~/dotfiles/nvim/local.vim
endif

let g:mapleader = "\<Space>"
lua require 'init'

"new

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType scala,sbt lua require('metals').initialize_or_attach(metals_config)
  augroup end
endif

set shortmess-=F
set shortmess+=c

set nu
set cursorline

"status: {{{
set noshowmode
set laststatus=2
"}}}

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" LSP config (the mappings used in the default file don't quite work right)
" nnoremap <silent> <leader>d :Lspsaga lsp_finder<CR>
nnoremap <silent> <leader>d <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <leader>D <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>i <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <C-k> :Lspsaga signature_help<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-j> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>r :Lspsaga rename<CR>
nnoremap <silent> <leader>a :Lspsaga code_action<CR>

" auto-format
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.scala lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.sbt lua vim.lsp.buf.formatting_sync(nil, 100)

"new

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
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

tnoremap <esc><esc> <c-\><c-n>

set clipboard=unnamedplus
set mouse=a
set virtualedit=block
set signcolumn=yes
let &showbreak = '↓↓  '

nnoremap <silent> <c-p> <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>p <cmd>Telescope project<cr>

nnoremap <silent> s :HopWord<cr>

nnoremap <silent> <Leader>h <c-w>h
nnoremap <silent> <Leader>l <c-w>l
nnoremap <silent> <Leader>k <c-w>k
nnoremap <silent> <Leader>j <c-w>j
" BufferExplorer: {{{
let g:bufExplorerDefaultHelp=0
let g:bufExplorerDisableDefaultKeyMapping=1
let g:bufExplorerShowNoName=1
let g:bufExplorerShowRelativePath=1
let g:bufExplorerShowTabBuffer=1
let g:bufExplorerSortBy='fullpath'
nnoremap <leader>e :BufExplorer<CR>
"}}}
" Ranger: {{{
let g:ranger_replace_netrw = 1
let g:ranger_map_keys = 0
nmap <silent> <BS> :Ranger<CR>
nmap <silent> <c-h> :Ranger<CR>
"}}}
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
nnoremap <leader>n :call SetBloopProject(g:bloopProjects)<CR>:TestNearest<CR>

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
      \     "alternate": ["src/test/scala/{}Spec.scala", "src/test/scala/{}ImplSpec.scala", "src/test/scala/{}IntegrationSpec.scala", "src/test/scala/{}Test.scala"],
      \     "type": "src"
      \   },
      \   "src/test/scala/*Spec.scala": {
      \     "alternate": "src/main/scala/{}.scala",
      \     "type": "test"
      \   },
      \   "src/test/scala/*ImplSpec.scala": {
      \     "alternate": "src/main/scala/{}.scala",
      \     "type": "test"
      \   },
      \   "src/test/scala/*IntegrationSpec.scala": {
      \     "alternate": "src/main/scala/{}.scala",
      \     "type": "test"
      \   },
      \   "src/test/scala/*Test.scala": {
      \     "alternate": "src/main/scala/{}.scala",
      \     "type": "test"
      \   },
      \   "build.sbt": { "type": "config" },
      \   "*.sbt": { "type": "config" },
      \ }
      \}
nnoremap <leader>t :A<CR>
" }}}
" nnoremap <silent> <leader>a :call SearchWordWithAg()<CR>
" vnoremap <silent> <leader>a :call SearchVisualSelectionWithAg()<CR>

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
