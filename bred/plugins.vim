" ===============================================================================
" Plugin Configuration
" type: za to togle a specific fold or zr/zm to toggle all folds
" ===============================================================================
" This file manages all plugins using vim-plug and built-in packages
" ===============================================================================

" ===============================================================================
" Netrw - Built-in file explorer {{{
" ===============================================================================
let g:netrw_banner = 0                    " Hide the banner
let g:netrw_liststyle = 3                 " Tree-style listing
let g:netrw_browse_split = 4              " Open files in previous window
let g:netrw_altv = 1                      " Open splits to the right
let g:netrw_winsize = 25                  " Width of explorer window
let g:netrw_keepdir = 0                   " Keep current directory synced
let g:netrw_preview = 1                   " Preview files in explorer
runtime! plugin/netrwPlugin.vim           " Load netrw plugin
Nmap 'Open explorer on left|Files|1' <leader>e :Lexplore<CR>
Nmap 'Open explorer in vertical split|Files' <leader>E :Vexplore<CR>

" }}}
" ===============================================================================
" LSP - Language Server Protocol support {{{
" ==============================================================================
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
source ~/.vim/bred/lsp.vim                     " Load LSP configuration
" Key mappings:
Nmap 'Go to definition|LSP' gd :LspGotoDefinition<CR>
Nmap 'Go to references|LSP' gr :LspPeekReferences<CR>
Nmap 'Show code actions|LSP' <leader>ac :LspCodeAction<CR>
Nmap 'Show hover information|LSP' <leader>k :LspHover<CR>

" }}}
" ===============================================================================
" ###############################################################################
" Vim-Plug Managed Plugins
" ###############################################################################
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
" Core Enhancement Plugins {{{
" ===============================================================================

" Vim Sensible - Better default settings
" Provides a universal set of defaults that everyone can agree on
Plug 'tpope/vim-sensible'
" Matchit - Enhanced % matching
" Jump between matching pairs: (), {}, [], <>, HTML tags
" Works in normal and visual modes
" See :help matchit-custom for defining custom pairs
Plug 'chrisbra/matchit'

" Vim DevIcons - File type icons
" Devicons - Requires a patched font, like Nerd Font
Plug 'ryanoasis/vim-devicons'

" Mistfly Statusline - Enhanced status line
Plug 'bluz71/vim-mistfly-statusline'
let g:mistflyWithSearchCount = v:true
let g:mistflyWithIndentStatus = v:true

" Auto Pairs - Automatic bracket pairing
" Document Auto Pairs mappings without overriding them
Imap 'Back insert pair|Edit Pairs' <M-b>
Imap 'Jump to next closed pair|Edit Pairs' <M-n>
Imap 'Toggle auto pairs on/off|Edit Pairs' <M-p>
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsMoveCharacter = ""
let g:AutoPairsShortcutBackInsert = ""
let g:AutoPairsShortcutFastWrap = ""

" GitGutter - Git diff in sign column
" Show git diff in the sign column
" + added, ~ modified, - removed
Plug 'airblade/vim-gitgutter'

" Colorizer - Highlight color codes
" :ColorHighlight
Plug 'chrisbra/Colorizer'

" IndentLine - Show indentation guides
Plug 'Yggdroot/indentLine'
let g:indentLine_FileTypeExclude = ['help', 'nerdtree', 'vista', 'markdown', 'text']
let g:markdown_syntax_conceal=0
let g:vim_json_conceal=0
" let g:indentLine_char = '│'
" let g:indentLine_char = '┊'
" let g:indentLine_char = '┆'
" let g:indentLine_char = '┋'
" let g:indentLine_char = '┊'
" let g:indentLine_char = '┊'
let g:indentLine_char = '▏'
" let g:indentLine_color_term = 239
" let g:indentLine_color_gui = '#505050'
" let g:indentLine_concealcursor = 'nc'
" let g:indentLine_setConceal = 1
" let g:indentLine_showFirstIndentLevel = v:false
" let g:indentLine_showTrailingBlanklineIndent = v:false
" let g:indentLine_showCurrentContext = v:true
" let g:indentLine_context_patterns = ['class', 'function', 'method', 'if', 'while', 'for', 'switch', 'case', 'try', 'catch', 'def', 'import', 'from', 'with', 'object', 'list', 'dictionary']
" Enable indentLine for all buffers except excluded filetypes
" autocmd BufEnter * if index(g:indentLine_FileTypeExclude, &filetype) < 0 | IndentLinesEnable | else | IndentLinesDisable | endif


