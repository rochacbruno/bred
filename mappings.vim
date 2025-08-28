
" ---- PURE VIM MAPPINGS
"  for plugin mappings check plugins.vim
"  use :verbose map <key> to see where a mapping was defined
"  or use :Maps to see all mappings
"  or :nmap, :vmap, :imap, :tmap for specific modes
"  or :map <leader> to see all leader mappings
" -----------------------------
" --- Tabs ---
" Tabs are useless, but here are some mappings anyway
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>tl :tabnext<CR>
nnoremap <leader>th :tabprevious<CR>

" --- Buffers ---
nnoremap <leader>bl :ls<CR>:b<Space> " list buffers and prompt for buffer number
nnoremap [q :bp<CR> " previous buffer
nnoremap ]q :bn<CR> " next buffer
nnoremap bda :DeleteHiddenBuffers<CR> " delete all hidden buffers

for n in range(1, 9)
  execute 'nnoremap <silent> <leader>' . n . ' :buffer ' . n . '<CR>'
endfor

"Map buffer quick switch keys"
nnoremap <silent> <leader><Tab> <C-^>

" --- Window management (splits) ---
nnoremap <leader>= :resize +3<CR>
nnoremap <leader>- :resize -3<CR>
nnoremap <leader>> :vertical resize +3<CR>
nnoremap <leader>< :vertical resize -3<CR>
" C-w-f = open current file in new split
" C-w-v = split file vertically
" C-w-s = split file horizontally

" Shortcut to start resize mode
nnoremap <leader>rs :call ResizeMode()<CR>

" --- Quick save/quit & QoL ---
nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>x :xit<CR>
nnoremap <leader>h :nohlsearch<CR>


" ------ Term mode ------
tnoremap <C-v><Esc> <C-\><C-n>
nnoremap <leader>c :botright term<CR>

" -- replace current word --
"NOTE: this is also a VM mode feature but I like having it in pure vim too
" on VM: ctrl+d to select word then \\A to select all instances then c to
" change
nnoremap <leader>re :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" -- Reload vim config --
nnoremap <leader><leader>so :source ~/.vim/vimrc<CR>


" Make Ctrl+s save the file in normal and insert mode
nnoremap <C-s> :update<CR>
inoremap <C-s> <Esc>:update<CR>a
xnoremap <C-s> <Esc>:update<CR>gv

" Make Ctrl+z undo in normal and insert mode
nnoremap <C-z> u
inoremap <C-z> <Esc>ua
xnoremap <C-z> <Esc>ugv


" Emacs style cursor movement in insert mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-k> <C-o>D
inoremap <M-Backspace> <C-o>dB
" Emacs style in command mode too
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-k> <C-u>
cnoremap <M-Backspace> <C-w>

" Move lines up and down in normal and visual mode
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
xnoremap <M-j> :m '>+1<CR>gv=gv
xnoremap <M-k> :m '<-2<CR>gv=gv
" Also using arrows
nnoremap <M-Down> :m .+1<CR>==
nnoremap <M-Up> :m .-2<CR>==
inoremap <M-Down> <Esc>:m .+1<CR>==gi
inoremap <M-Up> <Esc>:m .-2<CR>==gi
xnoremap <M-Down> :m '>+1<CR>gv=gv
xnoremap <M-Up> :m '<-2<CR>gv=gv

" Stay in indent mode when indenting in visual mode
xnoremap < <gv
xnoremap > >gv


" Sane paste without overwriting the default register
xnoremap p "_dP
vnoremap p "_dP

" Disable annoying Q command
nnoremap Q <Nop>

" Better navigation for wrapped lines
" nnoremap j gj
" nnoremap k gk
" nnoremap gj j
" nnoremap gk k

" Make a script executable from vim
nnoremap <leader>x :!chmod +x %<CR>

"
"
"
