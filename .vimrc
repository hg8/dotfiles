set nocompatible

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-sensible'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'joshdick/onedark.vim'
Plugin 'joshdick/airline-onedark.vim'
Plugin 'w0ng/vim-hybrid'


" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Syntastic needed config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" end Syntastic

" Powerline for Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:ycm_path_to_python_interpreter = '/usr/bin/python'

set number
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4
" Quick switch betwen split windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Resize slip vertical using + -, et <>
map - <c-w><
map + <c-w>>

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
let NERDTreeShowHidden=1
let mapleader=";"
inoremap jj <Esc>
nnoremap <Tab> :bnext<Cr>
syntax on
filetype plugin indent on

set background=dark
colorscheme hybrid
