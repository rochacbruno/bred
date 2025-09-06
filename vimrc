" =========================================================================
" RochaCBruno's Vim 9.1 and Configuration
" =========================================================================
" This is the main entry point that loads all modular configuration files
" Works with Vim 9.1+ (Neovim compatible but not fully tested)
" =========================================================================

" If there is a custom.vim in the same directory as this file, load it
" This allows for user-specific overrides without modifying the main config
if filereadable(expand("~/.vim/custom.vim"))
    source ~/.vim/custom.vim
else
    " -------------------------------------------------------------------------
    " Leader Key Configuration
    " -------------------------------------------------------------------------
    " Set space as the leader key for custom mappings
    let mapleader = " "
    let maplocalleader = ","

    if !has('nvim')
        " =========================================================================
        " VIM 9 CONFIGURATION
        " =========================================================================
        source ~/.vim/bred/kitty.vim          " Kitty terminal integration
        source ~/.vim/bred/mapdocs.vim        " Documentation for custom mappings
        source ~/.vim/bred/functions.vim      " Custom utility functions
        source ~/.vim/bred/commands.vim       " Custom commands and autocommands
        source ~/.vim/bred/plugins.vim        " Plugin management and configuration
        source ~/.vim/bred/flagmarks.vim      " Custom global marks management system
        source ~/.vim/bred/options.vim        " Core Vim options and settings
        source ~/.vim/bred/custom_colors.vim  " Color scheme fixes and customizations
        source ~/.vim/bred/mappings.vim       " Key mappings and shortcuts
        source ~/.vim/bred/splash.vim         " Splash screen for empty Vim startup
        source ~/.vim/bred/snippets.vim       " Snippets from abbreviations
        source ~/.vim/bred/newwin.vim         " Custom new window command
    else
        " =========================================================================
        " NEOVIM COMPAT CONFIGURATION
        " NOTE: Some features may not work as expected
        " I am too lazy to make the bred config fully compatible
        " and I don't use Neovim enough to care.
        " =========================================================================
        source ~/.vim/nvim_compat/functions.vim         " Compatibility layer for Vim/Neovim
        source ~/.vim/bred/mapdocs.vim                  " Documentation for custom mappings
        source ~/.vim/nvim_compat/functions.vim         " Custom utility functions
        source ~/.vim/nvim_compat/commands.vim          " Custom commands and autocommands
        source ~/.vim/nvim_compat/plugins.vim           " Neovim-specific settings
        source ~/.vim/nvim_compat/flagmarks.vim         " Custom marks with popup compatibility
        source ~/.vim/nvim_compat/options.vim           " Neovim-specific options
        source ~/.vim/bred/custom_colors.vim            " Color scheme fixes and customizations
        source ~/.vim/bred/mappings.vim                 " Key mappings and shortcuts
        source ~/.vim/bred/splash.vim                   " Splash screen for empty startup
        source ~/.vim/bred/snippets.vim                 " Snippets from abbreviations
    endif
endif
