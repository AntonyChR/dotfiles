"------------------INSTALL VIM PLUG
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"polygolt set nocompatible

"----------------PLUGINS-------------------
call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'

Plug 'alvan/vim-closetag'
 
Plug 'easymotion/vim-easymotion'

Plug 'scrooloose/nerdtree'

Plug 'ryanoasis/vim-devicons'

Plug 'christoomey/vim-tmux-navigator'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'airblade/vim-gitgutter'

Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'balanceiskey/vim-framer-syntax', { 'branch': 'main' }

Plug 'wuelnerdotexe/vim-astro'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'liuchengxu/vista.vim'
call plug#end()
"-------------------------------------------


"---------------------PLUGINS CONFIGURATION
"
let g:astro_typescript = 'enable'
let g:astro_stylus = 'enable'

"-----> Nerdtree 
let NERDTreeQuitOnOpen=1 "close menu after select file
let NERDTreeShowHidden=1 "show hidden files
let NERDTreeHijackNetrw=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore = ['^node_modules$','.next']

"-----> easymotion
let g:EasyMotion_do_mapping = 0 " disable default mappingslet 

"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : """\<C-g>u\<CR>"

"press K to show documentation 
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"define color of the autocomplete menu
"hi CocInfoFloat guifg=gray guibg=#201c1c
set termguicolors
"colorscheme torte
colorscheme slate 
colorscheme quiet 

"--------- vista
let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
"----->AIRLINETHEME
let g:airline_symbols = {}
let g:airline_theme = 'molokai' " Avaible themes => https://github.com/vim-airline/vim-airline/wiki/Screenshots
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#hunks#enabled = 1
let g:airline_symbols.branch = ''
