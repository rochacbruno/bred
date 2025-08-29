" This fixes the colors in Mistfly theme for various modes
" -- Status line
function! s:ApplyCustomColors()
    highlight! link MistflyNormal DiffChange
    highlight! link MistflyInsert WildMenu
    highlight! link MistflyVisual IncSearch
    highlight! link MistflyCommand WildMenu
    highlight! link MistflyReplace ErrorMsg
endfunction

" Apply colors on startup
call s:ApplyCustomColors()

" Reapply colors on various events
augroup CustomColors
    autocmd!
    " Reapply after color scheme changes
    autocmd ColorScheme * call s:ApplyCustomColors()
    " Reapply when entering/leaving Goyo
    autocmd User GoyoEnter nested call s:ApplyCustomColors()
    autocmd User GoyoLeave nested call s:ApplyCustomColors()
    " Reapply on window enter/leave
    autocmd WinEnter * call s:ApplyCustomColors()
    " Reapply after any plugin window closes
    autocmd BufWinEnter * call s:ApplyCustomColors()
augroup END

" -------------------------------------------------------------------------
" End of Custom Colors
" -------------------------------------------------------------------------
