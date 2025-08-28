# Bruno Rocha VIM 0 Config.

This repository contains my personal VIM configuration files and plugins. It is designed to provide a streamlined and efficient VIM setup for coding and text editing.

> [!WARNING]
> This configuration is for VIM 9+ only, NOT for Neovim or older versions of VIM.


## Requirements

- VIM 9 or higher
- Git
- curl (for plugin installation)
- A terminal that supports 256 colors
- ripgrep
- fzf
- Rust

## Installation

```bash
# Backup your existing .vim directory if you have one
mv ~/.vim ~/.vim_backup
git clone https://github.com/rochacbruno/vim ~/.vim
vim +PlugInstall +qall
```

## Features
