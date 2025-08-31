" ===============================================================================
" Plugin Configuration
" type: za to togle a specific fold or zr/zm to toggle all folds
" ===============================================================================
" This file manages all plugins using vim-plug and built-in packages
" ===============================================================================

" ===============================================================================
" Built-in Plugins
" ===============================================================================

" Netrw - Built-in file explorer {{{
" Configure Vim's native file browser for better usability
let g:netrw_banner = 0                    " Hide the banner
let g:netrw_liststyle = 3                 " Tree-style listing
let g:netrw_browse_split = 4              " Open files in previous window
let g:netrw_altv = 1                      " Open splits to the right
let g:netrw_winsize = 25                  " Width of explorer window
let g:netrw_keepdir = 0                   " Keep current directory synced
runtime! plugin/netrwPlugin.vim          " Load netrw plugin
" Key mappings:
Nmap 'Open explorer on left|Files' <leader>e :Lexplore<CR>
Nmap 'Open explorer in vertical split|Files' <leader>E :Vexplore<CR>
" }}}

" LSP - Language Server Protocol support {{{
" Provides code intelligence: completion, diagnostics, go-to-definition, etc.
" Repository: https://github.com/yegappan/lsp
" Note: LSP servers must be installed separately for each language
" Auto-install LSP plugin if not present
if empty(glob('~/.vim/pack/downloads/opt/lsp'))
    echo "Installing LSP plugin..."
    silent !mkdir -p $HOME/.vim/pack/downloads/opt
    silent !cd $HOME/.vim/pack/downloads/opt && git clone https://github.com/yegappan/lsp
    silent !vim -u NONE -c "helptags $HOME/.vim/pack/downloads/opt/lsp/doc" -c q
    echo "LSP plugin installed successfully"
endif
packadd lsp                               " Load LSP plugin
source ~/.vim/lsp.vim                     " Load LSP configuration
" Key mappings:
Nmap 'Show code actions|LSP' <leader>a :LspCodeAction<CR>
Nmap 'Go to definition|LSP' <leader>d :LspGotoDefinition<CR>
Nmap 'Show hover information|LSP' <leader>k :LspHover<CR>
" }}}

" ===============================================================================
" Vim-Plug Managed Plugins
" ===============================================================================

" Vim-Plug Installation and Setup {{{
" Auto-install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Begin plugin declarations
call plug#begin()
" }}}

" ===============================================================================
" Core Enhancement Plugins
" ===============================================================================

" Vim Sensible - Better default settings {{{
" Provides a universal set of defaults that everyone can agree on
Plug 'tpope/vim-sensible'
" }}}

" Matchit - Enhanced % matching {{{
" Jump between matching pairs: (), {}, [], <>, HTML tags
" Works in normal and visual modes
" See :help matchit-custom for defining custom pairs
Plug 'chrisbra/matchit'
" }}}

" ===============================================================================
" File Search and Navigation
" ===============================================================================

" FZF - Fuzzy file finder integration {{{
" Requires: fzf binary installed on system
if executable('fzf')
  Plug 'junegunn/fzf.vim'
  " Key mappings:
  Nmap 'List open buffers|Buffers' <leader>b :Buffers<CR>
  Nmap 'Find files|Files' <leader>f :Files<CR>
  Nmap 'Git files|Git' <leader>g :GFiles<CR>
  Nmap 'Jumplist|Edit' <leader>j :Jumps<CR>
  Nmap 'lines in current buffer|Search' <leader>l :Lines<CR>
  Nmap 'text with ripgrep|Search' <silent><leader>r :Rg<CR>
  
  Nmap 'Recent Files|Files' <leader>rf :History<CR>
  Nmap 'Changes on buffers|Edit' <leader>cb :Changes<CR>

  Nmap 'Commits|Git' <leader>gc :Commits<CR>
  Xmap 'Commits affecting selection|Git' <leader>gc :Commits<CR>
  Nmap 'Git status|Git' <leader>gs :GFiles?<CR>
else
  echo "fzf is not installed, please install it to use fzf.vim"
endif
" }}}

" ===============================================================================
" Linting and Formatting
" ===============================================================================

