" =========================================================================
" Language Server Protocol (LSP) Configuration
" =========================================================================

" ---------------------------------------------------------------------------
" Global LSP Options Configuration
" ---------------------------------------------------------------------------
" This section configures the global behavior of LSP functionality across
" all language servers. These options control features like completion,
" diagnostics display, popup behavior, and various UI elements.
"
" LSP Option Descriptions:
" - aleSupport: Enable ALE (Asynchronous Lint Engine) integration
" - autoComplete: Enable automatic completion suggestions
" - autoHighlight: Disable automatic symbol highlighting under cursor
" - autoHighlightDiags: Enable automatic highlighting of diagnostics
" - autoPopulateDiags: Disable automatic population of location list with diagnostics
" - completionMatcher: Use case-sensitive completion matching
" - completionMatcherValue: Completion matcher sensitivity level
" - diagSignErrorText: Sign text for error diagnostics in sign column
" - diagSignHintText: Sign text for hint diagnostics in sign column
" - diagSignInfoText: Sign text for info diagnostics in sign column
" - diagSignWarningText: Sign text for warning diagnostics in sign column
" - echoSignature: Disable echoing function signatures in command line
" - hideDisabledCodeActions: Show all code actions, including disabled ones
" - highlightDiagInline: Enable inline highlighting of diagnostic text
" - hoverInPreview: Show hover information in current window, not preview
" - ignoreMissingServer: Show warnings when language servers are missing
" - keepFocusInDiags: Keep focus in diagnostics window when opened
" - keepFocusInReferences: Keep focus in references window when opened
" - completionTextEdit: Enable text edit completions for better insertion
" - diagVirtualTextAlign: Position virtual diagnostic text above the line
" - diagVirtualTextWrap: Use default wrapping for virtual diagnostic text
" - noNewlineInCompletion: Allow newlines in completion items
" - omniComplete: Use default omni-completion behavior
" - outlineOnRight: Show outline window on the left side
" - outlineWinSize: Set outline window width to 20 columns
" - popupBorder: Show borders around popup windows
" - popupBorderHighlight: Highlight group for popup borders
" - popupBorderHighlightPeek: Highlight group for peek popup borders
" - popupBorderSignatureHelp: Disable borders for signature help popups
" - popupHighlightSignatureHelp: Highlight group for signature help popups
" - popupHighlight: Highlight group for general popups
" - semanticHighlight: Enable semantic syntax highlighting from LSP
" - showDiagInBalloon: Show diagnostics in balloon (tooltip) when hovering
" - showDiagInPopup: Show diagnostics in popup windows
" - showDiagOnStatusLine: Don't show diagnostics on the status line
" - showDiagWithSign: Show diagnostic signs in the sign column
" - showDiagWithVirtualText: Don't show diagnostics as virtual text
" - showInlayHints: Disable inlay hints display
" - showSignature: Show function signature help
" - snippetSupport: Disable snippet expansion support
" - ultisnipsSupport: Disable UltiSnips integration
" - useBufferCompletion: Don't use buffer-based completion fallback
" - usePopupInCodeAction: Use location list instead of popup for code actions
" - useQuickfixForLocations: Use location list instead of quickfix for locations
" - vsnipSupport: Disable vim-vsnip integration
" - bufferCompletionTimeout: Timeout for buffer completion in milliseconds
" - customCompletionKinds: Use default completion kind icons
" - completionKinds: Custom completion kind mappings (empty = use defaults)
" - filterCompletionDuplicates: Don't filter duplicate completion items
" - condensedCompletionMenu: Use standard completion menu layout

call LspOptionsSet({
        \   'aleSupport': v:true,
        \   'autoComplete': v:true,
        \   'autoHighlight': v:false,
        \   'autoHighlightDiags': v:true,
        \   'autoPopulateDiags': v:false,
        \   'completionMatcher': 'case',
        \   'completionMatcherValue': 1,
        \   'diagSignErrorText': 'E>',
        \   'diagSignHintText': 'H>',
        \   'diagSignInfoText': 'I>',
        \   'diagSignWarningText': 'W>',
        \   'echoSignature': v:false,
        \   'hideDisabledCodeActions': v:false,
        \   'highlightDiagInline': v:true,
        \   'hoverInPreview': v:false,
        \   'ignoreMissingServer': v:false,
        \   'keepFocusInDiags': v:true,
        \   'keepFocusInReferences': v:true,
        \   'completionTextEdit': v:true,
        \   'diagVirtualTextAlign': 'above',
        \   'diagVirtualTextWrap': 'default',
        \   'noNewlineInCompletion': v:false,
        \   'omniComplete': v:null,
        \   'outlineOnRight': v:false,
        \   'outlineWinSize': 20,
        \   'popupBorder': v:true,
        \   'popupBorderHighlight': 'Title',
        \   'popupBorderHighlightPeek': 'Special',
        \   'popupBorderSignatureHelp': v:false,
        \   'popupHighlightSignatureHelp': 'Pmenu',
        \   'popupHighlight': 'Normal',
        \   'semanticHighlight': v:true,
        \   'showDiagInBalloon': v:true,
        \   'showDiagInPopup': v:true,
        \   'showDiagOnStatusLine': v:false,
        \   'showDiagWithSign': v:true,
        \   'showDiagWithVirtualText': v:false,
        \   'showInlayHints': v:false,
        \   'showSignature': v:true,
        \   'snippetSupport': v:false,
        \   'ultisnipsSupport': v:false,
        \   'useBufferCompletion': v:false,
        \   'usePopupInCodeAction': v:false,
        \   'useQuickfixForLocations': v:false,
        \   'vsnipSupport': v:false,
        \   'bufferCompletionTimeout': 100,
        \   'customCompletionKinds': v:false,
        \   'completionKinds': {},
        \   'filterCompletionDuplicates': v:false,
        \   'condensedCompletionMenu': v:false,
        \ })



