tnoremap jk <C-\><C-n>

augroup Terminal
    au!
    au WinEnter term://* startinsert
augroup END