" ALE - Asynchronous Lint Engine {{{
" Provides real-time linting and fixing
" Requires: Various linters/formatters installed for each language
Plug 'dense-analysis/ale'
" ALE Configuration (currently disabled in favor of LSP)
" Uncomment the following lines to enable ALE:
" let g:ale_disable_lsp = 1                           " Disable ALE's LSP features
" let g:ale_set_signs = 1                             " Show signs in gutter
" let g:ale_set_highlights = 1                        " Highlight problematic lines
" let g:ale_virtualtext_cursor = 1                    " Show errors as virtual text
" highlight ALEError ctermbg=none cterm=underline     " Error highlighting style
" let g:ale_lint_on_save = 1                          " Lint when saving
" let g:ale_lint_on_insert_leave = 1                  " Lint when leaving insert mode
" let g:ale_lint_on_text_change = 'never'             " Don't lint while typing
" let g:ale_linters_explicit = 1                      " Only use configured linters
" let g:ale_linters = {
"     \ 'python': ['ruff', 'mypy', 'pylsp'],
"     \ 'rust': ['analyzer', 'cargo'],
"     \ 'sh': ['shellcheck'],
" \ }
" let g:ale_fixers = {
"     \ '*': ['trim_whitespace'],
"     \ 'python': ['ruff'],
"     \ 'rust': ['rustfmt'],
" \ }
" let g:ale_rust_cargo_use_clippy = 1                 " Use clippy for Rust
" let g:ale_rust_cargo_check_tests = 1                " Check test code
" let g:ale_rust_cargo_check_examples = 1             " Check example code
" let g:ale_warn_about_trailing_whitespace = 0        " Don't warn about whitespace
" let g:ale_lsp_show_message_severity = 'information' " Show all message levels
" let g:ale_echo_msg_format = '[%linter%] [%severity%:%code%] %s'
" let g:ale_linter_aliases = {"Containerfile": "dockerfile"}
" nnoremap <leader>L :ALEFix<CR>                      " ,L - Run fixers
" }}}

" ===============================================================================
" Productivity Enhancement Plugins
" ===============================================================================

