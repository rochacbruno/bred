" =========================================================================
" Splash Screen for Vim
" =========================================================================
" Shows ~/.vim/splash.md when Vim starts with no arguments
" The splash screen disappears when:
" - User enters insert mode (switches to empty buffer)
" - User opens a file
" - User executes commands that would modify the buffer

" -------------------------------------------------------------------------
" Splash Screen Function
" -------------------------------------------------------------------------
function! ShowSplash() abort
    " Only show splash if:
    " - No files were provided as arguments
    " - Not reading from stdin
    " - Not in diff mode
    " - Not starting in insert mode
    " - No commands were passed with -c or +
    if argc() > 0 || &insertmode || &diff
        return
    endif
    
    " Check if we're reading from stdin (when - is used as filename)
    if @% == '-' || line('$') > 1 || getline(1) != ''
        return
    endif
    
    " Check if splash.md exists
    let l:splash_file = expand('~/.vim/splash_message.vim')
    if !filereadable(l:splash_file)
        return
    endif
    
    " Create a new buffer for the splash screen
    enew
    
    " Set buffer name to something recognizable
    silent! file [Splash]
    
    " Read the splash file content
    silent! execute '0read ' . l:splash_file
    
    " Interpolate variables
    let l:vim_version = v:version / 100 . '.' . v:version % 100
    let l:vimrc_path = expand($MYVIMRC != '' ? $MYVIMRC : '~/.vimrc')
    let l:current_date = strftime('%Y-%m-%d %H:%M:%S')
    
    " Replace variables in the buffer
    silent! %s/\$VIMVERSION/\=l:vim_version/g
    silent! %s/\$MYVIMRC/\=l:vimrc_path/g
    silent! %s/\$DATE/\=l:current_date/g
    
    " Remove the empty line at the end if it exists
    if line('$') > 1 && getline('$') == ''
        normal! Gdd
    endif
    
    " Go to the top of the buffer
    normal! gg
    
    " Make the buffer temporary and read-only
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal nomodifiable
    setlocal nomodified
    setlocal readonly
    setlocal nonumber
    setlocal norelativenumber
    setlocal nocursorline
    setlocal nocursorcolumn
    setlocal signcolumn=no
    setlocal nolist
    setlocal nospell
    setlocal colorcolumn=
    
    " set folding based on marker
    setlocal foldmethod=marker
    setlocal foldlevel=0
    setlocal fmr={,}
    setlocal ft=help    
    " Center the content if the window is wide enough
    setlocal nowrap
    
    " Set up mappings for this buffer to handle insert mode
    " When entering insert mode, clear splash and start fresh
    nnoremap <buffer> i :call CloseSplashAndInsert()<CR>
    nnoremap <buffer> I :call CloseSplashAndInsert()<CR>
    nnoremap <buffer> a :call CloseSplashAndInsert()<CR>
    nnoremap <buffer> A :call CloseSplashAndInsert()<CR>
    nnoremap <buffer> o :call CloseSplashAndInsert()<CR>
    nnoremap <buffer> O :call CloseSplashAndInsert()<CR>
    nnoremap <buffer> s :call CloseSplashAndInsert()<CR>
    nnoremap <buffer> S :call CloseSplashAndInsert()<CR>
    nnoremap <buffer> c :call CloseSplashAndInsert()<CR>
    nnoremap <buffer> C :call CloseSplashAndInsert()<CR>
    
    " Override commands that would edit the splash buffer
    nnoremap <buffer> dd <Nop>
    nnoremap <buffer> D <Nop>
    nnoremap <buffer> x <Nop>
    nnoremap <buffer> X <Nop>
    vnoremap <buffer> d <Nop>
    vnoremap <buffer> x <Nop>

    " Map enter and tab to `za` to toggle folds
    nnoremap <buffer> <CR> zazz
    nnoremap <buffer> <Tab> zazz

    " Allow normal navigation
    " q to quit still works
    " :e filename still works to open files
    
    " Set up autocommands to close splash when opening files
    augroup SplashScreen
        autocmd!
        " Close splash when any file is opened
        autocmd BufReadPre * call CloseSplash()
        " Close splash when creating a new file
        autocmd BufNewFile * call CloseSplash()
        " Close splash if user tries to save (shouldn't happen but just in case)
        autocmd BufWritePre [Splash] call CloseSplashAndInsert()
    augroup END
    
    " Mark that splash is active
    let g:splash_active = 1
endfunction

" -------------------------------------------------------------------------
" Close Splash Screen
" -------------------------------------------------------------------------
function! CloseSplash() abort
    if exists('g:splash_active') && g:splash_active
        " Check if we're in the splash buffer
        if bufname('%') == '[Splash]'
            " Just wipe the buffer since it's set to bufhidden=wipe
            bwipeout
        endif
        let g:splash_active = 0
        
        " Clean up the autocommand group
        augroup SplashScreen
            autocmd!
        augroup END
    endif
endfunction

" -------------------------------------------------------------------------
" Close Splash and Enter Insert Mode
" -------------------------------------------------------------------------
function! CloseSplashAndInsert() abort
    if exists('g:splash_active') && g:splash_active
        " Create a new empty buffer
        enew
        " The splash buffer will be wiped automatically due to bufhidden=wipe
        let g:splash_active = 0
        
        " Clean up the autocommand group
        augroup SplashScreen
            autocmd!
        augroup END
        
        " Enter insert mode
        startinsert
    endif
endfunction

" -------------------------------------------------------------------------
" Initialize Splash Screen on Vim startup
" -------------------------------------------------------------------------
augroup SplashInit
    autocmd!
    " Show splash screen when Vim starts
    autocmd VimEnter * nested call ShowSplash()
augroup END

" vim: set ft=vim:
