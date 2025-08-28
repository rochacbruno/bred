
" --- Colors Theme ---
colorscheme purify

" --- Better defaults ---
set nocompatible
set number
set relativenumber
set hidden
set mouse=a
set clipboard=unnamedplus
set tabstop=4 shiftwidth=4 expandtab
set smartindent
set autoindent
set ignorecase smartcase
set incsearch hlsearch
set showmatch
set splitbelow splitright
set termguicolors
set signcolumn=auto
set undofile
set wildmenu
set wildmode=longest:full,full
set wildignorecase
set ttimeout ttimeoutlen=10
set timeout timeoutlen=500
set encoding=UTF-8

" --- Syntax & filetype ---
syntax on
filetype plugin indent on

" --- Status line ---
set laststatus=2
set showcmd
set noshowmode
set ruler
"set statusline=%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

set showtabline=2
set tabline=%!BufferTabLine()


" Search upwards for a manually created .viminfo file or use a default
let &viminfofile=findfile('.viminfo','.;') ?? $HOME . '/.vim/viminfo'
