# This file contains shell aliases for convenience.
# To use these aliases, source this file in your shell configuration file (e.g., .bashrc or .zshrc).
# Example: source ~/.vim/shell_aliases.sh
alias vimrc='vim ~/.vim/vimrc'
# open vim and put clipboard content in new line
alias vimp='vim "+norm Go" "+put +"'
# open vim without any plugins or custom configurations
alias vimc='vim --clean'
# Open fzf with preview and open selected file in vim
alias vimf='fzf --preview "bat --style=numbers --color=always --line-range :500 {}" --height 90% --layout=reverse --border --bind shift-up:preview-page-up,shift-down:preview-page-down | xargs -o -r vim'
alias vimrg='rg --line-number --no-heading --color=always "" | fzf --ansi --delimiter : --nth 1,2,3 | awk -F: "{print \"+\"\$2\" \"\$1}" | xargs -o -r vim'


# Open vim with minimal custom settings for Python development
alias uvim="vim -u <(cat << 'EOF'
let mapleader=' '|set nu rnu hid bs=2 ts=4 sw=4 et ai si nocp wmnu tw=79 cc=80 stal=2 cot=menuone,longest,preview ph=10 ruler statusline=%f%m%r%h%w%=%y\ %l,%c\ %p%%
let g:p=executable('uv')?'uv run python3':'python3'|let g:d=g:p.' -m pydoc'|let g:c=g:p.' -m py_compile'
filetype plugin indent on|sy on|nn <leader>b :ls<cr>:b<space>|nn <leader><Tab> <C-^>
au FileType python setl ofu=python3complete#Complete cot=menuone,longest,preview inc=^\s*\(from\|import\) def=^\s*\(def\|class\)|exe 'setl kp='.escape(g:d,' ')|nn <buffer> <leader>k :exe 'vert term ++close '.g:d.' '.expand('<cWORD>')<CR>|nn <buffer> <leader>r :w<CR>:exe '!'.g:p.' %'<CR>
au BufWritePost *.py silent! exe '!'.g:c.' %'
au CompleteDone * pc
EOF
)"
