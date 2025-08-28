" Define a custom command 'EHere' that opens a file in the current file's
" directory
command! -nargs=1 EHere edit %:h/<args>


" Auto commands
" On normal mode numbers are relative but in insert mode they are absolute
augroup numbertoggle
  autocmd!
  autocmd InsertEnter * set norelativenumber
  autocmd InsertLeave * set relativenumber
augroup END


" Automatic reload changed files
" when files are changes externally automatically reload them
" TODO: This is not working, needs investigation
set autoread
autocmd FocusGained,BufEnter * checktime


" -----------------------------
" Autosave - here as reference, but disabled 
" -----------------------------
" set noswapfile

" augroup autosave
"     autocmd!
"     autocmd BufLeave,CursorHold,FocusLost * {
"         if getbufinfo('%')[0].changed
"             doautocmd BufWritePre
"             silent! update
"             doautocmd BufWritePost
"         endif
"     }
" augroup END


" -----------------------------
" Autosession
" -----------------------------
augroup autosession
    autocmd!
    " Load session if Vim was started without files
    autocmd VimEnter * nested {
        if len(v:argv) == 1
            silent! source Session.vim
        endif
    }

    " Save session when exiting (only if no files passed)
    autocmd VimLeave * {
        if len(v:argv) == 1
            mksession!
        endif
    }
augroup END

" -------------------------------------------------------------------------
" End of Commands
" -------------------------------------------------------------------------

