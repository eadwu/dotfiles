" plugin manager
call plug#begin('~/.vim/plugged')
Plug 'LnL7/vim-nix'
Plug 'vim-airline/vim-airline'
call plug#end()
" general settings
set expandtab
set relativenumber
set number
set background=dark
set shiftwidth=2
set softtabstop=2
set tabstop=2
set timeoutlen=1000
set ttimeoutlen=0
" plugin settings
let g:airline_theme='wal'

colorscheme faded_material