" HighlightedYank - Highlight yanked text 
Plug 'machakann/vim-highlightedyank'

" Detects tabs vs spaces and indentation width from existing code
Plug 'tpope/vim-sleuth'
" Automatically sets:
" - expandtab/noexpandtab (tabs vs spaces)
" - tabstop, shiftwidth (indentation width)
" - Based on analysis of current buffer content

" Shows current context of the file on the top
" Interesting but annoying, it messes with conceallevel
Plug 'wellle/context.vim'
" To enable the context use `:ContextEnable` and `:ContextDisable` and
" `:ContextToggle`
let g:context_enabled = 0
let g:context_add_mappings = 0
let g:context_filetype_blacklist = ['markdown']

" BufferTabLine - Tab line with buffer tabs
Plug 'ap/vim-buftabline'
let g:buftabline_numbers = 1
let g:buftabline_indicators = v:true
" let g:buftabline_separators = v:true


"" Purify Color Scheme - Clean and minimal color scheme
Plug 'kyoz/purify', { 'rtp': 'vim' }

"" KDL Support
Plug 'imsnif/kdl.vim'


" }}}
" ===============================================================================
" FZF {{{
" ===============================================================================
if executable('fzf')
  Plug 'junegunn/fzf.vim'
  " Key mappings:
  Nmap 'list|Buffers|0' <leader>b :Buffers<CR>
  Nmap 'find|Files|0' <leader>f :Files<CR>
  Nmap 'in current dir|Files|0' <leader>fd :execute 'Files ' . expand('%:h')<CR>
  Nmap 'tracked files|Git|0' <leader>g :GFiles<CR>
  Nmap 'jumplist|Edit|1' <leader>j :Jumps<CR>
  Nmap 'lines in current buffer|Search|0' <leader>l :Lines<CR>
  Nmap 'lines in buffer with word under cursor|Search|0' <leader>lw :execute 'Lines ' . expand('<cword>')<CR>
  Nmap 'lines in buffer with line under cursor|Search|0' <leader>lL :execute  'Lines ' . getline('.')<CR>

  Nmap 'text with ripgrep|Search|0' <silent><leader>r :Rg<CR>
  Nmap 'text with word under cursor|Search|0' <silent><leader>rw :execute 'RG ' . expand('<cword>')<CR>
  Nmap 'text with line under cursor|Search|0' <silent><leader>rL :execute 'RG ' . getline('.')<CR>

  Nmap 'recent|Files|0' <leader>rf :History<CR>
  Nmap 'changes on buffers|Edit|1' <leader>cb :Changes<CR>

  Nmap 'commits|Git|0' <leader>gc :Commits<CR>
  Xmap 'commits affecting selection|Git|0' <leader>gc :Commits<CR>
  Nmap 'status|Git|0' <leader>gs :GFiles?<CR>
else
  echo "fzf is not installed, please install it to use fzf.vim"
endif

" }}}
" ===============================================================================
" Linting and Formatting {{{
" ===============================================================================

" Provides real-time linting and fixing
" Requires: Various linters/formatters installed for each language
Plug 'dense-analysis/ale'
" ALE Configuration (currently disabled in favor of LSP)
" Uncomment the following lines to enable ALE:
" let g:ale_disable_lsp = 1                           " Disable ALE's LSP features
let g:ale_set_signs = 1                             " Show signs in gutter
let g:ale_set_highlights = 1                        " Highlight problematic lines
let g:ale_virtualtext_cursor = 1                    " Show errors as virtual text
" highlight ALEError ctermbg=none cterm=underline     " Error highlighting style
" let g:ale_lint_on_save = 1                          " Lint when saving
" let g:ale_lint_on_insert_leave = 1                  " Lint when leaving insert mode
" let g:ale_lint_on_text_change = 'never'             " Don't lint while typing
" let g:ale_linters_explicit = 1                      " Only use configured linters
let g:ale_linters = {
    \ 'python': ['flake8', 'ruff'],
    \ 'rust': ['analyzer', 'cargo'],
    \ 'sh': ['shellcheck'],
\ }
let g:ale_fixers = {
    \ 'python': ['ruff_format', 'isort', 'black', 'ruff', 'add_blank_lines_for_python_control_statements', 'remove_trailing_lines', 'trim_whitespace'],
    \ 'rust': ['rustfmt'],
    \ 'go': ['gofmt'],
\ }

" let g:ale_set_balloons = 1                           " Show error messages in balloons
" let g:ale_python_auto_uv = v:true 
let g:ale_rust_cargo_use_clippy = 1                 " Use clippy for Rust
" let g:ale_rust_cargo_check_tests = 1                " Check test code
" let g:ale_rust_cargo_check_examples = 1             " Check example code
" let g:ale_warn_about_trailing_whitespace = 0        " Don't warn about whitespace
" let g:ale_lsp_show_message_severity = 'information' " Show all message levels
" let g:ale_echo_msg_format = '[%linter%] [%severity%:%code%] %s'
let g:ale_linter_aliases = {"Containerfile": "dockerfile"}
let g:ale_virtualtext_cursor = 'current'

" let g:ale_virtualtext_cursor = 0
let g:ale_echo_cursor = 1

let g:ale_python_black_executable = 'black'
let g:ale_python_black_options = '-l 80'
let g:ale_python_black_auto_uv = v:true
let g:ale_python_black_use_global = v:true
let g:ale_python_flake8_options = '--max-line-length=80'
let g:ale_python_flake8_auto_uv = v:true
let g:ale_python_flake8_use_global = v:true
let g:ale_python_isort_auto_uv = v:true
let g:ale_python_isort_use_global = v:true
let g:ale_python_isort_options = '--profile black'
let g:ale_python_ruff_format_auto_uv = v:true
let g:ale_python_ruff_format_use_global = v:true
let g:ale_python_ruff_format_options = '--line-length=80'
let g:ale_python_ruff_auto_uv = v:true
let g:ale_python_ruff_use_global = v:true
let g:ale_python_ruff_options = '--line-length=80'

Nmap 'Toggle ALE linting|Linter|2' <leader>at :ALEToggle<CR>
Nmap 'Fix current file|Linter|2' <leader>af :ALEFix<CR>

" }}}
" ===============================================================================
" Copilot {{{
" ===============================================================================
" Use :Copilot panel to open the copilot panel
Plug 'github/copilot.vim'
let g:copilot_enabled = 0
Imap 'Cycle next suggestion|Copilot' <M-\]>
Imap 'Cycle previous suggestion|Copilot' <M-\[>
Imap 'Request suggestion|Copilot' <M-\>
Imap 'Accept next word|Copilot' <M-Right>
Imap 'Accept next line|Copilot' <M-C-Right>
Imap 'Accept suggestion|Copilot' <Tab>


let g:claude_code_cli = '/home/rochacbruno/.claude/local/claude'
let g:claude_verbose = v:true
Plug 'rochacbruno/claude.vim', {'branch': 'CLI'}


" }}}
" ===============================================================================
" Multi-Cursor Editing {{{
" ===============================================================================
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" let g:VM_maps = {}
" let g:VM_maps['Find Under']         = '<C-d>'  " Replace default C-n
" let g:VM_maps['Find Subword Under'] = '<C-d>'  " Replace visual C-n

" n/N         - Next/previous occurrence
" [/]         - Next/previous cursor
" q           - Skip current and find next
" Q           - Remove current cursor
" \\A         - Select all occurrences
Nmap 'Select word under cursor / Add next occurrence|Edit Cursor|2' <C-n>
Xmap 'Add next occurrence|Edit Cursor' <C-n>
" Mouse support:
Nmap 'Add cursor with Ctrl+Click|Edit Cursor' <C-LeftMouse> <Plug>(VM-Mouse-Cursor)
Nmap 'Select word with Ctrl+Right|Edit Cursor' <C-RightMouse> <Plug>(VM-Mouse-Word)
Nmap 'Column selection|Edit Cursor' <M-C-RightMouse> <Plug>(VM-Mouse-Column)

" }}}
" ===============================================================================
" Git Integration {{{
" ===============================================================================

" Fugitive - Git commands in Vim
" Repository: https://github.com/tpope/vim-fugitive
" Commands: :Gstatus, :Gblame, :Gdiff, :Gread, :Gwrite, :Gmove, :Gremove, :Gcommit
" Comprehensive Git integration for Vim with full workflow support
Plug 'tpope/vim-fugitive'

" Rhubarb - GitHub integration for Fugitive 
" Repository: https://github.com/tpope/vim-rhubarb
" Required by Fugitive for :Gbrowse command to open files/commits on GitHub
Plug 'tpope/vim-rhubarb'
Nmap 'Open current line on GitHub|Git|2' <leader>gb :.Gbrowse<CR>

" Git Messenger - Show commit info under cursor
" Repository: https://github.com/rhysd/git-messenger.vim
" Shows git commit message, author, and date for line under cursor
Plug 'rhysd/git-messenger.vim'
let g:git_messenger_no_default_mappings = v:true
Nmap 'Show git commit info|Git|2' <leader>gm <Plug>(git-messenger)

" }}}
" ===============================================================================
" Code Commenting {{{
" ===============================================================================
Plug 'tpope/vim-commentary'

Nmap 'uncomment adjacent commented lines|Edit' gcu
Nmap 'comment|Edit|1' <C-/> <Plug>CommentaryLine
Imap 'comment|Edit' <C-/> <Esc><Plug>CommentaryLineA
Xmap 'comment|Edit' <C-/> <Plug>Commentarygv
Omap 'comment|Edit' <C-/> <Plug>Commentary

" the following mappings are for keyboards where Ctrl+/ is not possible
nnoremap <silent> <C-_> <Plug>CommentaryLine
inoremap <silent> <C-_> <Esc><Plug>CommentaryLineA
xnoremap <silent> <C-_> <Plug>Commentarygv
onoremap <silent> <C-_> <Plug>Commentary

" }}}
" ===============================================================================
" Undo Tree Visualization {{{
" ===============================================================================

" UndoTree - Visual undo history
" Repository: https://github.com/mbbill/undotree
" Visual undo history browser with branching support
" Navigate through complex undo/redo history with ease
" Plug 'mbbill/undotree'
" let g:undotree_WindowLayout = 2        " Vertical layout with diff window
" let g:undotree_ShortIndicators = 1     " Use short time indicators
" let g:undotree_SetFocusWhenToggle = 1  " Focus undo tree when opened
" Key mappings:
" :UndotreeToggle - Toggle undo tree window
" j/k             - Navigate through undo states
" <Enter>         - Revert to selected state

" Nmap 'Toggle UndoTree|Edit|2' <leader>u :UndotreeToggle<CR>


" }}}
" ===============================================================================
" Text Object Manipulation - Surround {{{
" ===============================================================================
" Surround - Manipulate surrounding characters
" Work with quotes, brackets, tags, and custom delimiters
" Manipulate surrounding characters like quotes, brackets, and tags
Plug 'tpope/vim-surround'

" Repeat - Repeat surround operations with dot
" Enables dot repetition for surround operations
Plug 'tpope/vim-repeat'

" Document Surround mappings without overriding them
Nmap 'Surround inner word (ysiw + delimiter)|Edit Surround' ysiw
Nmap 'Delete surrounding (ds + delimiter)|Edit Surround' ds
Nmap 'Change surrounding (cs + old + new)|Edit Surround' cs
Nmap 'Surround entire line (yss + delimiter)|Edit Surround' yss
Xmap 'Surround selection (S + delimiter)|Edit Surround' S

" }}}
" ===============================================================================
" Smart Number/Date Manipulation {{{
" ===============================================================================
" Extends Vim's native Ctrl-A/Ctrl-X functionality
" Handles dates, times, hex colors, Roman numerals, and more
" Supported formats: 2023-12-25, 12:30:45, #ff0000, XIV, etc.
Plug 'tpope/vim-speeddating'

" Document SpeedDating mappings without overriding them
Nmap 'Increment number/date under cursor|Edit' <C-a>
Nmap 'Decrement number/date under cursor|Edit' <C-x>

" }}}
" ===============================================================================
" Command Output Management {{{
" ===============================================================================
" Capture command output in interactive buffers for better workflow

Plug 'AndrewRadev/bufferize.vim'
" Usage examples:
" :Bufferize cargo watch  - Run cargo watch in buffer
" :Bufferize git log      - Show git log in buffer
" :Bufferize make test    - Run tests with output in buffer

" }}}
" ===============================================================================
" File System Operations {{{
" ===============================================================================
" Enhanced file and directory operations within Vim
" Provides Unix-like commands and automatic directory creation
Plug 'tpope/vim-eunuch'
" Commands: :Rename, :Move, :Delete, :Chmod, :SudoEdit, :SudoWrite

" Automatically creates parent directories when saving files
Plug 'pbrisbin/vim-mkdir'

" }}}
" ===============================================================================
" Scratch Buffer for Quick Notes {{{
" ===============================================================================
" Persistent scratch buffer for temporary notes and quick calculations
Plug 'mtth/scratch.vim'
let g:scratch_persistence_file = '~/.vim/scratch.md'  " Persist across sessions

" Document Scratch mappings without overriding them
Nmap 'Open scratch buffer in insert mode|Buffers' gs
Xmap 'Open scratch buffer with selection|Buffers' gs
" :Scratch    - Open scratch buffer in normal mode

" }}}
" ===============================================================================
" Visual Selection Window Management {{{
" ===============================================================================
" Create new windows based on visual selections for better code organization
" Useful for comparing code sections or focusing on specific parts
Plug 'wellle/visual-split.vim'

" Configure key mappings for visual splits
Nmap 'Resize window to selection|Windows' <C-w>gr :VSResize<CR>
Nmap 'Split right with selection|Windows' <C-w>gss :VSSplit<CR>
Nmap 'Split above with selection|Windows' <C-w>gsa :VSSplitAbove<CR>
Nmap 'Split below with selection|Windows' <C-w>gsb :VSSplitBelow<CR>
Xmap 'Resize window to selection|Windows' <C-w>gr :VSResize<CR>
Xmap 'Split right with selection|Windows' <C-w>gss :VSSplit<CR>
Xmap 'Split above with selection|Windows' <C-w>gsa :VSSplitAbove<CR>
Xmap 'Split below with selection|Windows' <C-w>gsb :VSSplitBelow<CR>

" }}}
" ===============================================================================
" Color Picker Integration {{{
" ===============================================================================

" Interactive color picker for web development and design work
" Provides system color picker integration within Vim
Plug 'KabbAmine/vCoolor.vim'

" Document vCoolor mappings without overriding them
Imap 'Open color picker|Edit Color' <M-c>
Nmap 'Open color picker|Edit Color' <M-w>

" }}}
" ===============================================================================
" Distraction-Free Writing Mode {{{
" ===============================================================================
" Clean, minimal writing environment for focused work
Plug 'junegunn/goyo.vim'

" Key mappings:
Nmap 'Toggle Goyo mode|Windows' <C-w>g :Goyo<CR>
Imap 'Toggle Goyo mode|Windows' <C-w>g <Esc>:Goyo<CR>

" }}}
" ===============================================================================
" Window Zoom Functionality {{{
" ===============================================================================
" Maximizes current window and restores previous layout
Plug 'dhruvasagar/vim-zoom'

" Document Vim Zoom mappings without overriding them
Nmap 'Toggle window zoom (maximize/restore)|Windows|3' <C-w>m

" }}}
" ===============================================================================
" Cutlass - Separate cut and delete {{{
" ===============================================================================
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
" Abolish - Smart substitution with case variants {{{
" ===============================================================================
" Handles multiple case variants in substitutions (Word/word/WORD)
Plug 'tpope/vim-abolish'

" }}}
" ===============================================================================
" Subversive - Substitute with yanked text {{{
" ===============================================================================
" Provides intuitive substitute operations using yanked content
Plug 'svermeulen/vim-subversive'

" Key mappings for substitute operations:
Nmap 'Substitute motion with yanked text|Edit Replace' s <plug>(SubversiveSubstitute)
Nmap 'Substitute current line with yanked text|Edit Replace' ss <plug>(SubversiveSubstituteLine)
Nmap 'Substitute to end of line with yanked text|Edit Replace' S <plug>(SubversiveSubstituteToEndOfLine)

" Prompted substitution mappings:
Nmap 'Substitute motion with prompted text|Edit Replace' <leader>s <plug>(SubversiveSubstituteRange)
Xmap 'Substitute motion with prompted text|Edit Replace' <leader>s <plug>(SubversiveSubstituteRange)
Nmap 'Substitute word across buffer with prompted text|Edit Replace' <leader>ss <plug>(SubversiveSubstituteWordRange)

" Case-aware substitution (uses Abolish):
Nmap 'Smart case substitute motion|Edit Replace' <leader><leader>s <plug>(SubversiveSubvertRange)
Xmap 'Smart case substitute motion|Edit Replace' <leader><leader>s <plug>(SubversiveSubvertRange)
Nmap 'Smart case substitute word across buffer|Edit Replace' <leader><leader>ss <plug>(SubversiveSubvertWordRange)

" }}}
" ===============================================================================
" Yoink - Enhanced yank/paste with history {{{
" ===============================================================================
" Provides yank history and better paste behavior
Plug 'svermeulen/vim-yoink'
let g:yoinkIncludeDeleteOperations = 1        " Include delete operations in history
let g:yoinkMaxItems = 20                      " Keep last 20 yank items
" Post-paste navigation with Ctrl+Shift:
Nmap 'Previous yank after paste|Edit Paste' <leader>n <plug>(YoinkPostPasteSwapBack)
Nmap 'Next yank after paste|Edit Paste' <leader>p <plug>(YoinkPostPasteSwapForward)

" Enhanced paste operations:
Nmap 'Paste with yoink history|Edit Paste' p <plug>(YoinkPaste_p)
Nmap 'Paste before with yoink history|Edit Paste' P <plug>(YoinkPaste_P)
Nmap 'Paste and move cursor|Edit Paste' gp <plug>(YoinkPaste_gp)
Nmap 'Paste before and move cursor|Edit Paste' gP <plug>(YoinkPaste_gP)

" Yank history navigation:
Nmap 'Previous item in yank history|Edit Paste' [y <plug>(YoinkRotateBack)
Nmap 'Next item in yank history|Edit Paste' ]y <plug>(YoinkRotateForward)

" Cursor position preservation:
Nmap 'Yank without moving cursor|Edit Paste' y <plug>(YoinkYankPreserveCursorPosition)
Xmap 'Yank selection without moving cursor|Edit Paste' y <plug>(YoinkYankPreserveCursorPosition)

" }}}
" ===============================================================================
" Multi-file find and replace {{{
" ===============================================================================
" Provides interactive find/replace with preview and confirmation
Plug 'brooth/far.vim'

" Usage workflow:
" :Far pattern replacement files_glob  - Find and preview replacements
" :Fardo                              - Apply all replacements
" :Farundo                            - Undo all replacements
" Example: :Far foo bar **/*.txt      - Replace 'foo' with 'bar' in all txt files

Plug 'yegappan/greplace'
" Populate the Vim quickfix list using one of the built-in Vim commands like :grep or :vimgrep or using the :Gsearch command or using a command provided by a plugin.
" Open the quickfix items in a buffer using the :Gqfopen command.
" Modify/edit the buffer using the regular Vim commands.
" Merge the changes back to the files using the :Greplace command.
" Save all the files using the ':bufdo update' command.


" }}}
" ===============================================================================
" Text objects {{{
" ===============================================================================
" Provides additional pair text objects and seeking behavior
Plug 'wellle/targets.vim'

" Document Targets text objects without overriding them
Omap 'Inside next comma-separated value|Text Objects' i,
Omap 'Around next parentheses|Text Objects' a)
Omap 'Inside next single quotes|Text Objects' i'

" Indent Object - Indentation-based text objects
" Work with indentation levels as text objects
Plug 'michaeljsmith/vim-indent-object'

" Document Indent Object text objects without overriding them
Omap 'Around indentation level|Text Objects' ai
Omap 'Inside indentation level|Text Objects' ii
Omap 'Around indentation level (including blank lines)|Text Objects' aI
Omap 'Inside indentation level (including blank lines)|Text Objects' iI

" Custom Text Objects
function! SelectEntireBuffer()
    normal! ggVG
endfunction

function! SelectViewableText()
    normal! HVL
endfunction

" Map for both operator-pending and visual modes
Map ox 'Inner entire buffer|Text Objects' ie :<C-U>call SelectEntireBuffer()<CR>
Map ox 'Current viewable text|Text Objects' iv :<C-U>call SelectViewableText()<CR>

" }}}
" ===============================================================================
" Bbye - Better buffer deletion {{{
" ===============================================================================
" Delete buffers without affecting window layout
Plug 'moll/vim-bbye'
" Key mappings:
Nmap 'Close buffer (save first)|Buffers|2' <leader>bc :Bdelete<CR>
Nmap 'Force close buffer (no save)|Buffers|2' <leader>bx :Bdelete!<CR>

" }}}
" ===============================================================================
" Over - Visual substitution preview {{{
" ===============================================================================
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
" ChooseWin - Interactive window selection {{{
" ===============================================================================
" Provides overlay interface for window operations
Plug 't9md/vim-choosewin'
let g:choosewin_overlay_enable = 1        " Show window markers as overlay
" Key mappings:
Nmap 'Open window chooser|Windows|3' - <Plug>(choosewin)
Nmap 'Swap Window|Windows|3' --s<ID>
Nmap 'Jump Windows|Windows|3' --  
Nmap 'Swap with previous window|Windows|3' --ss
" Operations in chooser:
" s      - Swap with selected window
" S      - Swap and stay in current window
" -      - Return to previous window
" -ss    - Swap with previous window

" }}}
" ===============================================================================
" VRC - Vim REST Console - HTTP client {{{
" ===============================================================================
" Execute HTTP requests with results in separate buffer
" Plug 'diepm/vim-rest-console'
Plug 'rochacbruno/vim-rest-console'
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
Nmap 'Execute HTTP request under cursor|REST' <C-j> 
Vmap 'Execute selected HTTP request|REST' <C-j>
Imap 'Execute HTTP request under cursor|REST' <C-j>

" }}}
" ===============================================================================
" Table Mode - Markdown table editing {{{
" ===============================================================================
" Repository: https://github.com/dhruvasagar/vim-table-mode
" Provides automatic table formatting and manipulation
Plug 'dhruvasagar/vim-table-mode'
" Key mappings:
" Document Table Mode mappings without overriding them
Nmap 'Toggle table mode|Edit Table' <leader>tm
" ||          - Start table or add column (table mode)
" |           - Add column separator (table mode)
" Features: Auto-alignment, row/column manipulation, table formatting

" }}}
" ===============================================================================
" Markdown Preview {{{
" ===============================================================================
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'rochacbruno/vim-markdown-composer', { 'do': function('BuildComposer'), 'branch': 'fix/bump-deps' }
let g:markdown_composer_autostart = 0         " Don't auto-start preview

" Commands:
" :ComposerStart  - Start live preview server
" :ComposerOpen   - Open preview in browser
Nmap 'Start markdown preview|Edit Markdown' <leader>mp :ComposerStart<CR>
Nmap 'Open markdown preview in browser|Edit Markdown' <leader>mo :ComposerOpen<CR>

" }}}
" ===============================================================================
" GTFO - Go to file manager or terminal {{{
" ===============================================================================
" Opens external applications in current file's directory
Plug 'justinmk/vim-gtfo'
let g:gtfo#terminals = { 'unix': 'kitty @ launch --cwd="%:p:h"' }  " Use Kitty terminal
" Key mappings:
" Document GTFO mappings without overriding them
Nmap 'Open terminal in current files directory|Files' got
Nmap 'Open file manager in current files directory|Files' gof

" }}}
"===============================================================================
" Custom Plugin Configurations {{{
" ===============================================================================
" source ~/.vim/custom.plugins.vim if exists.
if filereadable(expand("~/.vim/custom.plugins.vim"))
    source ~/.vim/custom.plugins.vim
endif
" }}}
"===============================================================================
" Plugin Configuration Complete {{{
" ===============================================================================
" End plugin declarations
call plug#end()
" }}}
" ===============================================================================
"
" vim: set foldmethod=marker foldlevel=0:
