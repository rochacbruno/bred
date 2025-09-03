" On normal mode numbers are relative but in insert mode they are absolute {{{
augroup numbertoggle
  autocmd!
  autocmd InsertEnter * set norelativenumber
  autocmd InsertLeave * set relativenumber
augroup END
" }}}
" Automatic reload changed files {{{
" when files are changed externally automatically reload them
set autoread

" Check for file changes more frequently
if has('unix')
  " Use CursorHold to check periodically (every 4 seconds by default)
  autocmd CursorHold,CursorHoldI * checktime

  " Also check when entering/leaving insert mode and when saving
  autocmd InsertEnter,InsertLeave,BufWritePost * checktime

  " Check when window gains focus or entering buffer
  autocmd FocusGained,BufEnter,WinEnter * checktime

  " Reduce the time before CursorHold triggers (in milliseconds)
  " Default is 4000 (4 seconds), setting to 1000 (1 second)
  set updatetime=1000
endif

" Notify when file has changed and has local modifications
autocmd FileChangedShell * if v:fcs_choice == '' | echo 'Warning: File changed on disk, you have unsaved changes!' | endif
" }}}
" Autosave - here as reference, but disabled {{{
" -----------------------------
" set noswapfile

" augroup autosave
"     autocmd!
"     autocmd BufLeave,CursorHold,FocusLost * call s:AutoSave()
" augroup END
"
" function! s:AutoSave()
"     if getbufinfo('%')[0].changed
"         doautocmd BufWritePre
"         silent! update
"         doautocmd BufWritePost
"     endif
" endfunction
" -----------------------------
" }}}
" Autosession - save and restore session {{{
" Helper function for session saving
function! s:SaveSessionOnLeave()
    if len(v:argv) == 1
        " Close Splash buffer before saving session to avoid duplication
        for buf in getbufinfo()
            if has_key(buf, 'name') && (buf.name =~ 'Splash' || bufname(buf.bufnr) =~ 'Splash')
                execute 'bdelete! ' . buf.bufnr
            endif
        endfor
        mksession!
    endif
endfunction

augroup autosession
    autocmd!
    " Load session if Vim was started without files
    autocmd VimEnter * nested if len(v:argv) == 1 | silent! source Session.vim | endif
    
    " Save session when exiting (only if no files passed)
    autocmd VimLeave * call s:SaveSessionOnLeave()
augroup END
" }}}
" When editing git commit messages (make it easy to save/exit) {{{
augroup GitCommit
  autocmd!
  autocmd BufRead,BufNewFile COMMIT_EDITMSG nnoremap <buffer> q :wq<CR>
  autocmd BufRead,BufNewFile COMMIT_EDITMSG nnoremap <buffer> a :cq<CR>
  autocmd BufRead,BufNewFile COMMIT_EDITMSG startinsert
augroup END
" }}}
" If I am on insert mode and I leave the terminal, when I come back I want to be in normal mode {{{
augroup AutoNormalOnFocusLost
  autocmd!
  autocmd FocusLost * if mode() ==# 'i' | call feedkeys("\<Esc>", 'n') | endif
augroup END

" Exit insert mode when switching windows with mouse
augroup AutoNormalOnWindowSwitch
  autocmd!
  autocmd WinLeave * if mode() ==# 'i' | call feedkeys("\<Esc>", 'n') | endif
augroup END
" }}}
" Auto-highlight word under cursor {{{
augroup HighlightWordUnderCursor
    autocmd!
    autocmd CursorMoved,CursorMovedI * call HighlightWord()
augroup END

function! HighlightWord()
    if exists('w:word_match_id')
        silent! call matchdelete(w:word_match_id)
    endif
    
    let word = expand('<cword>')
    if !empty(word)
        let w:word_match_id = matchadd('WordUnderCursor', '\V\<' . escape(word, '\') . '\>')
    endif
endfunction
" }}}
" 
" vim: set foldmethod=marker foldlevel=0: