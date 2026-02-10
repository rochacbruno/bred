" ===============================================================================
" Go Development - vim-go {{{
" ===============================================================================
" Repository: https://github.com/fatih/vim-go
" Provides Go tooling: build, test, debug, coverage, formatting, imports
" Debugger uses Delve (dlv) - install with: go install github.com/go-delve/delve/cmd/dlv@latest
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Disable vim-go LSP features (already handled by gopls in lsp.vim)
let g:go_gopls_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_diagnostics_enabled = 0
let g:go_echo_go_info = 0
let g:go_code_completion_enabled = 0

" Disable vim-go fmt on save (already handled by ALE)
let g:go_fmt_autosave = 0
let g:go_imports_autosave = 0

" Enable syntax highlighting extras
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1

" Debugger configuration
let g:go_debug_windows = {
    \ 'vars':       'leftabove 30vnew',
    \ 'stack':      'leftabove 20new',
    \ 'goroutines': 'botright 10new',
    \ 'out':        'botright 5new',
\ }

" }}}
" ===============================================================================

" vim: set foldmethod=marker foldlevel=0:
