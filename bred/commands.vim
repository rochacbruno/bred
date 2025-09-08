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
  " Skip checktime in command-line window to avoid E11 error
  autocmd CursorHold,CursorHoldI * if getcmdwintype() == '' | checktime | endif

  " Also check when entering/leaving insert mode and when saving
  autocmd InsertEnter,InsertLeave,BufWritePost * if getcmdwintype() == '' | checktime | endif

  " Check when window gains focus or entering buffer
  autocmd FocusGained,BufEnter,WinEnter * if getcmdwintype() == '' | checktime | endif

  " Reduce the time before CursorHold triggers (in milliseconds)
  " Default is 4000 (4 seconds), setting to 1000 (1 second)
  set updatetime=1000
endif

" Notify when file has changed and has local modifications
autocmd FileChangedShell * {
  if v:fcs_choice == ''
    echo 'Warning: File changed on disk, you have unsaved changes!'
  endif
}
" }}}
" Autosave - here as reference, but disabled {{{
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
" }}}
" Autosession - save and restore session {{{
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
            # Close Splash buffer before saving session to avoid duplication
            for buf in getbufinfo()
                if buf.name =~ 'Splash' || bufname(buf.bufnr) =~ 'Splash'
                    execute 'bdelete! ' .. buf.bufnr
                endif
            endfor
            mksession!
        endif
    }
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
" Command-line completion improvements {{{
" Clear command line before navigating history or using completion
cnoremap <Up> <C-U><Up>
cnoremap <Down> <C-U><Down>
cnoremap <C-p> <C-U><C-p>
cnoremap <C-n> <C-U><C-n>

augroup cmdcomplete
    au!
    autocmd CmdlineChanged : call wildtrigger()
augroup END
" }}}
" Set .viminfo per project when a project is detected {{{
" a project is detected by the presence of any of
" .git, .pyproject.toml, setup.py, Cargo.toml, marmite.yaml
" use finfile to search upwards for each project file until root is reached
" let &viminfofile=findfile('.viminfo','.;') ?? $HOME . '/.vim/viminfo'
function! SetViminfoPerProject()
    " if there is a .viminfo in current directory just use that
    if filereadable('.viminfo')
        let &viminfofile = getcwd() . '/.viminfo'
        return
    endif
    " Then, look for project files to set project-specific .viminfo
    let l:project_files = ['.git/config', 'pyproject.toml', 'setup.py', 'Cargo.toml', 'marmite.yaml']
    for l:proj_file in l:project_files
        let l:proj_path = findfile(l:proj_file, '.;')
        if !empty(l:proj_path)
            let l:proj_dir = fnamemodify(l:proj_path, ':h')
            if l:proj_file == '.git/config'
                let l:proj_dir = fnamemodify(l:proj_dir, ':h')  " Go up one level from .git
            endif
            let &viminfofile = l:proj_dir . '/.viminfo'
            return
        endif
    endfor
    " If no project file found, use default viminfo location
    let &viminfofile = $HOME . '/.vim/viminfo'
endfunction
call SetViminfoPerProject()
" }}}
" vim: set foldmethod=marker foldlevel=0:
