" =========================================================================
" Vim Options and Settings
" =========================================================================

" -------------------------------------------------------------------------
" Color Scheme
" -------------------------------------------------------------------------
" Set the main color theme for the editor
colorscheme purify

" -------------------------------------------------------------------------
" Editor Defaults and Behavior
" -------------------------------------------------------------------------
" Essential settings for a modern Vim experience
set nocompatible              " Disable Vi compatibility mode
set number                    " Show absolute line numbers
set relativenumber            " Show relative line numbers for easier navigation
set hidden                    " Allow switching buffers without saving
set mouse=a                   " Enable mouse support in all modes
set clipboard=unnamedplus     " Use system clipboard for all operations
set tabstop=4 shiftwidth=4 expandtab  " Use 4 spaces for tabs and indentation
set smartindent                        " Smart indentation based on syntax
set autoindent                         " Copy indent from current line when starting new line
set ignorecase smartcase      " Case-insensitive search unless uppercase is used
set incsearch hlsearch        " Incremental search with highlighting
set showmatch                 " Briefly highlight matching brackets
set splitbelow splitright     " Open new splits below and to the right
set termguicolors             " Enable 24-bit RGB colors
set signcolumn=auto           " Show sign column when needed (for git, diagnostics)
set undofile                  " Persist undo history between sessions
set wildmenu                  " Enhanced command-line completion
set wildmode=longest:full,full  " Complete longest common match, then full
set wildignorecase            " Case-insensitive file completion
set ttimeout ttimeoutlen=10   " Quick escape key response
set timeout timeoutlen=500    " Time to wait for mapped sequences
set encoding=UTF-8            " Use UTF-8 encoding for better character support

" -------------------------------------------------------------------------
" Syntax Highlighting and File Type Detection
" -------------------------------------------------------------------------
syntax on                     " Enable syntax highlighting
filetype plugin indent on     " Enable file type detection, plugins, and indentation

" -------------------------------------------------------------------------
" Status Line and Tab Line Configuration
" -------------------------------------------------------------------------
set laststatus=2              " Always show status line
set showcmd                   " Show partial commands in the last line
set noshowmode                " Don't show mode (handled by status line plugin)
set ruler                     " Show cursor position in status line
" set statusline=%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P  " Custom status line format (disabled in favor of plugin)

" Tab line shows open buffers as tabs
set showtabline=2             " Always show tab line
set tabline=%!BufferTabLine() " Use custom function for buffer tabs

" -------------------------------------------------------------------------
" Vim Info File Location
" -------------------------------------------------------------------------
" Search upwards for a project-specific .viminfo file or use default location
let &viminfofile=findfile('.viminfo','.;') ?? $HOME . '/.vim/viminfo'

" -------------------------------------------------------------------------
" Custom Options Extension Point
" -------------------------------------------------------------------------
" TODO: Check for a custom.options.vim file and source it here
" This would allow user-specific options without modifying the main config
