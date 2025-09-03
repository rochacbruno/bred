" ===============================================================================
" Base Plugin Configuration - Compatible with  Neovim
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
runtime! plugin/netrwPlugin.vim          " Load netrw plugin
Nmap 'Open explorer on left|Files|1' <leader>e :Lexplore<CR>
Nmap 'Open explorer in vertical split|Files' <leader>E :Vexplore<CR>

" }}}
" ===============================================================================
" ###############################################################################
" Vim-Plug Managed Plugins
" ###############################################################################
" Vim-Plug Installation and Setup {{{
" Auto-install vim-plug if not present
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
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

" Neovim uses pure Lua statusline
Plug 'bluz71/nvim-linefly'

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
" Disable markdown rendering that conflicts with other features
let g:indentLine_fileTypeExclude = ['markdown', 'md']

" }}}
" ===============================================================================
" Text Editing Enhancements {{{
" ===============================================================================

" Vim Surround - Manipulate surrounding characters
" cs"' - change surrounding " to '
" ds" - delete surrounding "
" ysiw" - surround word with "
Plug 'tpope/vim-surround'

" Vim Commentary - Toggle comments
" gcc - comment line, gc{motion} - comment motion
Plug 'tpope/vim-commentary'
Nmap 'Toggle comment for line|Edit' gcc
Vmap 'Toggle comment for selection|Edit' gc

" Vim Repeat - Enable repeat (.) for plugin commands
Plug 'tpope/vim-repeat'

" Vim Abolish - Case-smart substitution and abbreviation
" :%S/facility/building/ - smart case substitution
" crs - snake_case, crm - MixedCase, crc - camelCase, cru - UPPER_CASE
Plug 'tpope/vim-abolish'
Nmap 'Convert to snake_case|Text' crs
Nmap 'Convert to MixedCase|Text' crm
Nmap 'Convert to camelCase|Text' crc
Nmap 'Convert to UPPER_CASE|Text' cru

" Vim Unimpaired - Paired mappings
" [b ]b - prev/next buffer, [q ]q - prev/next quickfix
" [<Space> ]<Space> - add blank lines above/below
Plug 'tpope/vim-unimpaired'
Nmap 'Previous buffer|Navigation' [b
Nmap 'Next buffer|Navigation' ]b
Nmap 'Previous quickfix item|Navigation' [q
Nmap 'Next quickfix item|Navigation' ]q

" }}}
" ===============================================================================
" Navigation and Search {{{
" ===============================================================================

" FZF - Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Nmap 'Search files|Search|1' <leader>f :Files<CR>
Nmap 'Search in files (ripgrep)|Search' <leader>r :Rg<CR>
Nmap 'Search buffers|Search' <leader>b :Buffers<CR>
Nmap 'Search lines in buffer|Search' <leader>l :Lines<CR>
Nmap 'Search Git files|Search' <leader>g :GFiles<CR>
Nmap 'Search Git commits|Search' <leader>c :Commits<CR>
Nmap 'Search help tags|Search' <leader>h :Helptags<CR>
Nmap 'Search marks|Search' <leader>m :Marks<CR>
Nmap 'Search registers|Search' <leader>" :Registers<CR>

" EasyMotion - Fast navigation
" <leader><leader>w - word motion, <leader><leader>f - find character
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <leader><leader> <Plug>(easymotion-prefix)
nmap <leader><leader>w <Plug>(easymotion-w)
nmap <leader><leader>b <Plug>(easymotion-b)
nmap <leader><leader>f <Plug>(easymotion-f)
nmap <leader><leader>F <Plug>(easymotion-F)
nmap <leader><leader>j <Plug>(easymotion-j)
nmap <leader><leader>k <Plug>(easymotion-k)
Nmap 'EasyMotion word forward|Navigation' <leader><leader>w
Nmap 'EasyMotion word backward|Navigation' <leader><leader>b
Nmap 'EasyMotion find char forward|Navigation' <leader><leader>f
Nmap 'EasyMotion find char backward|Navigation' <leader><leader>F

" Vim Expand Region - Expand visual selection
" + to expand, _ to shrink
Plug 'terryma/vim-expand-region'
vmap + <Plug>(expand_region_expand)
vmap _ <Plug>(expand_region_shrink)
Vmap 'Expand selection|Selection' +
Vmap 'Shrink selection|Selection' _

" }}}
" ===============================================================================
" Multi-cursor Support {{{
" ===============================================================================

" Vim Multiple Cursors - Multiple cursor editing
" C-n - select next occurrence, C-p - prev, C-x - skip
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<C-n>'
let g:VM_maps['Find Subword Under'] = '<C-n>'
let g:VM_maps["Select All"] = '<C-A>'
let g:VM_maps["Add Cursor Down"] = '<M-Down>'
let g:VM_maps["Add Cursor Up"] = '<M-Up>'
Nmap 'Select word and find next|Multi-cursor' <C-n>
Vmap 'Select and find next|Multi-cursor' <C-n>
Nmap 'Select all occurrences|Multi-cursor' <C-A>

" }}}
" GTFO - Go to file manager or terminal {{{
" got - open terminal, gof - open file manager
Plug 'justinmk/vim-gtfo'
let g:gtfo#terminals = { 'unix': 'kitty @ launch --cwd="%:p:h"' }  " Use Kitty terminal
Nmap 'Open file manager in current directory|Files' gof
Nmap 'Open terminal in current files directory|Files' got
" }}}

" }}}
" ===============================================================================
" Git Integration {{{
" ===============================================================================

" Vim Fugitive - Git integration
" :Git status, :Git diff, :Git blame, etc.
Plug 'tpope/vim-fugitive'
Nmap 'Git status|Git' <leader>gs :Git status<CR>
Nmap 'Git diff|Git' <leader>gd :Git diff<CR>
Nmap 'Git blame|Git' <leader>gb :Git blame<CR>
Nmap 'Git log|Git' <leader>gl :Git log --oneline<CR>

" }}}
" ===============================================================================
" AI Assistance {{{
" ===============================================================================

" GitHub Copilot - AI pair programming
Plug 'github/copilot.vim'
" Copilot mappings are handled by the plugin itself
" Tab to accept suggestion, M-] next, M-[ previous
Imap 'Accept Copilot suggestion|AI' <Tab>
Imap 'Next Copilot suggestion|AI' <M-]>
Imap 'Previous Copilot suggestion|AI' <M-[>

" }}}
" ===============================================================================
" Markdown Support {{{
" ===============================================================================

" Vim Markdown - Enhanced markdown support
Plug 'preservim/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" Markdown Preview - Preview markdown in browser
" :MarkdownPreview to start, :MarkdownPreviewStop to stop
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install', 'for': 'markdown' }
Nmap 'Preview markdown in browser|Markdown' <leader>mp :MarkdownPreview<CR>
Nmap 'Stop markdown preview|Markdown' <leader>ms :MarkdownPreviewStop<CR>

" }}}
" ===============================================================================

" nvim-lspconfig for native LSP support
Plug 'neovim/nvim-lspconfig'

" End plugin declarations
call plug#end()

" ===============================================================================
" Post-Plugin Loading Configuration {{{
" ===============================================================================

" Load plugin help tags
silent! helptags ALL

" }}}

" ===============================================================================
" Native Neovim LSP Configuration {{{
" ===============================================================================
" Configure Neovim's built-in LSP after plugins are loaded

" Load native LSP configuration after plugins are loaded
autocmd VimEnter * ++once call timer_start(100, {-> execute('source ~/.vim/nvim_compat/lsp.vim')})

" Key mappings documentation (will be set per-buffer when LSP attaches)
Nmap 'Show code actions|LSP' <leader>a
Nmap 'Go to definition|LSP' <leader>d
Nmap 'Show hover information|LSP' <leader>k
Nmap 'Rename symbol|LSP' <leader>rn
Nmap 'Find references|LSP' gr
Nmap 'Format code|LSP' <leader>f
Nmap 'Previous diagnostic|LSP' [d
Nmap 'Next diagnostic|LSP' ]d
Nmap 'Show diagnostics list|LSP' <leader>q

" }}}

" ===============================================================================
" Neovim-specific Settings for Plugins {{{
" ===============================================================================

" GitGutter works better with Neovim's async
if exists('g:loaded_gitgutter')
    let g:gitgutter_async = 1
endif

" Better performance settings for Neovim
set updatetime=300
set timeoutlen=500

" }}}
" vim: set foldmethod=marker foldlevel=0:
