" =========================================================================
" Key Mappings and Shortcuts
" NOTE: use zr/zm to open/close all folds, za to toggle fold under cursor
" =========================================================================
" This file contains pure Vim key mappings
" Plugin-specific mappings are defined in plugins.vim
" =========================================================================
" Mappings using Nmap, Imap, Vmap, Xmap, Cmap will show up in :ShowDocs and
" :BufferDocs with descriptions and categories (if provided)
" regular nnoremap, inoremap, vnoremap, etc. will not show in the docs
" =========================================================================
" Debugging tips:
" :verbose map <key>  - See where a mapping was defined
" :map                - See all mappings
" :nmap, :vmap, :imap - See mode-specific mappings
" :map <leader>       - See all leader mappings
" <leader>h           - Open interactive mapping documentation menu
" :BufferDocs         - Open mapping documentation in a buffer
" =========================================================================
" -------------------------------------------------------------------------
" Tab Management {{{
" -------------------------------------------------------------------------
" Note: Tabs are rarely used in favor of buffers, but mappings provided
Nmap 'create new|Tabs' <leader>tn :tabnew<CR>
Nmap 'close all other|Tabs' <leader>to :tabonly<CR>
Nmap 'close current|Tabs' <leader>tc :tabclose<CR>
Nmap 'go to next|Tabs' <leader>tl :tabnext<CR>
Nmap 'go to previous|Tabs' <leader>th :tabprevious<CR>

" }}}
" -------------------------------------------------------------------------
" Buffer Management {{{
" -------------------------------------------------------------------------
Nmap 'list and jump to one|Buffers' <leader>bl :ls<CR>:b<Space>
Nmap 'previous|Buffers|2' [b :bp<CR>
Nmap 'next|Buffers|2' ]b :bn<CR>
Nmap 'previous|Buffers|2' [q :bp<CR>
Nmap 'next|Buffers|2' ]q :bn<CR>
Nmap 'close all hidden|Buffers' <leader>bh :DeleteHiddenBuffers<CR>
Nmap 'close all|Buffers|2' <leader>bd :bufdo bdelete<CR>

" NOTE: More buffer mappings on plugins.vim 

" Quick buffer switching with <leader>1 through 9
Nmap 'switch to 1-9|Buffers' <leader>1 :buffer 1<CR>
for n in range(2, 9)
  execute 'nnoremap <silent> <leader>' . n . ' :buffer ' . n . '<CR>'
endfor

" Quick switch to alternate buffer
Nmap 'alternate|Buffers|2' <leader><Tab> <C-^>

" }}}
" -------------------------------------------------------------------------
" Window Management (Splits) {{{
" -------------------------------------------------------------------------
Nmap 'increase height|Windows' <leader>= :resize +3<CR>
Nmap 'decrease height|Windows' <leader>- :resize -3<CR>
Nmap 'increase width|Windows' <leader>> :vertical resize +3<CR>
Nmap 'decrease width|Windows' <leader>< :vertical resize -3<CR>

" Interactive resize mode
Nmap 'resize mode|Windows' <leader>rs :call ResizeMode()<CR>
" }}}
" -------------------------------------------------------------------------
" Quick Save/Quit and Quality of Life {{{
" -------------------------------------------------------------------------
Nmap 'save|Files' <leader>w :write<CR>
Nmap 'quit|Files' <leader>q :quit<CR>
Nmap 'save and quit|Files' <leader>x :xit<CR>

" Enter after search will clear highlights
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" }}}
" -------------------------------------------------------------------------
" Terminal Mode {{{
" -------------------------------------------------------------------------
tnoremap <C-v><Esc> <C-\><C-n>
" C-v Esc - Exit terminal mode (keeping as tnoremap for now)
Nmap 'open at bottom|Terminal' <leader>c :botright term<CR>

" }}}
" -------------------------------------------------------------------------
" Search and Replace {{{
" -------------------------------------------------------------------------
" Replace current word throughout file
" Note: Visual Multi plugin provides similar functionality with Ctrl+d
Nmap 'replace word under cursor|Search' <leader>re :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
Vmap 'replace word under cursor in selection|Search' <leader>re :s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
Nmap 'replace word under cursor in line|Search' <leader>rl :s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>


" }}}
" -------------------------------------------------------------------------
" Configuration Reload {{{
" -------------------------------------------------------------------------
Nmap 'reload vimrc|Config' <leader><leader>so :source $MYVIMRC<CR>

" }}}
" -------------------------------------------------------------------------
" Common Editor Shortcuts {{{
" -------------------------------------------------------------------------
" Ctrl+S to save (familiar for users coming from other editors)
Nmap 'save|Files|2' <C-s> :update<CR>
Imap 'save|Files' <C-s> <Esc>:update<CR>a
Xmap 'save|Files' <C-s> <Esc>:update<CR>gv

" Ctrl+Z to undo (familiar for users coming from other editors)
Nmap 'Undo|Edit' <C-z> u
Imap 'Undo|Edit' <C-z> <Esc>ua
Xmap 'Undo|Edit' <C-z> <Esc>ugv


"Remove all trailing whitespace
Nmap 'remove / trim trailing whitespace|Edit' <leader>tw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" }}}
" -------------------------------------------------------------------------
" Emacs-style Cursor Movement {{{
" -------------------------------------------------------------------------
" Familiar keybindings for users coming from Emacs
" Insert mode mappings
" Imap 'Move to beginning of line|Emacs' <C-a> <Home>
" Imap 'Move to end of line|Emacs' <C-e> <End>
" Imap 'Move forward one character|Emacs' <C-f> <Right>
" Imap 'Move backward one character|Emacs' <C-b> <Left>
" Imap 'Delete character under cursor|Emacs' <C-d> <Del>
" Imap 'Kill to end of line|Emacs' <C-k> <C-o>D
" Imap 'Delete word backward|Emacs' <M-Backspace> <C-o>dB
" Command mode mappings
Cmap 'move to beginning|Emacs' <C-a> <Home>
Cmap 'move to end|Emacs' <C-e> <End>
Cmap 'move forward|Emacs' <C-f> <Right>
Cmap 'move backward|Emacs' <C-b> <Left>
Cmap 'delete character|Emacs' <C-d> <Del>
Cmap 'kill to beginning|Emacs' <C-k> <C-u>
Cmap 'delete word|Emacs' <M-Backspace> <C-w>

" -------------------------------------------------------------------------

" Line Movement
" -------------------------------------------------------------------------
" Move lines up and down while maintaining indentation
" Using Alt+j/k
Nmap 'move down|Lines' <M-j> :m .+1<CR>==
Nmap 'move up|Lines' <M-k> :m .-2<CR>==
Imap 'move down|Lines' <M-j> <Esc>:m .+1<CR>==gi
Imap 'move up|Lines' <M-k> <Esc>:m .-2<CR>==gi
Xmap 'move selection down|Lines' <M-j> :m '>+1<CR>gv=gv
Xmap 'move selection up|Lines' <M-k> :m '<-2<CR>gv=gv
" Using Alt+Arrow keys
Nmap 'move down|Lines' <M-Down> :m .+1<CR>==
Nmap 'move up|Lines' <M-Up> :m .-2<CR>==
Imap 'move down|Lines' <M-Down> <Esc>:m .+1<CR>==gi
Imap 'move up|Lines' <M-Up> <Esc>:m .-2<CR>==gi
Xmap 'move selection down|Lines' <M-Down> :m '>+1<CR>gv=gv
Xmap 'move selection up|Lines' <M-Up> :m '<-2<CR>gv=gv

" }}}
" -------------------------------------------------------------------------
" Visual Mode Enhancements {{{
" -------------------------------------------------------------------------
" Stay in visual mode after indenting 
Xmap 'indent left and stay in visual mode|Edit' < <gv
Xmap 'indent right and stay in visual mode|Edit' > >gv

" Paste without overwriting register (keeps yanked text)
Xmap 'paste without yanking replaced text|Edit' p "_dP
Vmap 'paste without yanking replaced text|Edit' p "_dP

" }}}
" -------------------------------------------------------------------------
" Disable Problematic Keys {{{
" -------------------------------------------------------------------------
nnoremap Q <Nop>

" }}}
" -------------------------------------------------------------------------
" Navigation Improvements {{{
" -------------------------------------------------------------------------
" Better navigation for wrapped lines (uncomment if desired)
nnoremap j gj
" j - Move by display line, not physical line
nnoremap k gk
" k - Move by display line, not physical line
nnoremap gj j
" gj - Move by physical line
nnoremap gk k
" gk - Move by physical line

