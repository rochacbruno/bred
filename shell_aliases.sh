# This file contains shell aliases for convenience.
# To use these aliases, source this file in your shell configuration file (e.g., .bashrc or .zshrc).
# Example: source ~/.vim/shell_aliases.sh

alias vimrc='vim ~/.vim/vimrc'
alias vimrcf='vim ~/.vim/functions.vim'
alias vimrcc='vim ~/.vim/commands.vim'
alias vimrcp='vim ~/.vim/plugins.vim'
alias vimrco='vim ~/.vim/options.vim'
alias vimrcm='vim ~/.vim/mappings.vim'
# open vim and put clipboard content in new line
alias vimp='vim "+norm Go" "+put +"'
# open vim without any plugins or custom configurations
alias vimc='vim --clean'
