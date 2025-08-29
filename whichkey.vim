" Whichkey plugin is loaded in the plugins.vim file
" this file configures the Whichkey screen and the options that it shows.

" ===============================================================================
" WhichKey Configuration
" ===============================================================================
" This file provides a comprehensive mapping guide for all leader and Ctrl-w keys
" showing descriptions for better discoverability
" ===============================================================================

" Initialize the main dictionaries
let g:which_key_map_leader = {}
let g:which_key_map_window = {}

" ===============================================================================
" Leader Key Mappings
" ===============================================================================

" Top Level
let g:which_key_map_leader['1'] = 'buffer-1 (1-9)'
for n in range(2, 9)
  let g:which_key_map_leader[string(n)] = 'which_key_ignore'
endfor

" File Operations
let g:which_key_map_leader['w'] = 'save-file'
let g:which_key_map_leader['q'] = 'quit'
let g:which_key_map_leader['x'] = 'write-and-quit'
let g:which_key_map_leader['h'] = 'clear-search-highlight'
let g:which_key_map_leader['c'] = 'open-terminal'

" File Explorer
let g:which_key_map_leader['e'] = 'open-explorer-left'
let g:which_key_map_leader['E'] = 'open-explorer-vsplit'

" Nested Groups

" Tab Management
let g:which_key_map_leader.t = {"name": "tabs/text"}
let g:which_key_map_leader.t['w'] = 'trim-whitespace'
let g:which_key_map_leader.t['n'] = 'new-tab'
let g:which_key_map_leader.t['o'] = 'close-other-tabs'
let g:which_key_map_leader.t['c'] = 'close-tab'
let g:which_key_map_leader.t['l'] = 'next-tab'
let g:which_key_map_leader.t['h'] = 'previous-tab'

" Buffer Management
let g:which_key_map_leader.b = {'name': '+buffers'}
let g:which_key_map_leader.b['l'] = 'list-buffers'
let g:which_key_map_leader.b['d'] = 'delete-buffer-keep-window'
let g:which_key_map_leader.b['x'] = 'force-delete-buffer'
let g:which_key_map_leader.b['h'] = 'delete-all-hidden-buffers'
let g:which_key_map_leader.b['<Tab>'] = 'alternate-buffer'


" Search and Files (FZF)
if executable('fzf')
  let g:which_key_map_leader.f = {'name': '+fzf'}
  let g:which_key_map_leader.f['l'] = 'search-lines-in-buffer'
  let g:which_key_map_leader.f['f'] = 'find-files'
  let g:which_key_map_leader.f['F'] = 'search-text-ripgrep'
  let g:which_key_map_leader.f['b'] = 'list-buffers-fzf'
  let g:which_key_map_leader.f['g'] = 'git-files'
endif
let g:which_key_map_leader.r = {'name': '+replace'}
let g:which_key_map_leader.r['e'] = 'replace-word-under-cursor'
let g:which_key_map_leader.r['s'] = 'resize-windows'


" LSP Operations
let g:which_key_map_leader['a'] = 'lsp-code-action'
let g:which_key_map_leader['d'] = 'lsp-goto-definition'
let g:which_key_map_leader['k'] = 'lsp-hover'

" ALE Operations (if enabled)
let g:which_key_map_leader['L'] = 'ale-fix'


" ===============================================================================
" Ctrl-W (Window) Mappings
" ===============================================================================

" Native Vim window commands

let g:which_key_map_window['s'] = 'split-horizontal'
let g:which_key_map_window['v'] = 'split-vertical'
let g:which_key_map_window['w'] = 'next-window'
let g:which_key_map_window['W'] = 'previous-window'
let g:which_key_map_window['h'] = 'window-left'
let g:which_key_map_window['j'] = 'window-down'
let g:which_key_map_window['k'] = 'window-up'
let g:which_key_map_window['l'] = 'window-right'
let g:which_key_map_window['H'] = 'move-window-left'
let g:which_key_map_window['J'] = 'move-window-down'
let g:which_key_map_window['K'] = 'move-window-up'
let g:which_key_map_window['L'] = 'move-window-right'
let g:which_key_map_window['c'] = 'close-window'
let g:which_key_map_window['o'] = 'close-other-windows'
let g:which_key_map_window['q'] = 'quit-window'
let g:which_key_map_window['='] = 'balance-windows'
let g:which_key_map_window['_'] = 'maximize-height'
let g:which_key_map_window['|'] = 'maximize-width'
let g:which_key_map_window['+'] = 'increase-height'
let g:which_key_map_window['-'] = 'decrease-height'
let g:which_key_map_window['<'] = 'decrease-width'
let g:which_key_map_window['>'] = 'increase-width'
let g:which_key_map_window['f'] = 'open-file-in-split'
let g:which_key_map_window['F'] = 'open-file-in-tab'
let g:which_key_map_window['n'] = 'new-window'
let g:which_key_map_window['r'] = 'rotate-windows'
let g:which_key_map_window['R'] = 'rotate-windows-backward'
let g:which_key_map_window['x'] = 'exchange-window'
let g:which_key_map_window['p'] = 'go-to-preview'
let g:which_key_map_window['P'] = 'go-to-preview-tag'
let g:which_key_map_window['z'] = 'close-preview'
let g:which_key_map_window['t'] = 'move-to-top'
let g:which_key_map_window['b'] = 'move-to-bottom'
let g:which_key_map_window[']'] = 'next-tag'
let g:which_key_map_window['T'] = 'move-to-new-tab'

" Visual Split extensions and Goyo
let g:which_key_map_window['g'] = {
      \ 'name': '+goyo/visual-split',
      \ 'g': 'toggle-goyo-mode',
      \ 'r': 'resize-to-selection',
      \ 's': {
        \ 'name': '+split-selection',
        \ 's': 'split-right-with-selection',
        \ 'a': 'split-above-with-selection',
        \ 'b': 'split-below-with-selection',
        \ },
      \ }

" Zoom window
let g:which_key_map_window['m'] = 'toggle-window-zoom'

" ===============================================================================
" Register the mappings with WhichKey
" ===============================================================================

" Register leader key mappings
call which_key#register(',', "g:which_key_map_leader")

" Register Ctrl-W mappings
" call which_key#register("\<c-w>", "g:which_key_map_window")

" ===============================================================================
" Additional mappings for non-leader keys (optional)
" ===============================================================================

" You can also map other prefixes if needed
" For example, for 'g' prefix:
" let g:which_key_map_g = {}
" call which_key#register('g', "g:which_key_map_g")
" nnoremap <silent> g :<c-u>WhichKey 'g'<CR>

