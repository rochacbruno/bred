" --- Built-in Plugins

" -------------- File explorer (netrw) --------------------
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_keepdir = 0
runtime! plugin/netrwPlugin.vim
nnoremap <leader>e :Lexplore<CR>
nnoremap <leader>E :Vexplore<CR>
" ---------------------------------------------------------

" ----------------- LSP --------------------
"  Ensure you have installed the LSP servers you want to use
"  https://github.com/yegappan/lsp
if empty(glob('~/.vim/pack/downloads/opt/lsp'))
    echo "Installing LSP plugin..."
    silent !mkdir -p $HOME/.vim/pack/downloads/opt
    silent !cd $HOME/.vim/pack/downloads/opt && git clone https://github.com/yegappan/lsp
    silent !vim -u NONE -c "helptags $HOME/.vim/pack/downloads/opt/lsp/doc" -c q
    echo "LSP plugin installed successfully"
endif
packadd lsp
source ~/.vim/lsp.vim

nnoremap <leader>a :LspCodeAction<CR>
nnoremap <leader>d :LspGotoDefinition<CR>
nnoremap <leader>k :LspHover<CR>
" -----------------------------------------

"----------------- PLUGINS MANAGED BY VIM-PLUG --------------------
" Ensure vim-plug is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()


" ----------------- VIM SENSIBLE --------------------
" Basic default settings for a better experience
"
Plug 'tpope/vim-sensible'
" ---------------------------------------------------------

" ----------------- Better % matching --------------------
" % to jump between matching pairs of (), {}, [], <>
" Also works in visual mode
" Also works with HTML tags
" Also works with custom defined pairs, see :help matchit-custom
"
Plug 'chrisbra/matchit'
" ---------------------------------------------------------

" ----------------- File searching and navigation --------------------
" fzf (requires FZF installed)
" check if fzf is installed
if executable('fzf')
  Plug 'junegunn/fzf.vim'
  nnoremap <silent> <leader>l :Lines<CR>
  nnoremap <silent> <leader>f :Files<CR>
  nnoremap <silent> <leader>F :Rg<CR>
  nnoremap <silent> <leader>b :Buffers<CR>
  nnoremap <silent> <leader>g :GFiles<CR>
else
  echo "fzf is not installed, please install it to use fzf.vim"
endif


" ---------------------------------------------------------

" ----------------- Autocompletion --------------------
" Requires: npm, nodejs, yarn
" Linters and formatters
Plug 'dense-analysis/ale'
" Disable ALE's LSP in favour of standalone LSP plugin"
"let g:ale_disable_lsp = 1
" Show linting errors with highlights" 
"* Can also be viewed in the loclist with :lope"
"let g:ale_set_signs = 1
"let g:ale_set_highlights = 1
"let g:ale_virtualtext_cursor = 1
"highlight ALEError ctermbg=none cterm=underline
" Define when to lint"
"let g:ale_lint_on_save = 1
"let g:ale_lint_on_insert_leave = 1
"let g:ale_lint_on_text_change = 'never'
" Set linters for individual filetypes"
"let g:ale_linters_explicit = 1
"let g:ale_linters = {
"    \ 'python': ['ruff', 'mypy', 'pylsp'],
"    \ 'rust': ['analyzer', 'cargo'],
"    \ 'sh': ['shellcheck'],
"\ }
" Specify fixers for individual filetypes"
"let g:ale_fixers = {
"    \ '*': ['trim_whitespace'],
"    \ 'python': ['ruff'],
"    \ 'rust': ['rustfmt'],
"\ }
"Rust specific settings
"let g:ale_rust_cargo_use_clippy = 1
"let g:ale_rust_cargo_check_tests = 1 
"let g:ale_rust_cargo_check_examples = 1
" Don't warn about trailing whitespace, as it is auto-fixed by '*' above"
"let g:ale_warn_about_trailing_whitespace = 0
" Show info, warnings, and errors; Write which linter produced the message"
"let g:ale_lsp_show_message_severity = 'information'
"'let g:ale_echo_msg_format = '[%linter%] [%severity%:%code%] %s'
" Specify Containerfiles as Dockerfiles"
"let g:ale_linter_aliases = {"Containerfile": "dockerfile"}
" Mapping to run fixers on file"
"nnoremap <leader>L :ALEFix<CR>
" ---------------------------------------------------------

" ----------------- GitHub Copilot --------------------
" <M-]> Cycle next suggestion
" <M-[> Cycle previous suggestion
" <M-\> Request suggestion
" <M-Right> accept next word 
" <M-C-Right> Accept next line 
" Tab Accept suggestion (in insert mode)
" :Copilot panel to open the copilot panel
Plug 'github/copilot.vim'
" ---------------------------------------------------------

" ----------------- Icons --------------------
" Devicons
" Requires a patched font, like Nerd Font
Plug 'ryanoasis/vim-devicons'
" ---------------------------------------------------------

" ----------------- Status Line --------------------
Plug 'bluz71/vim-mistfly-statusline'
let g:mistflyWithSearchCount = v:true
let g:mistflyWithIndentStatus = v:true
" ---------------------------------------------------------

" ----------------- Auto Pairs --------------------
" <M-b back insert pair
" <M-n jump to next closed pair
" <M-p tooggle auto pairs on and off
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsMoveCharacter = ""
let g:AutoPairsShortcutBackInsert = ""
let g:AutoPairsShortcutFastWrap = ""

" ---------------------------------------------------------
"

" ----------------- Git Gutter --------------------
" Show git diff in the sign column
" + added, ~ modified, - removed
Plug 'airblade/vim-gitgutter'

" ---------------------------------------------------------

" ------------------ Which Key --------------------
" , to open which-key
" :WhichKey to open which-key
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

nnoremap <silent> <leader> :WhichKey ','<CR>
" ---------------------------------------------------------

" ------------------ Highlight Colors --------------------
" :ColorHighlight
Plug 'chrisbra/Colorizer'

" ---------------------------------------------------------

" ------------------ Multiple Cursors --------------------
" C-D select words, C-move add cur, Shift move single char,
" n/N Next/Prev - [] next/prev cur, q skip, Q remove cursor
" C-d to select word under cursor and then \\A to select all instances
" then c to change all instances

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n

nmap   <C-LeftMouse>         <Plug>(VM-Mouse-Cursor)
nmap   <C-RightMouse>        <Plug>(VM-Mouse-Word)  
nmap   <M-C-RightMouse>      <Plug>(VM-Mouse-Column)
" ---------------------------------------------------------

"------------------- Git Integration --------------------
" Git
" :Gstatus, :Gblame, :Gdiff, :Gread, :Gwrite, :Gmove, :Gremove, :Gcommit etc
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse

" Show git commit under cursor
Plug 'rhysd/git-messenger.vim'
let g:git_messenger_no_default_mappings = v:true

nmap <C-g>m <Plug>(git-messenger)
" ---------------------------------------------------------

" ------------------ Commenting --------------------
" gcc to comment/uncomment a line
" gc in visual mode to comment/uncomment selection
" gc{motion} to comment/uncomment motion
" Example: gcip to comment inner paragraph
Plug 'tpope/vim-commentary'

" ---------------------------------------------------------

" " ------------------ Undo Tree --------------------
Plug 'mbbill/undotree'
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_SetFocusWhenToggle = 1

" ---------------------------------------------------------

" " ------------------ Indentation Guides --------------------
Plug 'Yggdroot/indentLine'
" ------------------- Highlight on Yank --------------------
Plug 'machakann/vim-highlightedyank'
" ------------------ HIghlight Cursor Word --------------------
Plug 'RRethy/vim-illuminate'
" ------------------ Dim Inactive Windows --------------------
Plug 'blueyed/vim-diminactive'
" ---------------------------------------------------------


" ----------- Alternative fuzzy finder to fzf --------------
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
" ---------------------------------------------------------

" ------------------ Surround --------------------
" Manipulate surrounding chars such as quotes and brackets
" Assuming | as a cursor
" fo|o - ysiw' - 'foo'
" 'fo|o' - ds' - foo
" 'fo|o' - cs'" - "foo"
" yssb - (surround entire line)
" Shift + V to enter visual line mode then S{ to surround selection with { line break }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " repeat surround with .
" ---------------------------------------------------------

" ------------------ Speed Dating --------------------
" CTRL-A and CTRL-X to increment/decrement dates, times, numbers, hex colors,
Plug 'tpope/vim-speeddating'
" ---------------------------------------------------------

" ------------------ Results of commands as buffers --------------------
" Interact with output of commands 
" e.g :Bufferize cargo watch
Plug 'AndrewRadev/bufferize.vim'
" ---------------------------------------------------------

" ------------------ File operations --------------------
" File/Buffer operations :Rename, :Move, :Delete, :Chmod, :SudoEdit
Plug 'tpope/vim-eunuch'
"" Make me dirs when saving a full path
Plug 'pbrisbin/vim-mkdir'
" ---------------------------------------------------------


" ------------------ Scratch Buffer --------------------
" gs in normal mode to open a scratch buffer in insert mode
" gs in visual mode to open a scratch buffer with the selection
" Scratch buffer persists between sessions in ~/.vim/scratch.md
" :Scratch to open a scratch buffer in normal mode
Plug 'mtth/scratch.vim'
let g:scratch_persistence_file = '~/.vim/scratch.md'
" ---------------------------------------------------------

" ------------------ Window Based on Selection --------------------
"" Split window based on visual selection
" C-W-gsa creates a split above with the selection C-W-gss on right
" CW-gr resizes to selection
Plug 'wellle/visual-split.vim'
for m in ['n', 'x']
  execute m . "noremap <C-w>gr  :VSResize<CR>"
  execute m . "noremap <C-w>gss :VSSplit<CR>"
  execute m . "noremap <C-w>gsa :VSSplitAbove<CR>"
  execute m . "noremap <C-w>gsb :VSSplitBelow<CR>"
endfor
" ---------------------------------------------------------


" ------------------ Color Picker --------------------
" ALT-c in insert mode and ALT-w in normal mode
Plug 'KabbAmine/vCoolor.vim'
" ---------------------------------------------------------

" ------------------ Distraction Free Writing --------------------
" <C-w>g opens goyo distraction free mode
Plug 'junegunn/goyo.vim'
nnoremap <C-w>g :Goyo<CR>
inoremap <C-w>g <Esc>:Goyo<CR>
" ---------------------------------------------------------

" ------------------ Zoom Window --------------------
" Window Zoom in out
" <C-w>m to toggle zoom
Plug 'dhruvasagar/vim-zoom'
" ---------------------------------------------------------

" ------------------ Better Cut and Delete --------------------
" Delete instead of cut (cut is mapped to x, single char is dl)
Plug 'svermeulen/vim-cutlass'
nnoremap x d
xnoremap x d
nnoremap xx dd
nnoremap X D
" ---------------------------------------------------------

" ------------------ Easy Motion --------------------
" ,,motion
" ,,fa = find the next `a` with visual hints
Plug 'easymotion/vim-easymotion'"
" ---------------------------------------------------------

" " ------------------ Better Substitutions --------------------
Plug 'tpope/vim-abolish'
Plug 'svermeulen/vim-subversive'

" Subversive Subvert
" s+motion to substitute with yanked text
nmap s <plug>(SubversiveSubstitute)
" ss to substitute current line with yanked text
nmap ss <plug>(SubversiveSubstituteLine)
" S to substitute from cursor to end of line with yanked text
nmap S <plug>(SubversiveSubstituteToEndOfLine)
" <leader>s+motion to substitute with prompted text
" example: <leader>siwip to select inner word and range inner paragraph to
" substitute with prompted text
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
" <leader>ssie to select current word and range entire buffer to substitute
" with prompted text
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
" Same as above but use Subvert so matches different text casing 
" ,,ssie will match "Word", "word", "WORD", etc
nmap <leader><leader>s <plug>(SubversiveSubvertRange)
xmap <leader><leader>s <plug>(SubversiveSubvertRange)
nmap <leader><leader>ss <plug>(SubversiveSubvertWordRange)

" ---------------------------------------------------------

" ------------------ Yoink - Better Yank and Paste --------------------

