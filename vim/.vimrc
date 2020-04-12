filetype plugin indent on
syntax on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set history=1000
set showmatch
set autoindent
set cindent
set showcmd
set smartindent
set noswapfile
set cursorline
set t_Co=256
set hlsearch
set incsearch
set ignorecase
set smartcase
set smarttab
set encoding=utf-8
set completeopt=longest,menu
set confirm
set lbr
set clipboard=unnamedplus
set mouse=a


" enable pwoerline font
let g:airline_powerline_fonts = 1


if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
