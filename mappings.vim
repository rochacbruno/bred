" =========================================================================
" Key Mappings and Shortcuts
" use zr/zm to open/close all folds, za to toggle fold under cursor
" =========================================================================
" This file contains pure Vim key mappings
" Plugin-specific mappings are defined in plugins.vim
"
" Debugging tips:
" :verbose map <key>  - See where a mapping was defined
" :map                - See all mappings
" :nmap, :vmap, :imap - See mode-specific mappings
" :map <leader>       - See all leader mappings
" =========================================================================
" -------------------------------------------------------------------------
" Tab Management
" -------------------------------------------------------------------------
" Note: Tabs are rarely used in favor of buffers, but mappings provided {{{
Nmap 'Create new tab|Tabs' <leader>tn :tabnew<CR>
Nmap 'Close all other tabs|Tabs' <leader>to :tabonly<CR>
Nmap 'Close current tab|Tabs' <leader>tc :tabclose<CR>
Nmap 'Go to next tab|Tabs' <leader>tl :tabnext<CR>
Nmap 'Go to previous tab|Tabs' <leader>th :tabprevious<CR>
" }}}
" -------------------------------------------------------------------------
" Buffer Management
" -------------------------------------------------------------------------
" {{{
Nmap 'List buffers and jump to one|Buffers' <leader>bl :ls<CR>:b<Space>
Nmap 'Previous buffer|Buffers' [q :bp<CR>
Nmap 'Next buffer|Buffers' ]q :bn<CR>
Nmap 'Delete all hidden buffers|Buffers' bh :DeleteHiddenBuffers<CR>

" Quick buffer switching with ,1 through ,9
for n in range(1, 9)
  execute 'Nmap ''Switch to buffer ' . n . '|Buffers'' <leader>' . n . ' :buffer ' . n . '<CR>'
endfor

" Quick switch to alternate buffer
Nmap 'Toggle between two buffers|Buffers' <leader><Tab> <C-^>

" }}}
" -------------------------------------------------------------------------
" Window Management (Splits)
" -------------------------------------------------------------------------
" Window resizing {{{
Nmap 'Increase window height|Windows' <leader>= :resize +3<CR>
Nmap 'Decrease window height|Windows' <leader>- :resize -3<CR>
Nmap 'Increase window width|Windows' <leader>> :vertical resize +3<CR>
Nmap 'Decrease window width|Windows' <leader>< :vertical resize -3<CR>
" Built-in window shortcuts:
" C-w-f - Open file under cursor in new split
" C-w-v - Split window vertically
" C-w-s - Split window horizontally

" Interactive resize mode
Nmap 'Enter resize mode (arrows to resize)|Windows' <leader>rs :call ResizeMode()<CR>
" }}}
"
" -------------------------------------------------------------------------
" Quick Save/Quit and Quality of Life
" -------------------------------------------------------------------------
" {{{
Nmap 'Save file|File' <leader>w :write<CR>
Nmap 'Quit|File' <leader>q :quit<CR>
Nmap 'Save and quit|File' <leader>x :xit<CR>
Nmap 'Clear search highlighting|Search' <leader>h :nohlsearch<CR>
" }}}
"
" -------------------------------------------------------------------------
" Terminal Mode
" -------------------------------------------------------------------------
" {{{
tnoremap <C-v><Esc> <C-\><C-n>
" C-v Esc - Exit terminal mode (keeping as tnoremap for now)
Nmap 'Open terminal at bottom|Terminal' <leader>c :botright term<CR>
" }}}
" -------------------------------------------------------------------------
" Search and Replace
" -------------------------------------------------------------------------
" Replace current word throughout file {{{
" Note: Visual Multi plugin provides similar functionality with Ctrl+d
Nmap 'Replace word under cursor|Search' <leader>re :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
" }}}
"
" -------------------------------------------------------------------------
" Configuration Reload
" -------------------------------------------------------------------------
Nmap 'Reload vimrc|Config' <leader><leader>so :source $MYVIMRC<CR>

" -------------------------------------------------------------------------
" Common Editor Shortcuts
" -------------------------------------------------------------------------
" Ctrl+S to save (familiar for users coming from other editors) {{{
Nmap 'Save file|File' <C-s> :update<CR>
Imap 'Save file|File' <C-s> <Esc>:update<CR>a
Xmap 'Save file|File' <C-s> <Esc>:update<CR>gv

" Ctrl+Z to undo (familiar for users coming from other editors)
Nmap 'Undo|Edit' <C-z> u
Imap 'Undo|Edit' <C-z> <Esc>ua
Xmap 'Undo|Edit' <C-z> <Esc>ugv


"Remove all trailing whitespace
Nmap 'Remove trailing whitespace|Edit' <leader>tw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" }}}
"
" -------------------------------------------------------------------------
" Emacs-style Cursor Movement
" -------------------------------------------------------------------------
" Familiar keybindings for users coming from Emacs {{{
" Insert mode mappings
Imap 'Move to beginning of line|Emacs' <C-a> <Home>
Imap 'Move to end of line|Emacs' <C-e> <End>
Imap 'Move forward one character|Emacs' <C-f> <Right>
Imap 'Move backward one character|Emacs' <C-b> <Left>
Imap 'Delete character under cursor|Emacs' <C-d> <Del>
Imap 'Kill to end of line|Emacs' <C-k> <C-o>D
Imap 'Delete word backward|Emacs' <M-Backspace> <C-o>dB
" Command mode mappings
Cmap 'Move to beginning|Emacs' <C-a> <Home>
Cmap 'Move to end|Emacs' <C-e> <End>
Cmap 'Move forward|Emacs' <C-f> <Right>
Cmap 'Move backward|Emacs' <C-b> <Left>
Cmap 'Delete character|Emacs' <C-d> <Del>
Cmap 'Kill to beginning|Emacs' <C-k> <C-u>
Cmap 'Delete word|Emacs' <M-Backspace> <C-w>

" -------------------------------------------------------------------------

" Line Movement
" -------------------------------------------------------------------------
" Move lines up and down while maintaining indentation
" Using Alt+j/k
Nmap 'Move line down|Lines' <M-j> :m .+1<CR>==
Nmap 'Move line up|Lines' <M-k> :m .-2<CR>==
Imap 'Move line down|Lines' <M-j> <Esc>:m .+1<CR>==gi
Imap 'Move line up|Lines' <M-k> <Esc>:m .-2<CR>==gi
Xmap 'Move selection down|Lines' <M-j> :m '>+1<CR>gv=gv
Xmap 'Move selection up|Lines' <M-k> :m '<-2<CR>gv=gv
" Using Alt+Arrow keys
Nmap 'Move line down|Lines' <M-Down> :m .+1<CR>==
Nmap 'Move line up|Lines' <M-Up> :m .-2<CR>==
Imap 'Move line down|Lines' <M-Down> <Esc>:m .+1<CR>==gi
Imap 'Move line up|Lines' <M-Up> <Esc>:m .-2<CR>==gi
Xmap 'Move selection down|Lines' <M-Down> :m '>+1<CR>gv=gv
Xmap 'Move selection up|Lines' <M-Up> :m '<-2<CR>gv=gv

" }}}

" -------------------------------------------------------------------------
" Visual Mode Enhancements
" -------------------------------------------------------------------------
" Stay in visual mode after indenting {{{
Xmap 'Indent left and stay in visual mode|Edit' < <gv
Xmap 'Indent right and stay in visual mode|Edit' > >gv

" Paste without overwriting register (keeps yanked text)
Xmap 'Paste without yanking replaced text|Edit' p "_dP
Vmap 'Paste without yanking replaced text|Edit' p "_dP
" }}}

" -------------------------------------------------------------------------
" Disable Problematic Keys
" -------------------------------------------------------------------------
Nmap 'Disable Ex mode|' Q <Nop>

" -------------------------------------------------------------------------
" Navigation Improvements
" -------------------------------------------------------------------------
" Better navigation for wrapped lines (uncomment if desired)
" nnoremap j gj
" j - Move by display line, not physical line
" nnoremap k gk
" k - Move by display line, not physical line
" nnoremap gj j
" gj - Move by physical line
" nnoremap gk k
" gk - Move by physical line

" -------------------------------------------------------------------------
" File Operations
" -------------------------------------------------------------------------
" Make current file executable (useful for scripts)
Nmap 'Make file executable|File' <leader><leader>x :!chmod +x %<CR>

" -------------------------------------------------------------------------
" MapDocs System
" -------------------------------------------------------------------------
" Access the mapping documentation and interactive menu
Nmap 'Open mapping documentation menu|Help' <leader><leader>m :ShowDocs<CR>

" -------------------------------------------------------------------------
" End of Mappings
" -------------------------------------------------------------------------
" vim: set foldmethod=marker foldlevel=0:
