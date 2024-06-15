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

" coc
nmap <Leader>go <Plug>(coc-definition)

nmap <Leader>gs :vsplit<CR><Plug>(coc-definition)

nmap <Leader>rn <Plug>(coc-rename)

" open fzf
nmap <Leader>fs :Files<CR>

" ident
nmap <silent>fd ggVG=
nmap <silent>fl V=
