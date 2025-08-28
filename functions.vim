
function! Alert(msg)
  augroup MyAlerts
    autocmd!
    execute 'autocmd VimEnter * echomsg "' . a:msg . '"'
  augroup END
endfunction

" --- Buffers-as-tabs tabline ---
function! BufferTabLine() abort
  let s = ''
  for i in range(1, bufnr('$'))
    if buflisted(i)
      let name = bufname(i)
      if empty(name)
        let name = '[No Name]'
      else
        let name = fnamemodify(name, ':t')
      endif
      " Add * indicator for modified buffers
      if getbufvar(i, '&modified')
        let name .= '*'
      endif
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

if !exists("*DeleteHiddenBuffers") " Clear all hidden buffers when running 
	function DeleteHiddenBuffers() " Vim with the 'hidden' option
		let tpbl=[]
		call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
		for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
			silent execute 'bwipeout' buf
		endfor
	endfunction
endif
command! DeleteHiddenBuffers call DeleteHiddenBuffers()


" --- Resize mode (arrows to resize splits, Esc to quit) ---

function! ResizeMode()
  echo "Resize mode: arrows resize, <Esc> quits"

  " Temporary buffer-local mappings
  nnoremap <buffer> <Up>    :resize +2<CR>
  nnoremap <buffer> <Down>  :resize -2<CR>
  nnoremap <buffer> <Left>  :vertical resize -2<CR>
  nnoremap <buffer> <Right> :vertical resize +2<CR>

  nnoremap <buffer> k    :resize +2<CR>
  nnoremap <buffer> j  :resize -2<CR>
  nnoremap <buffer> h  :vertical resize -2<CR>
  nnoremap <buffer> l :vertical resize +2<CR>
  
  nnoremap <buffer> <Esc> :call ResizeModeEnd()<CR>
endfunction

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

" ------------------------------------------------------------------------
" Vim Layouts (pure Vim version)  
" When opening up to 4 files those open on a grid 
" ------------------------------------------------------------------------
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
" ------------------------------------------------------------------------
let empty_args = expand("##")
if empty_args != ""
  let args = split(expand("##"), '\(\\\)\@<!\s')
  if len(args) < 5
    let counter = 0
    argdelete *
    argadd %
    for i in args 
      if counter % 4 == 0
        if counter == 0
          silent bnext
          silent bprev
        else
          silent exe "tabedit" i
        endif
      else
        if counter % 4 == 1
          silent exe "vsplit" i
        else
          if counter % 4 == 3
            silent exe "normal \<C-w>l"
          endif
          silent exe "split" i
        endif
      endif
      let counter += 1
    endfor
  endif
endif





