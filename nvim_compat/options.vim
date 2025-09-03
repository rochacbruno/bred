" =========================================================================
" Base Vim Options and Settings - Compatible with both Vim and Neovim
" =========================================================================

" -------------------------------------------------------------------------
" Color Scheme
" -------------------------------------------------------------------------
" Load color scheme with fallback
try
    colorscheme purify
catch /E185/
    " Color scheme not found, use default
    colorscheme default
    echom "Note: purify color scheme not found, using default"
endtry

" -------------------------------------------------------------------------
" Editor Defaults and Behavior {{{
" -------------------------------------------------------------------------
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
set cc=80                     " Highlight column 80 for line length guidance
set cursorline                " Highlight the current line

" }}}
" -------------------------------------------------------------------------
" Syntax Highlighting and File Type Detection {{{
" -------------------------------------------------------------------------

syntax on                     " Enable syntax highlighting
filetype plugin indent on     " Enable file type detection, plugins, and indentation

"  }}}
" -------------------------------------------------------------------------
" Status Line and Tab Line Configuration {{{
" -------------------------------------------------------------------------

set laststatus=2              " Always show status line
set showcmd                   " Show partial commands in the last line
set noshowmode                " Don't show mode (handled by status line plugin)
set ruler                     " Show cursor position in status line

" Tab line shows open buffers as tabs
set showtabline=2             " Always show tab line
set tabline=%!BufferTabLine() " Use custom function for buffer tabs

"  }}}
" -------------------------------------------------------------------------
" Shada File Location (Neovim's viminfo equivalent) {{{
" -------------------------------------------------------------------------
" Search upwards for a project-specific shada file or use default location
let &shadafile=findfile('.nvim.shada','.;') != '' ? findfile('.nvim.shada','.;') : $HOME . '/.config/nvim/shada'

" }}}
" -------------------------------------------------------------------------
" Neovim-specific Performance Options {{{
" -------------------------------------------------------------------------
set lazyredraw                " Don't redraw while executing macros (better performance)
set updatetime=300            " Faster completion and diagnostic messages
set shortmess+=c              " Don't pass messages to |ins-completion-menu|

" }}}
" -------------------------------------------------------------------------
" Neovim Provider Settings {{{
" -------------------------------------------------------------------------
" Disable providers we don't need for better startup time
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0

" Enable Python3 provider if needed (for plugins that require it)
if executable('python3')
    let g:python3_host_prog = exepath('python3')
endif

" }}}

" vim: set foldmethod=marker foldlevel=0:
