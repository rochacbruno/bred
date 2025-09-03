" This fixes the colors in Mistfly theme for various modes
" -- Status line
function! s:ApplyCustomColors()
    highlight! link MistflyNormal DiffChange
    highlight! link MistflyInsert WildMenu
    highlight! link MistflyVisual IncSearch
    highlight! link MistflyCommand WildMenu
    highlight! link MistflyReplace ErrorMsg
    " If using linefly on neovim 
    highlight! link lineflyNormal DiffChange
    highlight! link lineflyInsert WildMenu
    highlight! link lineflyVisual IncSearch
    highlight! link lineflyCommand WildMenu
    highlight! link lineflyReplace ErrorMsg

    
    " Highlight Inlay hints
    highlight! link LspInlayHints Comment
    highlight! link LspInlayHintsType Comment
    highlight! link LspInlayHintsParam Comment
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
  " save current colorcolumn setting
  let g:saved_colorcolumn = &l:colorcolumn
  " set colorcolumn to empty when entering window
  autocmd WinEnter * execute 'let &l:colorcolumn=g:saved_colorcolumn'
  autocmd WinLeave * let &l:colorcolumn=join(range(1,999),',')
augroup END

" Very subtle dim - adjust the color to your preference
" This works well with the purify colorscheme
highlight ColorColumn guibg=#252932
highlight CursorLine guibg=#252932 cterm=NONE gui=NONE
highlight CursorLineNr guibg=#252932 cterm=NONE gui=NONE

" Underline the word under the cursor
" highlight WordUnderCursor cterm=underline gui=underline guibg=#3c3836
highlight WordUnderCursor cterm=underline gui=underline


" -------------------------------------------------------------------------
" End of Custom Colors
" -------------------------------------------------------------------------
