# This file contains shell aliases for convenience.
# To use these aliases, source this file in your shell configuration file (e.g., .bashrc or .zshrc).
# Example: source ~/.vim/shell_aliases.sh
alias vimrc='vim ~/.vim/vimrc'
# open vim and put clipboard content in new line
alias vimp='vim "+norm Go" "+put +"'
# open vim without any plugins or custom configurations
alias vimc='vim --clean'
# Open fzf with preview and open selected file in vim
alias vimf='fzf --preview "bat --style=numbers --color=always {} --line-range :500 {}" --height 40% --layout=reverse --border --bind shift-up:preview-page-up,shift-down:preview-page-down | xargs -o -r vim'
