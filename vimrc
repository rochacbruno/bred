" =========================================================================
" RochaCBruno's Vim 9.1 Configuration
" =========================================================================
" This is the main entry point that loads all modular configuration files
" =========================================================================


" If there is a custom.vim in the same directory as this file, load it
" " This allows for user-specific overrides without modifying the main config
if filereadable(expand("~/.vim/custom.vim"))
    source ~/.vim/custom.vim
else
    " -------------------------------------------------------------------------
    " Leader Key Configuration
    " -------------------------------------------------------------------------
    " Set comma as the leader key for custom mappings
    let mapleader = " "
    let maplocalleader = ","

    " -------------------------------------------------------------------------
    " Load Configuration Modules
    " -------------------------------------------------------------------------
    " Order matters: functions and commands first, then plugins, then settings
    source ~/.vim/kitty.vim          " Kitty terminal integration
    source ~/.vim/mapdocs.vim        " Documentation for custom mappings
    source ~/.vim/functions.vim      " Custom utility functions
    source ~/.vim/commands.vim       " Custom commands and autocommands
    source ~/.vim/plugins.vim        " Plugin management and configuration
    source ~/.vim/flagmarks.vim      " Custom global marks management system
    source ~/.vim/options.vim        " Core Vim options and settings
    source ~/.vim/custom_colors.vim  " Color scheme fixes and customizations
    source ~/.vim/mappings.vim       " Key mappings and shortcuts
    source ~/.vim/splash.vim         " Splash screen for empty Vim startup
    source ~/.vim/snippets.vim       " Snippets from abbreviations
endif

