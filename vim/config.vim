set encoding=UTF-8


"activate external copy and paste
set clipboard+=unnamed
set clipboard=unnamedplus
set mouse=a
set nowrap

set nu
set relativenumber 

set backspace=indent,eol,start

filetype plugin indent on

set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
"set expandtab

set undodir=~/undoFilesVim
set undofile

set hlsearch

"cursors
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"

set cursorline


set sidescroll=1
autocmd BufNew,BufRead *.asm set ft=nasm