"Hitting esc twice will close quickfix/location list if open
Nmap 'close quick action and clear highlight|Windows|3' <Esc><Esc> :cclose<CR>:lclose<CR>:nohlsearch<CR>

" }}}
" -------------------------------------------------------------------------
" File Operations {{{
" -------------------------------------------------------------------------
" Make current file executable (useful for scripts)
Nmap 'make executable|Files' <leader><leader>x :!chmod +x %<CR>

" }}}
" -------------------------------------------------------------------------
" MapDocs System {{{
" -------------------------------------------------------------------------
" Access the mapping documentation and interactive menu
Nmap 'open mapping documentation on a buffer|Help' <leader>h :BufferDocs<CR>
nnoremap <silent> <leader> :ShowDocs<CR>



" ---------------------------------------------------------------
"  Docs Only For The MapDocs System (do not remove these lines)
" ---------------------------------------------------------------
Imap 'indent|Edit' <C-T>
Imap 'outdent|Edit' <C-D>
Imap 'repeat last Insert|Edit' <C-A>
Imap 'delete word backward|Edit' <C-W>
Imap 'delete to last insert in the current line|Edit' <C-U>
Imap 'next Completion|Edit' <C-N>
Imap 'previous Completion|Edit' <C-P>
Imap 'cancel completion|Edit' <C-E>
Imap 'insert char above cursor|Edit' <C-Y>
Imap 'insert char below cursor|Edit' <C-E>

Nmap 'redraw screen|View' <C-L>
Nmap 'go to first line of file|Navigation' gg
Nmap 'go to last line of file|Navigation' G
Nmap 'go to end of line|Navigation' $
Nmap 'go to beginning of line|Navigation' 0
Nmap 'go to first non-blank character of line|Navigation' ^
Nmap 'go to matching bracket|Navigation' %

Nmap 'indent N lines|Edit' N>>
Nmap 'outdent N lines|Edit' N<<
Nmap 'restore Indentation N Lines|Edit' N==
Nmap 'go to line N|Navigation' Ngg
Nmap 'cursor to the middle of the screen|Navigation' M
Nmap 'cursor to the top of the screen|Navigation' H
Nmap 'cursor to the bottom of the screen|Navigation' L
Nmap 'go to file under cursor|Navigation' gf

Nmap 'new line above current line|Edit' O
Nmap 'new line below current line|Edit' o
Nmap 'insert before cursor|Edit' I
Nmap 'insert at end of line|Edit' A
Nmap 'append after cursor|Edit' a
Nmap 'delete N lines and start insert|Edit' Ncc

Nmap 'move focus left|Windows' <C-w>h
Nmap 'move focus down|Windows' <C-w>j
Nmap 'move focus up|Windows' <C-w>k
Nmap 'move focus right|Windows' <C-w>l
Nmap 'split horizontally|Windows|3' <C-w>s
Nmap 'split vertically|Windows|3' <C-w>v
Nmap 'close current|Windows|3' <C-w>c
Nmap 'quit current|Windows' <C-w>q
Nmap 'equalize sizes|Windows' <C-w>=
Nmap 'go to previous|Windows' <C-w>p
Nmap 'go to Nth|Windows' <C-w>N
Nmap 'go to last|Windows' <C-w>W
Nmap 'rotate up|Windows' <C-w>R
Nmap 'rotate down|Windows|3' <C-w>r
Nmap 'move current to new tab|Windows' <C-w>T
Nmap 'close all other|Windows|3' <C-w>o
Nmap 'move current to left|Windows' <C-w>H
Nmap 'move current to bottom|Windows' <C-w>J
Nmap 'move current to top|Windows' <C-w>K
Nmap 'move current to right|Windows' <C-w>L
Nmap 'split and jump to symbol|Windows' <C-w>]
Nmap 'split and go to file under cursor|Windows' <C-w>f
Nmap 'go to another|Windows|3' <C-w>ARROWS
Nmap 'exchanges|Windows' <C-w>x

" -------------------------------------------------------------------------
" End of Mappings
" -------------------------------------------------------------------------


" vim: set foldmethod=marker foldlevel=0:
