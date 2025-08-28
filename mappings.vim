" =========================================================================
" Key Mappings and Shortcuts
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
" Note: Tabs are rarely used in favor of buffers, but mappings provided
nnoremap <leader>tn :tabnew<CR>      " ,tn - Create new tab
nnoremap <leader>to :tabonly<CR>     " ,to - Close all other tabs
nnoremap <leader>tc :tabclose<CR>    " ,tc - Close current tab
nnoremap <leader>tl :tabnext<CR>     " ,tl - Go to next tab
nnoremap <leader>th :tabprevious<CR> " ,th - Go to previous tab

" -------------------------------------------------------------------------
" Buffer Management
" -------------------------------------------------------------------------
nnoremap <leader>bl :ls<CR>:b<Space>  " ,bl - List buffers and jump to one
nnoremap [q :bp<CR>                   " [q  - Previous buffer
nnoremap ]q :bn<CR>                   " ]q  - Next buffer
nnoremap bda :DeleteHiddenBuffers<CR> " bda - Delete all hidden buffers

" Quick buffer switching with ,1 through ,9
for n in range(1, 9)
  execute 'nnoremap <silent> <leader>' . n . ' :buffer ' . n . '<CR>'
endfor

" Quick switch to alternate buffer
nnoremap <silent> <leader><Tab> <C-^>  " ,<Tab> - Toggle between two buffers

" -------------------------------------------------------------------------
" Window Management (Splits)
" -------------------------------------------------------------------------
" Window resizing
nnoremap <leader>= :resize +3<CR>          " ,=  - Increase height
nnoremap <leader>- :resize -3<CR>          " ,-  - Decrease height
nnoremap <leader>> :vertical resize +3<CR> " ,>  - Increase width
nnoremap <leader>< :vertical resize -3<CR> " ,<  - Decrease width
" Built-in window shortcuts:
" C-w-f - Open file under cursor in new split
" C-w-v - Split window vertically
" C-w-s - Split window horizontally

" Interactive resize mode
nnoremap <leader>rs :call ResizeMode()<CR>  " ,rs - Enter resize mode (arrows to resize)

" -------------------------------------------------------------------------
" Quick Save/Quit and Quality of Life
" -------------------------------------------------------------------------
nnoremap <leader>w :write<CR>       " ,w - Save file
nnoremap <leader>q :quit<CR>        " ,q - Quit
nnoremap <leader>x :xit<CR>         " ,x - Save and quit
nnoremap <leader>h :nohlsearch<CR>  " ,h - Clear search highlighting

" -------------------------------------------------------------------------
" Terminal Mode
" -------------------------------------------------------------------------
tnoremap <C-v><Esc> <C-\><C-n>      " C-v Esc - Exit terminal mode
nnoremap <leader>c :botright term<CR> " ,c      - Open terminal at bottom

" -------------------------------------------------------------------------
" Search and Replace
" -------------------------------------------------------------------------
" Replace current word throughout file
" Note: Visual Multi plugin provides similar functionality with Ctrl+d
nnoremap <leader>re :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>  " ,re - Replace word under cursor

" -------------------------------------------------------------------------
" Configuration Reload
" -------------------------------------------------------------------------
nnoremap <leader><leader>so :source ~/.vim/vimrc<CR>  " ,,so - Reload Vim configuration

" -------------------------------------------------------------------------
" Common Editor Shortcuts
" -------------------------------------------------------------------------
" Ctrl+S to save (familiar for users coming from other editors)
nnoremap <C-s> :update<CR>          " Ctrl+S - Save in normal mode
inoremap <C-s> <Esc>:update<CR>a    " Ctrl+S - Save in insert mode
xnoremap <C-s> <Esc>:update<CR>gv   " Ctrl+S - Save in visual mode

" Ctrl+Z to undo (familiar for users coming from other editors)
nnoremap <C-z> u                    " Ctrl+Z - Undo in normal mode
inoremap <C-z> <Esc>ua              " Ctrl+Z - Undo in insert mode
xnoremap <C-z> <Esc>ugv             " Ctrl+Z - Undo in visual mode

" -------------------------------------------------------------------------
" Emacs-style Cursor Movement
" -------------------------------------------------------------------------
" Familiar keybindings for users coming from Emacs
" Insert mode mappings
inoremap <C-a> <Home>               " C-a - Move to beginning of line
inoremap <C-e> <End>                " C-e - Move to end of line
inoremap <C-f> <Right>              " C-f - Move forward one character
inoremap <C-b> <Left>               " C-b - Move backward one character
inoremap <C-d> <Del>                " C-d - Delete character under cursor
inoremap <C-k> <C-o>D               " C-k - Kill to end of line
inoremap <M-Backspace> <C-o>dB     " M-Backspace - Delete word backward
" Command mode mappings
cnoremap <C-a> <Home>               " C-a - Move to beginning
cnoremap <C-e> <End>                " C-e - Move to end
cnoremap <C-f> <Right>              " C-f - Move forward
cnoremap <C-b> <Left>               " C-b - Move backward
cnoremap <C-d> <Del>                " C-d - Delete character
cnoremap <C-k> <C-u>                " C-k - Kill to beginning
cnoremap <M-Backspace> <C-w>        " M-Backspace - Delete word

" -------------------------------------------------------------------------
" Line Movement
" -------------------------------------------------------------------------
" Move lines up and down while maintaining indentation
" Using Alt+j/k
nnoremap <M-j> :m .+1<CR>==         " Alt+j - Move line down (normal)
nnoremap <M-k> :m .-2<CR>==         " Alt+k - Move line up (normal)
inoremap <M-j> <Esc>:m .+1<CR>==gi  " Alt+j - Move line down (insert)
inoremap <M-k> <Esc>:m .-2<CR>==gi  " Alt+k - Move line up (insert)
xnoremap <M-j> :m '>+1<CR>gv=gv     " Alt+j - Move selection down (visual)
xnoremap <M-k> :m '<-2<CR>gv=gv     " Alt+k - Move selection up (visual)
" Using Alt+Arrow keys
nnoremap <M-Down> :m .+1<CR>==      " Alt+Down - Move line down (normal)
nnoremap <M-Up> :m .-2<CR>==        " Alt+Up - Move line up (normal)
inoremap <M-Down> <Esc>:m .+1<CR>==gi  " Alt+Down - Move line down (insert)
inoremap <M-Up> <Esc>:m .-2<CR>==gi    " Alt+Up - Move line up (insert)
xnoremap <M-Down> :m '>+1<CR>gv=gv     " Alt+Down - Move selection down (visual)
xnoremap <M-Up> :m '<-2<CR>gv=gv       " Alt+Up - Move selection up (visual)

" -------------------------------------------------------------------------
" Visual Mode Enhancements
" -------------------------------------------------------------------------
" Stay in visual mode after indenting
xnoremap < <gv                      " < - Indent left and stay in visual mode
xnoremap > >gv                      " > - Indent right and stay in visual mode

" Paste without overwriting register (keeps yanked text)
xnoremap p "_dP                     " p - Paste in visual mode without yanking
vnoremap p "_dP                     " p - Paste in visual mode without yanking

" -------------------------------------------------------------------------
" Disable Problematic Keys
" -------------------------------------------------------------------------
nnoremap Q <Nop>                    " Q - Disable Ex mode (often hit by accident)

" -------------------------------------------------------------------------
" Navigation Improvements
" -------------------------------------------------------------------------
" Better navigation for wrapped lines (uncomment if desired)
" nnoremap j gj      " j - Move by display line, not physical line
" nnoremap k gk      " k - Move by display line, not physical line
" nnoremap gj j      " gj - Move by physical line
" nnoremap gk k      " gk - Move by physical line

" -------------------------------------------------------------------------
" File Operations
" -------------------------------------------------------------------------
" Make current file executable (useful for scripts)
nnoremap <leader>x :!chmod +x %<CR> " ,x - Make file executable

" -------------------------------------------------------------------------
" End of Mappings
" -------------------------------------------------------------------------
