" =========================================================================
" Compatibility Functions for Vim and Neovim
" =========================================================================

" -------------------------------------------------------------------------
" Alert Function (works for both)
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
" Buffer Tab Line (works for both)
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
" Popup/Float Window Compatibility Layer
" -------------------------------------------------------------------------
if has('nvim')
    " Neovim implementation using floating windows
    function! CompatCreatePopup(content, opts) abort
        " Convert Vim popup options to Neovim float options
        let buf = nvim_create_buf(0, 1)
        
        " Set buffer content
        call nvim_buf_set_lines(buf, 0, -1, 1, a:content)
        
        " Configure float window options
        let float_opts = {}
        let float_opts.relative = 'cursor'
        let float_opts.row = get(a:opts, 'line', 1)
        let float_opts.col = get(a:opts, 'col', 0)
        let float_opts.width = get(a:opts, 'minwidth', max(map(copy(a:content), 'len(v:val)')))
        let float_opts.height = get(a:opts, 'minheight', len(a:content))
        let float_opts.style = 'minimal'
        let float_opts.border = get(a:opts, 'border', []) != [] ? 'single' : 'none'
        
        " Create the floating window
        let win = nvim_open_win(buf, 0, float_opts)
        
        " Set window options
        call nvim_win_set_option(win, 'winhl', 'Normal:Pmenu')
        call nvim_win_set_option(win, 'wrap', 0)
        
        " Store window ID for later reference
        return win
    endfunction
    
    function! CompatClosePopup(winid) abort
        if nvim_win_is_valid(a:winid)
            call nvim_win_close(a:winid, 1)
        endif
    endfunction
    
    function! CompatClosePopupFilter(winid, key) abort
        " Close popup on certain keys for Neovim
        if a:key == "\<Esc>" || a:key == 'q' || a:key == "\<CR>"
            call CompatClosePopup(a:winid)
            return 1
        endif
        return 0
    endfunction
else
    " Vim implementation using popup windows
    function! CompatCreatePopup(content, opts) abort
        return popup_create(a:content, a:opts)
    endfunction
    
    function! CompatClosePopup(winid) abort
        call popup_close(a:winid)
    endfunction
    
    function! CompatClosePopupFilter(winid, key) abort
        " Use Vim's built-in popup filter
        if a:key == "\<Esc>" || a:key == 'q' || a:key == "\<CR>"
            call popup_close(a:winid)
            return 1
        endif
        return 0
    endfunction
endif

" -------------------------------------------------------------------------
" Additional compatibility helpers
" -------------------------------------------------------------------------

" Check if we're running in Neovim
function! IsNeovim() abort
    return has('nvim')
endfunction

" Check if we're running in Vim
function! IsVim() abort
    return !has('nvim')
endfunction

" Get the appropriate config directory
function! GetConfigDir() abort
    if has('nvim')
        return expand('~/.config/nvim')
    else
        return expand('~/.vim')
    endif
endfunction

" vim: set foldmethod=marker foldlevel=0: