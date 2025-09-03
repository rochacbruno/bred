" ===============================================================================
" Neovim Native LSP Configuration
" ===============================================================================
" This file configures Neovim's built-in LSP client with the same servers
" that are configured in the Vim lsp.vim file
" ===============================================================================

" Only load if we have nvim-lspconfig
if !exists('g:loaded_lspconfig')
    " Plugin not loaded yet, defer configuration
    autocmd User lspconfig ++once source ~/.vim/nvim_compat/lsp.vim
    finish
endif

" ===============================================================================
" LSP Settings and Keymaps {{{
" ===============================================================================

" Use an on_attach function to only map the following keys
" after the language server attaches to the current buffer
function! LspOnAttach(client, bufnr) abort
    " Enable completion triggered by <c-x><c-o>
    setlocal omnifunc=v:lua.vim.lsp.omnifunc

    " Mappings (matching the Vim LSP keymaps)
    " Note: Using <cmd> for better performance in Neovim
    nnoremap <buffer> <leader>d <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> <leader>k <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <buffer> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <buffer> gr <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <buffer> <leader>f <cmd>lua vim.lsp.buf.format()<CR>
    
    " Diagnostic mappings
    nnoremap <buffer> [d <cmd>lua vim.diagnostic.goto_prev()<CR>
    nnoremap <buffer> ]d <cmd>lua vim.diagnostic.goto_next()<CR>
    nnoremap <buffer> <leader>q <cmd>lua vim.diagnostic.setloclist()<CR>
endfunction

" Configure diagnostics
lua << EOF
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Define diagnostic signs
local signs = { Error = "✗", Warn = "⚠", Hint = "💡", Info = "ℹ" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
EOF

" }}}

" ===============================================================================
" Language Server Configuration {{{
" ===============================================================================

lua << EOF
local lspconfig = require('lspconfig')

-- Common on_attach function
local on_attach = function(client, bufnr)
    vim.fn['LspOnAttach'](client, bufnr)
end

-- Common capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Try to enhance with nvim-cmp capabilities if available
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Python - pylsp (matching Vim config)
if vim.fn.executable('pylsp') == 1 then
    lspconfig.pylsp.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = { enabled = false },
                    mccabe = { enabled = false },
                    pyflakes = { enabled = true },
                    pylint = { enabled = false },
                    yapf = { enabled = false },
                    flake8 = { enabled = false },
                    autopep8 = { enabled = false }
                }
            }
        }
    }
end

-- TypeScript/JavaScript - tsserver
if vim.fn.executable('typescript-language-server') == 1 then
    lspconfig.tsserver.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
    }
end

-- Rust - rust-analyzer
if vim.fn.executable('rust-analyzer') == 1 then
    lspconfig.rust_analyzer.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
                cargo = {
                    allFeatures = true
                }
            }
        }
    }
end

-- Go - gopls
if vim.fn.executable('gopls') == 1 then
    lspconfig.gopls.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                staticcheck = true,
            }
        }
    }
end

-- Lua - lua_ls (for Neovim config)
if vim.fn.executable('lua-language-server') == 1 then
    lspconfig.lua_ls.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    }
end

-- Bash - bashls
if vim.fn.executable('bash-language-server') == 1 then
    lspconfig.bashls.setup{
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- HTML/CSS/JSON - vscode langservers
if vim.fn.executable('vscode-html-language-server') == 1 then
    lspconfig.html.setup{
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

if vim.fn.executable('vscode-css-language-server') == 1 then
    lspconfig.cssls.setup{
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

if vim.fn.executable('vscode-json-language-server') == 1 then
    lspconfig.jsonls.setup{
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- Vim - vimls
if vim.fn.executable('vim-language-server') == 1 then
    lspconfig.vimls.setup{
        on_attach = on_attach,
        capabilities = capabilities,
    }
end
EOF

" }}}

" ===============================================================================
" Auto-install notification {{{
" ===============================================================================

" Notify about language servers that need to be installed
function! s:CheckLspServers()
    let l:missing = []
    
    if !executable('pylsp')
        call add(l:missing, 'pylsp (pip install python-lsp-server)')
    endif
    if !executable('typescript-language-server')
        call add(l:missing, 'typescript-language-server (npm install -g typescript-language-server)')
    endif
    if !executable('rust-analyzer')
        call add(l:missing, 'rust-analyzer (rustup component add rust-analyzer)')
    endif
    if !executable('gopls')
        call add(l:missing, 'gopls (go install golang.org/x/tools/gopls@latest)')
    endif
    
    if len(l:missing) > 0
        echom "Note: Some LSP servers are not installed. To install:"
        for server in l:missing
            echom "  - " . server
        endfor
    endif
endfunction

" Check on startup
autocmd VimEnter * call s:CheckLspServers()

" }}}

" vim: set foldmethod=marker foldlevel=0:
