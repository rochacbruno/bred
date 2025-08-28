" LSP configuration for Vim
" This config is a WIP and may be incomplete

call LspOptionsSet(#{
        \   aleSupport: v:true,
        \   autoComplete: v:true,
        \   autoHighlight: v:false,
        \   autoHighlightDiags: v:true,
        \   autoPopulateDiags: v:false,
        \   completionMatcher: 'case',
        \   completionMatcherValue: 1,
        \   diagSignErrorText: 'E>',
        \   diagSignHintText: 'H>',
        \   diagSignInfoText: 'I>',
        \   diagSignWarningText: 'W>',
        \   echoSignature: v:false,
        \   hideDisabledCodeActions: v:false,
        \   highlightDiagInline: v:true,
        \   hoverInPreview: v:false,
        \   ignoreMissingServer: v:false,
        \   keepFocusInDiags: v:true,
        \   keepFocusInReferences: v:true,
        \   completionTextEdit: v:true,
        \   diagVirtualTextAlign: 'above',
        \   diagVirtualTextWrap: 'default',
        \   noNewlineInCompletion: v:false,
        \   omniComplete: v:null,
        \   outlineOnRight: v:false,
        \   outlineWinSize: 20,
        \   popupBorder: v:true,
        \   popupBorderHighlight: 'Title',
        \   popupBorderHighlightPeek: 'Special',
        \   popupBorderSignatureHelp: v:false,
        \   popupHighlightSignatureHelp: 'Pmenu',
        \   popupHighlight: 'Normal',
        \   semanticHighlight: v:true,
        \   showDiagInBalloon: v:true,
        \   showDiagInPopup: v:true,
        \   showDiagOnStatusLine: v:false,
        \   showDiagWithSign: v:true,
        \   showDiagWithVirtualText: v:false,
        \   showInlayHints: v:false,
        \   showSignature: v:true,
        \   snippetSupport: v:false,
        \   ultisnipsSupport: v:false,
        \   useBufferCompletion: v:false,
        \   usePopupInCodeAction: v:false,
        \   useQuickfixForLocations: v:false,
        \   vsnipSupport: v:false,
        \   bufferCompletionTimeout: 100,
        \   customCompletionKinds: v:false,
        \   completionKinds: {},
        \   filterCompletionDuplicates: v:false,
        \   condensedCompletionMenu: v:false,
	\ })



" Rust language server
if executable('/usr/lib/rustup/bin/rust-analyzer')
    call LspAddServer([#{
	\    name: 'rustlang',
	\    filetype: ['rust'],
	\    path: '/usr/lib/rustup/bin/rust-analyzer',
	\    args: [],
	\    syncInit: v:true,
    \  initializationOptions: #{
    \    inlayHints: #{
    \      typeHints: #{
    \        enable: v:true
    \      },
    \      parameterHints: #{
    \        enable: v:true
    \      }
    \    },
    \  }
	\  }])
else
    call Alert("Rust language server not found. Please install rust-analyzer.")
endif


" Bash
if executable('/usr/bin/bash-language-server')
    call LspAddServer([#{name: 'bashls',
                 \   filetype: 'sh',
                 \   path: '/usr/bin/bash-language-server',
                 \   args: ['start']
                 \ }])
else
    call Alert("Bash language server not found. Please install bash-language-server.")
endif

" DOC language server
if executable('/home/rochacbruno/.local/bin/doc-lsp1')
    call LspAddServer([#{
        \   name: 'doc-lsp',
        \   filetype: 'python',
        \   path: '/home/rochacbruno/.local/bin/doc-lsp'
        \ }])
else
   call Alert('Doc-LSP language server not found. Please install Doc LSP')
endif

if executable('/usr/bin/pyright-langserver') 
    call LspAddServer([#{name: 'pyright',
                 \   filetype: 'python',
                 \   path: '/usr/bin/pyright-langserver',
                 \   args: ['--stdio'],
                 \   workspaceConfig: #{
                 \     python: #{
                 \       pythonPath: '.venv/bin/python'
                 \   }}
                 \ }])
else
    call Alert("Pyright language server not found. Please install pyright.")
endif


if executable('/usr/bin/yaml-language-server')
    call LspAddServer([#{
            \   name: 'yaml-language-server',
            \   filetype: 'yaml',
            \   path: '/usr/bin/yaml-language-server',
            \   args: ['--stdio'],
            \   workspaceConfig: #{
            \       yaml: #{
            \           schemas: {
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


" TOML language server
if executable('/home/rochacbruno/.local/bin/tombi')
    call LspAddServer([#{name: 'tombi',
        \   filetype: 'toml',
        \   args: ['lsp'],
        \   path: '/home/rochacbruno/.local/bin/tombi'
        \ }])
else
    call Alert("TOML language server not found. Please install tombi.")
endif


" TODO: Check if a custom.lsp.vim exists and then source it here