Plug 'svermeulen/vim-yoink'
let g:yoinkIncludeDeleteOperations = 1
let g:yoinkMaxItems = 20
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
" Also replace the default gp with yoink paste so we can toggle paste in this case too
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)
" Rotate the yank buffer
nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)
" maintain cursor position when yanking
nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)
" ---------------------------------------------------------

" ------------------ Find and Replace --------------------
" Find and Replace in multiple files
" :Far pattern replacement files_or_glob
" Example: :Far foo bar **/*.txt
" After running execute :Fardo to apply
Plug 'brooth/far.vim'
" ---------------------------------------------------------

" ------------------ Extra Text Objects --------------------
" Extra wrapper target text objects
" cI, = change inner comma (any type)
" da, = delete around comma (any type)
Plug 'wellle/targets.vim' " IS this conflicting with Subvert?
" ai = around indentation
" cai = change around indentation 
" ii = inner indentation
" cii = change inner indentation
" aI = around including lines above/below
" iI = inner no lines above/below
Plug 'michaeljsmith/vim-indent-object'

" ie = inner entire buffer
" cie = change inner entire buffer
" vie = visually select inner entire buffer
" die = delete inner entire buffer
onoremap ie :exec "normal! ggVG"<cr>
" iv = current viewable text in the buffer
" civ = change current viewable text in the buffer
" viv = visually select current viewable text in the buffer
" div = delete current viewable text in the buffer
onoremap iv :exec "normal! HVL"<cr>
" ---------------------------------------------------------


" ------------------ Avoid meesing with window layout --------------------
" Avoid deleting buffer and messing with window layout
" :Bdelete to delete buffer without messing with window layout
Plug 'moll/vim-bbye'
nnoremap <leader>bd :Bdelete<CR> " delete buffer
nnoremap <leader>bx :Bdelete!<CR> " delete buffer without saving
" ---------------------------------------------------------

" ------------------- Substitute with preview --------------------
" :OverCommandLine 
" > %s/foo/bar/gc
" Press Enter to preview substitutions
Plug 'osyo-manga/vim-over'
" ---------------------------------------------------------

" " ------------------- Most Recently Used Files --------------------
":MRU list
Plug 'yegappan/mru'
" ---------------------------------------------------------

" ------------------- Swap Windows --------------------
" Navigate to a window by its marker
" - opens overlay with window numbers to choose from
" then: s to swap, S to swap and stay, - to previous, -ss swap with previous 
Plug 't9md/vim-choosewin'
let g:choosewin_overlay_enable = 1
nmap  -  <Plug>(choosewin)
" ---------------------------------------------------------

" ------------------- Auto adjust expandtab  --------------------
" Detect and set expandtab, tabstop, shiftwidth based on file content
Plug 'tpope/vim-sleuth'
" ---------------------------------------------------------

" ----------------- HTTP Client --------------------
" :set ft=rest 
" Write multiple requests on a buffer
" Example:
"     -s
"     Content-Type: application/json
"     --
"     https://httpbingo.org
"     POST /post
"     {"batata": 123}
"
" <C-j> with the cursor on the request to execute
" 
Plug 'diepm/vim-rest-console'
let g:vrc_output_buffer_name = '__VRC_OUTPUT.json'
let g:vrc_curl_opts = {
    \ '-k':'', 
    \ '-L':'',
\}
" ---------------------------------------------------------

" ----------------- MArkdown tables ----------------------
" ,tm to toggle table mode
Plug 'dhruvasagar/vim-table-mode'

" ---------------------------------------------------------

" ----------------- Markdown Preview ----------------------
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction

" Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'rochacbruno/vim-markdown-composer', { 'do': function('BuildComposer'), 'branch': 'fix/bump-deps' }
let g:markdown_composer_autostart = 0

" ---------------------------------------------------------

" ----------------- Go to File Manager or Terminal -----------
Plug 'justinmk/vim-gtfo'
" got = open terminal in current file's directory
" gof = open file manager in current file's directory
let g:gtfo#terminals = { 'unix': 'kitty @ launch --cwd="%:p:h"' }
"
"
" TODO: Check for a custom.plugins.vim and source it here
"
" Why Copilot keeps removing my blank lines?
" --- PLUGINS END ---
call plug#end()