" GitHub Copilot - AI code completion {{{
" Document Copilot mappings without overriding them
Imap 'Cycle next suggestion|Copilot' <M-]>
Imap 'Cycle previous suggestion|Copilot' <M-[>
Imap 'Request suggestion|Copilot' <M-\>
Imap 'Accept next word|Copilot' <M-Right>
Imap 'Accept next line|Copilot' <M-C-Right>
Imap 'Accept suggestion|Copilot' <Tab>
" Use :Copilot panel to open the copilot panel
Plug 'github/copilot.vim'

" }}}

" Vim DevIcons - File type icons {{{
" Devicons - Requires a patched font, like Nerd Font
Plug 'ryanoasis/vim-devicons'

" }}}

" Mistfly Statusline - Enhanced status line {{{
Plug 'bluz71/vim-mistfly-statusline'
let g:mistflyWithSearchCount = v:true
let g:mistflyWithIndentStatus = v:true

" }}}

" Auto Pairs - Automatic bracket pairing {{{
" Document Auto Pairs mappings without overriding them
Imap 'Back insert pair|Auto Pairs' <M-b>
Imap 'Jump to next closed pair|Auto Pairs' <M-n>
Imap 'Toggle auto pairs on/off|Auto Pairs' <M-p>
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsMoveCharacter = ""
let g:AutoPairsShortcutBackInsert = ""
let g:AutoPairsShortcutFastWrap = ""

" }}}

" GitGutter - Git diff in sign column {{{
" Show git diff in the sign column
" + added, ~ modified, - removed
Plug 'airblade/vim-gitgutter'

" }}}


" Colorizer - Highlight color codes {{{
" :ColorHighlight
Plug 'chrisbra/Colorizer'

" }}}

" ===============================================================================
" Multi-Cursor Editing
" ===============================================================================

" Visual Multi - Multiple cursor support {{{
" Key mappings:
" Document Visual Multi mappings without overriding them
Nmap 'Select word under cursor / Add next occurrence|Visual Multi' <C-d>
Xmap 'Add next occurrence|Visual Multi' <C-d>
" n/N         - Next/previous occurrence
" [/]         - Next/previous cursor
" q           - Skip current and find next
" Q           - Remove current cursor
" \\A         - Select all occurrences
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'  " Replace default C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'  " Replace visual C-n
" Mouse support:
Nmap 'Add cursor with Ctrl+Click|Visual Multi' <C-LeftMouse> <Plug>(VM-Mouse-Cursor)
Nmap 'Select word with Ctrl+Right|Visual Multi' <C-RightMouse> <Plug>(VM-Mouse-Word)
Nmap 'Column selection|Visual Multi' <M-C-RightMouse> <Plug>(VM-Mouse-Column)

" }}}

" ===============================================================================
" Git Integration
" ===============================================================================

" Fugitive - Git commands in Vim {{{
" Repository: https://github.com/tpope/vim-fugitive
" Commands: :Gstatus, :Gblame, :Gdiff, :Gread, :Gwrite, :Gmove, :Gremove, :Gcommit
" Comprehensive Git integration for Vim with full workflow support
Plug 'tpope/vim-fugitive'
" }}}

" Rhubarb - GitHub integration for Fugitive {{{
" Repository: https://github.com/tpope/vim-rhubarb
" Required by Fugitive for :Gbrowse command to open files/commits on GitHub
Plug 'tpope/vim-rhubarb'
" }}}

" Git Messenger - Show commit info under cursor {{{
" Repository: https://github.com/rhysd/git-messenger.vim
" Shows git commit message, author, and date for line under cursor
Plug 'rhysd/git-messenger.vim'
let g:git_messenger_no_default_mappings = v:true
" Key mappings:
Nmap 'Show git commit info|Git' <leader>gm <Plug>(git-messenger)

" }}}

" ===============================================================================
" Code Commenting
" ===============================================================================
 
" Commentary - Smart commenting plugin {{{
" Repository: https://github.com/tpope/vim-commentary
" Provides intelligent commenting/uncommenting for various file types
" Automatically detects file type and uses appropriate comment syntax

Plug 'tpope/vim-commentary'

Nmap 'Uncomment adjacent commented lines|Commentary' gcu
Nmap 'Comment Toggle|Commentary' <C-/> <Plug>CommentaryLine
Imap 'Comment Toggle|Commentary' <C-/> <Esc><Plug>CommentaryLineA
Xmap 'Comment Toggle|Commentary' <C-/> <Plug>Commentarygv
Omap 'Comment Toggle|Commentary' <C-/> <Plug>Commentary

" the following mappings are for keyboards where Ctrl+/ is not possible
nnoremap <silent> <C-_> <Plug>CommentaryLine
inoremap <silent> <C-_> <Esc><Plug>CommentaryLineA
xnoremap <silent> <C-_> <Plug>Commentarygv
onoremap <silent> <C-_> <Plug>Commentary

" }}}

" ===============================================================================
" Undo Tree Visualization
" ===============================================================================

" UndoTree - Visual undo history {{{
" Repository: https://github.com/mbbill/undotree
" Visual undo history browser with branching support
" Navigate through complex undo/redo history with ease
Plug 'mbbill/undotree'
let g:undotree_WindowLayout = 2        " Vertical layout with diff window
let g:undotree_ShortIndicators = 1     " Use short time indicators
let g:undotree_SetFocusWhenToggle = 1  " Focus undo tree when opened
" Key mappings:
" :UndotreeToggle - Toggle undo tree window
" j/k             - Navigate through undo states
" <Enter>         - Revert to selected state
" }}}

" ===============================================================================
" Visual Enhancement Plugins
" ===============================================================================

" IndentLine - Show indentation guides {{{
" Repository: https://github.com/Yggdroot/indentLine
" Displays thin vertical lines for each indentation level
Plug 'Yggdroot/indentLine'
" }}}

" HighlightedYank - Highlight yanked text {{{
" Repository: https://github.com/machakann/vim-highlightedyank
" Briefly highlights yanked text for visual feedback
Plug 'machakann/vim-highlightedyank'
" }}}

" Illuminate - Highlight word under cursor {{{
" Repository: https://github.com/RRethy/vim-illuminate
" Highlights all occurrences of word under cursor throughout buffer
Plug 'RRethy/vim-illuminate'
" }}}

" DiminActive - Dim inactive windows {{{
" Repository: https://github.com/blueyed/vim-diminactive
" Reduces brightness of inactive windows to focus on current window
Plug 'blueyed/vim-diminactive'
" }}}

" ===============================================================================
" Alternative Fuzzy Finder
" ===============================================================================

" Vim Clap - Modern fuzzy finder {{{
" Repository: https://github.com/liuchengxu/vim-clap
" Modern fuzzy finder with floating windows and fast performance
" Alternative to FZF with more modern UI and additional features
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
" Key mappings:
" :Clap files     - Find files
" :Clap grep      - Search text
" :Clap buffers   - Switch buffers
" :Clap history   - Command history
" }}}

" ===============================================================================
" Text Object Manipulation - Surround
" ===============================================================================

" Surround - Manipulate surrounding characters {{{
" Repository: https://github.com/tpope/vim-surround
" Work with quotes, brackets, tags, and custom delimiters
" Manipulate surrounding characters like quotes, brackets, and tags
Plug 'tpope/vim-surround'
" }}}

" Repeat - Repeat surround operations with dot {{{
" Repository: https://github.com/tpope/vim-repeat
" Enables dot repetition for surround operations
Plug 'tpope/vim-repeat'
" Key mappings:
" Document Surround mappings without overriding them
Nmap 'Surround inner word (ysiw + delimiter)|Surround' ysiw
Nmap 'Delete surrounding (ds + delimiter)|Surround' ds
Nmap 'Change surrounding (cs + old + new)|Surround' cs
Nmap 'Surround entire line (yss + delimiter)|Surround' yss
Xmap 'Surround selection (S + delimiter)|Surround' S
" }}}

" ===============================================================================
" Smart Number/Date Manipulation
" ===============================================================================

" Enhanced increment/decrement for dates, times, and various number formats
" Extends Vim's native Ctrl-A/Ctrl-X functionality

" SpeedDating - Smart increment/decrement {{{
" Repository: https://github.com/tpope/vim-speeddating
" Handles dates, times, hex colors, Roman numerals, and more
" Enhanced increment/decrement for dates, times, and various number formats
Plug 'tpope/vim-speeddating'
" Key mappings:
" Document SpeedDating mappings without overriding them
Nmap 'Increment number/date under cursor|SpeedDating' <C-a>
Nmap 'Decrement number/date under cursor|SpeedDating' <C-x>
" Supported formats: 2023-12-25, 12:30:45, #ff0000, XIV, etc.
" }}}

" ===============================================================================
" Command Output Management
" ===============================================================================

" Capture command output in interactive buffers for better workflow
" Useful for long-running commands and interactive development

" Bufferize - Command output in buffers {{{
" Repository: https://github.com/AndrewRadev/bufferize.vim
" Captures shell command output in manageable Vim buffers
Plug 'AndrewRadev/bufferize.vim'
" Usage examples:
" :Bufferize cargo watch  - Run cargo watch in buffer
" :Bufferize git log      - Show git log in buffer
" :Bufferize make test    - Run tests with output in buffer
" }}}

" ===============================================================================
" File System Operations
" ===============================================================================

" Enhanced file and directory operations within Vim
" Provides Unix-like commands and automatic directory creation

" Eunuch - Unix shell commands in Vim {{{
" Repository: https://github.com/tpope/vim-eunuch
" Provides file operations without leaving Vim
Plug 'tpope/vim-eunuch'
" Commands: :Rename, :Move, :Delete, :Chmod, :SudoEdit, :SudoWrite
" }}}

" Mkdir - Auto-create directories {{{
" Repository: https://github.com/pbrisbin/vim-mkdir
" Automatically creates parent directories when saving files
Plug 'pbrisbin/vim-mkdir'
" }}}

" ===============================================================================
" Scratch Buffer for Quick Notes
" ===============================================================================

" Persistent scratch buffer for temporary notes and quick calculations
" Perfect for jotting down ideas without creating temporary files

" Scratch - Persistent scratch buffer {{{
" Repository: https://github.com/mtth/scratch.vim
" Provides a persistent scratch space for notes and temporary content
Plug 'mtth/scratch.vim'
let g:scratch_persistence_file = '~/.vim/scratch.md'  " Persist across sessions
" Key mappings:
" Document Scratch mappings without overriding them
Nmap 'Open scratch buffer in insert mode|Scratch' gs
Xmap 'Open scratch buffer with selection|Scratch' gs
" :Scratch    - Open scratch buffer in normal mode
" }}}

" ===============================================================================
" Visual Selection Window Management
" ===============================================================================

" Create new windows based on visual selections for better code organization
" Useful for comparing code sections or focusing on specific parts

" Visual Split - Selection-based window splitting {{{
" Repository: https://github.com/wellle/visual-split.vim
" Create splits containing only the selected text
Plug 'wellle/visual-split.vim'
" Configure key mappings for visual splits
Nmap 'Resize window to selection|Visual Split' <C-w>gr :VSResize<CR>
Nmap 'Split right with selection|Visual Split' <C-w>gss :VSSplit<CR>
Nmap 'Split above with selection|Visual Split' <C-w>gsa :VSSplitAbove<CR>
Nmap 'Split below with selection|Visual Split' <C-w>gsb :VSSplitBelow<CR>
Xmap 'Resize window to selection|Visual Split' <C-w>gr :VSResize<CR>
Xmap 'Split right with selection|Visual Split' <C-w>gss :VSSplit<CR>
Xmap 'Split above with selection|Visual Split' <C-w>gsa :VSSplitAbove<CR>
Xmap 'Split below with selection|Visual Split' <C-w>gsb :VSSplitBelow<CR>
" Key mappings:
" Ctrl-w gr   - Resize window to selection
" Ctrl-w gss  - Split right with selection
" Ctrl-w gsa  - Split above with selection
" Ctrl-w gsb  - Split below with selection
" }}}

" ===============================================================================
" Color Picker Integration
" ===============================================================================

" Interactive color picker for web development and design work
" Provides system color picker integration within Vim

" vCoolor - System color picker integration {{{
" Repository: https://github.com/KabbAmine/vCoolor.vim
" Opens system color picker and inserts hex/rgb values
Plug 'KabbAmine/vCoolor.vim'
" Key mappings:
" Document vCoolor mappings without overriding them
Imap 'Open color picker|vCoolor' <M-c>
Nmap 'Open color picker|vCoolor' <M-w>
" }}}

" ===============================================================================
" Distraction-Free Writing Mode
" ===============================================================================

" Clean, minimal writing environment for focused work
" Perfect for documentation, markdown, and creative writing

" Goyo - Distraction-free writing {{{
" Repository: https://github.com/junegunn/goyo.vim
" Centers content and hides UI elements for focused writing
Plug 'junegunn/goyo.vim'
" Key mappings:
Nmap 'Toggle Goyo mode|Writing' <C-w>g :Goyo<CR>
Imap 'Toggle Goyo mode|Writing' <C-w>g <Esc>:Goyo<CR>
" }}}

" ===============================================================================
" Window Zoom Functionality
" ===============================================================================

" Temporarily maximize current window while preserving layout
" Useful for focusing on specific code sections in multi-window setups

" Vim Zoom - Window zoom toggle {{{
" Repository: https://github.com/dhruvasagar/vim-zoom
" Maximizes current window and restores previous layout
Plug 'dhruvasagar/vim-zoom'
" Key mappings:
" Document Vim Zoom mappings without overriding them
Nmap 'Toggle window zoom (maximize/restore)|Vim Zoom' <C-w>m
" }}}

" ===============================================================================
" Improved Cut/Delete Operations
" ===============================================================================

" Separates delete and cut operations for more intuitive editing
" Prevents accidental clipboard pollution when deleting text

" ===============================================================================
" Cutlass - Separate cut and delete
" ===============================================================================
" {{{
" Repository: https://github.com/svermeulen/vim-cutlass
" Makes delete operations not affect clipboard/register
Plug 'svermeulen/vim-cutlass'
" Remap cut operations to x key
Nmap 'Cut (delete to register)|Edit' x d
Xmap 'Cut in visual mode|Edit' x d
Nmap 'Cut entire line|Edit' xx dd
Nmap 'Cut to end of line|Edit' X D
" Note: d/dd now delete without affecting clipboard
" Use x/xx for traditional cut behavior
" }}}

" ===============================================================================
" Enhanced Motion Commands
" ===============================================================================

" Fast cursor movement with visual hints throughout the buffer
" Replaces repetitive h/j/k/l navigation with targeted jumps

" ===============================================================================
" EasyMotion - Visual motion hints
" ===============================================================================

" {{{
" Repository: https://github.com/easymotion/vim-easymotion
" Provides visual hints for quick cursor positioning
Plug 'easymotion/vim-easymotion'
" Key mappings:
" Document EasyMotion mappings without overriding them
Nmap 'Trigger EasyMotion for any motion|EasyMotion' <leader><leader>
" <leader><leader>w         - Jump to word beginnings
" <leader><leader>f{char}   - Find character with hints
" <leader><leader>j         - Jump to lines below
" <leader><leader>k         - Jump to lines above
" }}}

" ===============================================================================
" Advanced Text Substitution
" ===============================================================================

" Enhanced substitution operations with smart case handling
" Provides intuitive substitute-with-yank and case-aware replacements

" ===============================================================================
" Abolish - Smart substitution with case variants
" ===============================================================================
" {{{
" Repository: https://github.com/tpope/vim-abolish
" Handles multiple case variants in substitutions (Word/word/WORD)
Plug 'tpope/vim-abolish'
" }}}

" ===============================================================================
" Subversive - Substitute with yanked text
" ===============================================================================
" {{{
" Repository: https://github.com/svermeulen/vim-subversive
" Provides intuitive substitute operations using yanked content
Plug 'svermeulen/vim-subversive'

" Key mappings for substitute operations:
Nmap 'Substitute motion with yanked text|Subversive' s <plug>(SubversiveSubstitute)
Nmap 'Substitute current line with yanked text|Subversive' ss <plug>(SubversiveSubstituteLine)
Nmap 'Substitute to end of line with yanked text|Subversive' S <plug>(SubversiveSubstituteToEndOfLine)

" Prompted substitution mappings:
Nmap 'Substitute motion with prompted text|Subversive' <leader>s <plug>(SubversiveSubstituteRange)
Xmap 'Substitute motion with prompted text|Subversive' <leader>s <plug>(SubversiveSubstituteRange)
Nmap 'Substitute word across buffer with prompted text|Subversive' <leader>ss <plug>(SubversiveSubstituteWordRange)

" Case-aware substitution (uses Abolish):
Nmap 'Smart case substitute motion|Subversive' <leader><leader>s <plug>(SubversiveSubvertRange)
Xmap 'Smart case substitute motion|Subversive' <leader><leader>s <plug>(SubversiveSubvertRange)
Nmap 'Smart case substitute word across buffer|Subversive' <leader><leader>ss <plug>(SubversiveSubvertWordRange)
" }}}

" ===============================================================================
" Enhanced Yank and Paste System
" ===============================================================================

" Improved yank/paste operations with history management
" Maintains clipboard history and provides easy access to previous yanks

" ===============================================================================
" Yoink - Enhanced yank/paste with history
" ===============================================================================
" {{{
" Repository: https://github.com/svermeulen/vim-yoink
" Provides yank history and better paste behavior
Plug 'svermeulen/vim-yoink'
let g:yoinkIncludeDeleteOperations = 1        " Include delete operations in history
let g:yoinkMaxItems = 20                      " Keep last 20 yank items

" Post-paste navigation:
Nmap 'Previous yank after paste|Yoink' <c-n> <plug>(YoinkPostPasteSwapBack)
Nmap 'Next yank after paste|Yoink' <c-p> <plug>(YoinkPostPasteSwapForward)

" Enhanced paste operations:
Nmap 'Paste with yoink history|Yoink' p <plug>(YoinkPaste_p)
Nmap 'Paste before with yoink history|Yoink' P <plug>(YoinkPaste_P)
Nmap 'Paste and move cursor|Yoink' gp <plug>(YoinkPaste_gp)
Nmap 'Paste before and move cursor|Yoink' gP <plug>(YoinkPaste_gP)

" Yank history navigation:
Nmap 'Previous item in yank history|Yoink' [y <plug>(YoinkRotateBack)
Nmap 'Next item in yank history|Yoink' ]y <plug>(YoinkRotateForward)

" Cursor position preservation:
Nmap 'Yank without moving cursor|Yoink' y <plug>(YoinkYankPreserveCursorPosition)
Xmap 'Yank selection without moving cursor|Yoink' y <plug>(YoinkYankPreserveCursorPosition)
" }}}

" ===============================================================================
" Multi-File Find and Replace
" ===============================================================================

" Interactive find and replace across multiple files with preview
" Safe bulk text replacement with confirmation before applying changes

" ===============================================================================
" Far - Multi-file find and replace
" ===============================================================================
" {{{
" Repository: https://github.com/brooth/far.vim
" Provides interactive find/replace with preview and confirmation
Plug 'brooth/far.vim'
" Usage workflow:
" :Far pattern replacement files_glob  - Find and preview replacements
" :Fardo                              - Apply all replacements
" :Farundo                            - Undo all replacements
" Example: :Far foo bar **/*.txt      - Replace 'foo' with 'bar' in all txt files
" }}}

" ===============================================================================
" Extended Text Objects
" ===============================================================================

" Additional text objects for more precise text manipulation
" Extends Vim's built-in text objects with useful additions

" ===============================================================================
" Targets - Advanced text objects
" ===============================================================================
" {{{
" Repository: https://github.com/wellle/targets.vim
" Provides additional pair text objects and seeking behavior
Plug 'wellle/targets.vim'
" Text objects:
" Document Targets text objects without overriding them
Omap 'Inside next comma-separated value|Targets' i,
Omap 'Around next parentheses|Targets' a)
Omap 'Inside next single quotes|Targets' i'
" }}}

" ===============================================================================
" Indent Object - Indentation-based text objects
" ===============================================================================
" {{{
" Repository: https://github.com/michaeljsmith/vim-indent-object
" Work with indentation levels as text objects
Plug 'michaeljsmith/vim-indent-object'
" Text objects:
" Document Indent Object text objects without overriding them
Omap 'Around indentation level|Indent Object' ai
Omap 'Inside indentation level|Indent Object' ii
Omap 'Around indentation level (including blank lines)|Indent Object' aI
Omap 'Inside indentation level (including blank lines)|Indent Object' iI
" }}}

" ===============================================================================
" Custom Text Objects
" ===============================================================================

" Custom text objects for buffer operations: {{{
" Entire buffer text object
Omap 'Inner entire buffer|Text Objects' ie :exec "normal! ggVG"<cr>

" Viewable text object (current screen)
Omap 'Current viewable text|Text Objects' iv :exec "normal! HVL"<cr>
" }}}

" ===============================================================================
" Buffer Management Without Layout Disruption
" ===============================================================================

" Delete buffers without closing windows or disrupting layout
" Maintains window structure when removing buffers from memory

" ===============================================================================
" Bbye - Better buffer deletion
" ===============================================================================
" {{{
" Repository: https://github.com/moll/vim-bbye
" Delete buffers without affecting window layout
Plug 'moll/vim-bbye'
" Key mappings:
Nmap 'Delete buffer (save first)|Buffers' <leader>bd :Bdelete<CR>
Nmap 'Force delete buffer (no save)|Buffers' <leader>bx :Bdelete!<CR>
" Commands:
" :Bdelete   - Delete current buffer, keep window
" :Bwipeout  - Wipeout current buffer, keep window
" }}}

" ===============================================================================
" Visual Substitution Preview
" ===============================================================================

" Interactive substitution with real-time preview of changes
" See substitution results before confirming changes

" ===============================================================================
" Over - Visual substitution preview
" ===============================================================================
" {{{
" Repository: https://github.com/osyo-manga/vim-over
" Shows live preview of substitution operations
Plug 'osyo-manga/vim-over'
" Usage:
" :OverCommandLine        - Enter Over mode
" > %s/pattern/replace/g  - Type substitution command
" Enter                   - Preview changes before applying
" Provides visual feedback for complex substitutions
" }}}

" ===============================================================================
" Most Recently Used Files
" ===============================================================================

" Quick access to recently opened files for faster workflow
" Maintains persistent list of recently accessed files

" ===============================================================================
" MRU - Most Recently Used files
" ===============================================================================
" {{{
" Repository: https://github.com/yegappan/mru
" Provides easy access to recently opened files
Plug 'yegappan/mru'
" Commands:
" :MRU        - Open MRU file list
" :MRU pattern - Search within MRU list
" File list persists across Vim sessions
" }}}

" ===============================================================================
" Interactive Window Management
" ===============================================================================

" Visual window selection and swapping with overlay interface
" Simplifies navigation and manipulation in multi-window layouts

" ===============================================================================
" ChooseWin - Interactive window selection
" ===============================================================================
" {{{
" Repository: https://github.com/t9md/vim-choosewin
" Provides overlay interface for window operations
Plug 't9md/vim-choosewin'
let g:choosewin_overlay_enable = 1        " Show window markers as overlay
" Key mappings:
Nmap 'Open window chooser|Windows' - <Plug>(choosewin)
" Operations in chooser:
" s      - Swap with selected window
" S      - Swap and stay in current window
" -      - Return to previous window
" -ss    - Swap with previous window
" }}}

" ===============================================================================
" Automatic Indentation Detection
" ===============================================================================

" Automatically detect and set indentation settings based on file content
" Adapts to project-specific indentation styles without manual configuration

" ===============================================================================
" Indentation and context
" ===============================================================================
" {{{
" Repository: https://github.com/tpope/vim-sleuth
" Detects tabs vs spaces and indentation width from existing code
Plug 'tpope/vim-sleuth'
" Automatically sets:
" - expandtab/noexpandtab (tabs vs spaces)
" - tabstop, shiftwidth (indentation width)
" - Based on analysis of current buffer content

" Shows current context of the file on the top
Plug 'wellle/context.vim'
" To enable the context use `:ContextEnable` and `:ContextDisable` and
" `:ContextToggle`
let g:context_enabled = 0

" }}}

" ===============================================================================
" HTTP REST Client
" ===============================================================================

" Execute HTTP requests directly from Vim buffers
" Perfect for API testing and development workflows

" ===============================================================================
" VRC - Vim REST Console
" ===============================================================================
" {{{
" Repository: https://github.com/diepm/vim-rest-console
" Execute HTTP requests with results in separate buffer
Plug 'diepm/vim-rest-console'
let g:vrc_output_buffer_name = '__VRC_OUTPUT.json'  " Output buffer name
let g:vrc_curl_opts = {
    \ '-k':'',
    \ '-L':''
\}
" Usage:
" 1. Set filetype: :set ft=rest
" 2. Write request format:
"    -s
"    Content-Type: application/json
"    --
"    https://httpbingo.org
"    POST /post
"    {"data": "value"}
" 3. Key mappings:
"    Ctrl-j  - Execute request under cursor
" }}}

" ===============================================================================
" Markdown Table Management
" ===============================================================================

" Enhanced table editing capabilities for Markdown documents
" Automatic table formatting and alignment with convenient shortcuts

" ===============================================================================
" Table Mode - Markdown table editing
" ===============================================================================
" {{{
" Repository: https://github.com/dhruvasagar/vim-table-mode
" Provides automatic table formatting and manipulation
Plug 'dhruvasagar/vim-table-mode'
" Key mappings:
" Document Table Mode mappings without overriding them
Nmap 'Toggle table mode|Table Mode' <leader>tm
" ||          - Start table or add column (table mode)
" |           - Add column separator (table mode)
" Features: Auto-alignment, row/column manipulation, table formatting
" }}}

" ===============================================================================
" Markdown Live Preview
" ===============================================================================

" Real-time Markdown preview in browser with automatic updates
" Requires Rust and Cargo for building the preview server

" ===============================================================================
" Build function for Markdown Composer
" ===============================================================================
" {{{
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction
" }}}

" ===============================================================================
" Markdown Composer - Live preview in browser
" ===============================================================================
" {{{
" Repository: https://github.com/rochacbruno/vim-markdown-composer
" Fork with updated dependencies for better compatibility
Plug 'rochacbruno/vim-markdown-composer', { 'do': function('BuildComposer'), 'branch': 'fix/bump-deps' }
let g:markdown_composer_autostart = 0         " Don't auto-start preview
" Commands:
" :ComposerStart  - Start live preview server
" :ComposerStop   - Stop preview server
" :ComposerOpen   - Open preview in browser
" }}}

" ===============================================================================
" External Application Integration
" ===============================================================================

" Quick access to system file manager and terminal from current file context
" Seamlessly bridge between Vim and external tools

" ===============================================================================
" GTFO - Go to file manager or terminal
" ===============================================================================
" {{{
" Repository: https://github.com/justinmk/vim-gtfo
" Opens external applications in current file's directory
Plug 'justinmk/vim-gtfo'
let g:gtfo#terminals = { 'unix': 'kitty @ launch --cwd="%:p:h"' }  " Use Kitty terminal
" Key mappings:
" Document GTFO mappings without overriding them
Nmap 'Open terminal in current files directory|GTFO' got
Nmap 'Open file manager in current files directory|GTFO' gof
" }}}


"===============================================================================
" Plugin Configuration Complete {{{
" ===============================================================================
" TODO: Check for a custom.plugins.vim and source it here for user extensions
"
" End plugin declarations
call plug#end()
" }}}

" vim: set foldmethod=marker foldlevel=0:
