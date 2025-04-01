let mapleader = " "
nmap <Leader>ww :w<Enter>
nmap <Leader>wq :wq<Enter>
nmap <Leader>q :q!<Enter>

"serch for replace
nmap <Leader>b :%s/

"---------------------PLUGINS
"easymotion
nmap <Leader>s <Plug>(easymotion-s2)

" nerdtree
nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>nv :Vista<CR>

" coc
nmap <Leader>go <Plug>(coc-definition)

nmap <Leader>gs :vsplit<CR><Plug>(coc-definition)

nmap <F2> <Plug>(coc-rename)

" open fzf
nmap <Leader>f :Files<CR>

nmap <Leader>d :CocList diagnostics<CR>

nmap <Leader>Y :'<,'>!wl-copy<CR>
nmap <Leader>P :r!wl-paste<CR>