" ---------------------------------------------------------------------------
" Language Server Configurations
" ---------------------------------------------------------------------------
" This section configures individual language servers for specific file types.
" Each server requires the executable to be installed and available in PATH
" or at the specified absolute path.

" ---------------------------------------------------------------------------
" Rust Language Server (rust-analyzer)
" ---------------------------------------------------------------------------
" Requirements: Install rust-analyzer via rustup or system package manager
"   - Arch Linux: pacman -S rust-analyzer
"   - Via rustup: rustup component add rust-analyzer
" Features: Code completion, diagnostics, goto definition, inlay hints
if executable('/usr/lib/rustup/bin/rust-analyzer')
    call LspAddServer([{
	\    'name': 'rustlang',
	\    'filetype': ['rust'],
	\    'path': '/usr/lib/rustup/bin/rust-analyzer',
	\    'args': [],
	\    'syncInit': v:true,
    \  'initializationOptions': {
    \    'inlayHints': {
    \      'typeHints': {
    \        'enable': v:true
    \      },
    \      'parameterHints': {
    \        'enable': v:true
    \      }
    \    },
    \  }
	\  }])
else
    call Alert("Rust language server not found. Please install rust-analyzer.")
endif

" ---------------------------------------------------------------------------
" Bash Language Server
" ---------------------------------------------------------------------------
" Requirements: Install bash-language-server via npm or system package
"   - Via npm: npm install -g bash-language-server
"   - Arch Linux: pacman -S bash-language-server
" Features: Syntax checking, completion, hover information for shell scripts
if executable('/usr/bin/bash-language-server')
    call LspAddServer([{'name': 'bashls',
                 \   'filetype': 'sh',
                 \   'path': '/usr/bin/bash-language-server',
                 \   'args': ['start']
                 \ }])
else
    call Alert("Bash language server not found. Please install bash-language-server.")
endif

" ---------------------------------------------------------------------------
" Doc-LSP Language Server (Python Documentation)
" ---------------------------------------------------------------------------
" Requirements: Install doc-lsp from source or pip
"   - Custom LSP server for Python documentation assistance
" Features: Documentation completion and suggestions for Python
if executable('/home/rochacbruno/.local/bin/doc-lsp1')
    call LspAddServer([{
        \   'name': 'doc-lsp',
        \   'filetype': 'python',
        \   'path': '/home/rochacbruno/.local/bin/doc-lsp'
        \ }])
else
   call Alert('Doc-LSP language server not found. Please install Doc LSP')
endif

" ---------------------------------------------------------------------------
" Pyright Language Server (Python)
" ---------------------------------------------------------------------------
" Requirements: Install pyright via npm or system package
"   - Via npm: npm install -g pyright
"   - Arch Linux: pacman -S pyright
" Features: Type checking, completion, diagnostics, refactoring for Python
if executable('/usr/bin/pyright-langserver')
    call LspAddServer([{'name': 'pyright',
                 \   'filetype': 'python',
                 \   'path': '/usr/bin/pyright-langserver',
                 \   'args': ['--stdio'],
                 \   'workspaceConfig': {
                 \     'python': {
                 \       'pythonPath': '.venv/bin/python'
                 \   }}
                 \ }])
else
    call Alert("Pyright language server not found. Please install pyright.")
endif

" ---------------------------------------------------------------------------
" YAML Language Server
" ---------------------------------------------------------------------------
" Requirements: Install yaml-language-server via npm or system package
"   - Via npm: npm install -g yaml-language-server
"   - Arch Linux: yay -S yaml-language-server-bin
" Features: YAML validation, completion, schema support
if executable('/usr/bin/yaml-language-server')
    call LspAddServer([{
            \   'name': 'yaml-language-server',
            \   'filetype': 'yaml',
            \   'path': '/usr/bin/yaml-language-server',
            \   'args': ['--stdio'],
            \   'workspaceConfig': {
            \       'yaml': {
            \           'schemas': {
            \               "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" : [
            \                   "**/*docker-compose*.yaml"
            \               ],
            \              "https://json.schemastore.org/chart.json": [
            \                   "**helm/values*.yaml"
            \               ]
            \           }
            \       }
            \   }
            \ }])
else
    call Alert("YAML language server not found. Please install yaml-language-server.")
endif

" ---------------------------------------------------------------------------
" TOML Language Server (Tombi)
" ---------------------------------------------------------------------------
" Requirements: Install tombi from source or binary release
"   - GitHub: https://github.com/2nthony/tombi
" Features: TOML syntax validation, completion, formatting
if executable('/home/rochacbruno/.local/bin/tombi')
    call LspAddServer([{'name': 'tombi',
        \   'filetype': 'toml',
        \   'args': ['lsp'],
        \   'path': '/home/rochacbruno/.local/bin/tombi'
        \ }])
else
    call Alert("TOML language server not found. Please install tombi.")
endif

" ---------------------------------------------------------------------------
" Custom LSP Configuration Extension
" ---------------------------------------------------------------------------
" This section allows for additional custom LSP server configurations
" to be loaded from an external file, enabling user-specific or project-specific
" language server setups without modifying this main configuration file.

" TODO: Check if a custom.lsp.vim exists and then source it here
" Implementation idea:
"   if filereadable(expand('~/.vim/custom.lsp.vim'))
"       source ~/.vim/custom.lsp.vim
"   endif
