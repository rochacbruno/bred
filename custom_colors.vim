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

" Use colorcolumn to create dimming effect
augroup DimInactiveWindows
  autocmd!
  autocmd WinEnter * set colorcolumn=
  autocmd WinLeave * let &l:colorcolumn=join(range(1,999),',')
augroup END

" Very subtle dim - adjust the color to your preference
" This works well with the purify colorscheme
highlight ColorColumn guibg=#252932

" Underline the word under the cursor
" highlight WordUnderCursor cterm=underline gui=underline guibg=#3c3836
highlight WordUnderCursor cterm=underline gui=underline

" -------------------------------------------------------------------------
" End of Custom Colors
" -------------------------------------------------------------------------
