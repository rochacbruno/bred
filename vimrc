" =========================================================================
" RochaCBruno's Vim 9.1 Configuration
" =========================================================================
" This is the main entry point that loads all modular configuration files
" =========================================================================

" -------------------------------------------------------------------------
" Leader Key Configuration
" -------------------------------------------------------------------------
" Set comma as the leader key for custom mappings
let mapleader = ","
let maplocalleader = ","

" -------------------------------------------------------------------------
" Load Configuration Modules
" -------------------------------------------------------------------------
" Order matters: functions and commands first, then plugins, then settings
source ~/.vim/functions.vim      " Custom utility functions
source ~/.vim/commands.vim       " Custom commands and autocommands
source ~/.vim/plugins.vim        " Plugin management and configuration
source ~/.vim/flagmarks.vim      " Custom global marks management system
source ~/.vim/custom_colors.vim  " Color scheme fixes and customizations
source ~/.vim/options.vim        " Core Vim options and settings
source ~/.vim/mappings.vim       " Key mappings and shortcuts

