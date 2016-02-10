set number
nmap <F8> :TagbarOpenAutoClose<CR> 
nmap <F9> :Tagbar<CR> 
let g:tagbar_type_python = {
    \ 'kinds' : [
        \ 'c:classes',
        \ 'f:functions',
        \ 'm:class members',
        \ 'v:variables:1',
        \ 'i:imports:1'
    \ ]
    \ }

let g:tagbar_type_php = {
    \ 'kinds' : [
        \ 'f:functions',
        \ 'j:javascript functions',
    \ ],
    \ }
let g:tagbar_map_jump = 'o'
let g:tagbar_map_togglefold = 'za'

map <F2> :NERDTreeToggle <CR>
let NERDTreeQuitOnOpen=1
let mapleader=";"
inoremap jj <Esc>
nnoremap <Tab> :bnext<Cr>
syntax on
filetype plugin indent on

execute pathogen#infect()
