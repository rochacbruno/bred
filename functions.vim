" =========================================================================
" Custom Functions
" =========================================================================

" -------------------------------------------------------------------------
" Alert Function
" -------------------------------------------------------------------------
" Displays a message using autocommand on VimEnter event
" Used by LSP for displaying notifications
" Args: msg - The message to display
function! Alert(msg)
  augroup MyAlerts
    autocmd!
    execute 'autocmd VimEnter * echomsg "' . a:msg . '"'
  augroup END
endfunction

" -------------------------------------------------------------------------
" Buffer Tab Line
" -------------------------------------------------------------------------
" Creates a custom tab line that displays all listed buffers as tabs
" Shows buffer number, name, and modification status (*)
" Returns: String formatted for use with tabline
function! BufferTabLine() abort
  let s = ''
  " Iterate through all buffers
  for i in range(1, bufnr('$'))
    if buflisted(i)
      let name = bufname(i)
      if empty(name)
        let name = '[No Name]'
      else
        let name = fnamemodify(name, ':t') " Get just the filename
      endif
      " Add * indicator for modified buffers
      if getbufvar(i, '&modified')
        let name .= '*'
      endif
      " Highlight current buffer differently
      if i == bufnr('%')
        let s .= '%#TabLineSel#'
      else
        let s .= '%#TabLine#'
      endif
      let s .= ' ' . i . ': ' . name . ' '
    endif
  endfor
  let s .= '%#TabLineFill#'
  return s
endfunction

" -------------------------------------------------------------------------
" Delete Hidden Buffers
" -------------------------------------------------------------------------
" Clears all hidden buffers when running Vim with the 'hidden' option
" Keeps only buffers that are visible in tabs, closes all others
if !exists("*DeleteHiddenBuffers") " Clear all hidden buffers when running
	function DeleteHiddenBuffers() " Vim with the 'hidden' option
		let tpbl=[] " List to store buffers visible in tabs
		" Collect all buffers that are visible in any tab
		call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
		" Find and delete buffers that exist but are not visible in any tab
		for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
			silent execute 'bwipeout' buf
		endfor
	endfunction
endif
command! DeleteHiddenBuffers call DeleteHiddenBuffers()


" -------------------------------------------------------------------------
" Resize Mode
" -------------------------------------------------------------------------
" Interactive mode for resizing window splits using arrow keys or hjkl
" Press Esc to exit resize mode
function! ResizeMode()
  echo "Resize mode: arrows resize, <Esc> quits"

  " Temporary buffer-local mappings for arrow keys
  nnoremap <buffer> <Up>    :resize +2<CR>
  nnoremap <buffer> <Down>  :resize -2<CR>
  nnoremap <buffer> <Left>  :vertical resize -2<CR>
  nnoremap <buffer> <Right> :vertical resize +2<CR>

  " Temporary buffer-local mappings for hjkl keys
  nnoremap <buffer> k    :resize +2<CR>
  nnoremap <buffer> j  :resize -2<CR>
  nnoremap <buffer> h  :vertical resize -2<CR>
  nnoremap <buffer> l :vertical resize +2<CR>

  nnoremap <buffer> <Esc> :call ResizeModeEnd()<CR>
endfunction

" -------------------------------------------------------------------------
" Resize Mode End
" -------------------------------------------------------------------------
" Exits resize mode by unmapping temporary keybindings
function! ResizeModeEnd()
  " Unmap the temporary keys
  silent! nunmap <buffer> <Up>
  silent! nunmap <buffer> <Down>
  silent! nunmap <buffer> <Left>
  silent! nunmap <buffer> <Right>
  silent! nunmap <buffer> k
  silent! nunmap <buffer> j
  silent! nunmap <buffer> h
  silent! nunmap <buffer> l

  silent! nunmap <buffer> <Esc>
  echo "Exited resize mode"
endfunction

" -------------------------------------------------------------------------
" Vim Layouts (Automatic Grid Layout)
" -------------------------------------------------------------------------
" Automatically arranges up to 4 files in an optimal grid layout
" When opening multiple files, they are arranged as follows:
" " Usage: vim file1 file2 file3 file4
"        vim file1 file2 file3
"        vim file1 file2
"        vim file1
"        vim
"
" If more than 4 files are opened, the layout is not changed.
" If no files are opened, the current buffer is kept.
"
" The layout is:
" 2 files: vertical split
" 3 files: top-left, top-right, bottom (full width)
" 4 files: grid (2x2)
"
" The current buffer is always kept and placed in the first position.
" -------------------------------------------------------------------------
" Layout Logic Implementation
" -------------------------------------------------------------------------
" Process command line arguments and create the appropriate layout
" This needs to run after Vim has fully initialized to avoid conflicts
function! AutoLayoutFiles()
  let empty_args = expand("##") " Get all command line arguments
  if empty_args != ""
    let args = split(expand("##"), '\(\\\)\@<!\s') " Split arguments on unescaped spaces
    if len(args) < 5 " Only apply layout for 4 or fewer files
      let counter = 0
      argdelete * " Clear existing argument list
      argadd % " Add current buffer to argument list
      " Process each file and arrange in grid layout
      for i in args
        if counter % 4 == 0 " First file in each group of 4
          if counter == 0 " Very first file - just navigate to it
            silent bnext
            silent bprev
            silent exe "filetype detect"
          else " Start a new tab for files 5, 9, etc.
            silent exe "tabedit" i
            silent exe "filetype detect"
          endif
        else
          if counter % 4 == 1 " Second file - create vertical split
            silent exe "vsplit" i
            silent exe "filetype detect"
          else
            if counter % 4 == 3 " Fourth file - move to right pane first
              silent exe "normal \<C-w>l"
            endif
            silent exe "split" i 
            silent exe "filetype detect"
            " Third and fourth files - create horizontal split
          endif
        endif
        let counter += 1
      endfor
    endif
  endif
endfunction

" Run the auto-layout only once after Vim has fully started
" This prevents interference with ftplugins and other initialization
augroup AutoLayoutOnStart
  autocmd!
  autocmd VimEnter * ++once call AutoLayoutFiles()
augroup END

" -------------------------------------------------------------------------
" Force Quit All With Confirmation
" -------------------------------------------------------------------------
" Asks for confirmation before force quitting all buffers without saving
function! ForceQuitAll()
    " Check if there are any modified buffers
    let l:modified_count = 0
    for l:buf in getbufinfo({'bufloaded': 1})
        if l:buf.changed
            let l:modified_count += 1
        endif
    endfor
    
    " Build confirmation message
    if l:modified_count > 0
        echo "FORCE QUIT: You have " . l:modified_count . " unsaved buffer(s). Quit anyway? (y/N): "
    else
        echo "Quit Vim? (y/N): "
    endif
    
    " Get user confirmation
    let l:confirm = nr2char(getchar())
    
    if l:confirm ==? 'y'
        qa!
    else
        echo "Cancelled"
    endif
endfunction
