" ==========================
" MapDocs - classic Vimscript  
" ==========================
" 
" Usage:
"   Nmap 'description|category' <lhs> <rhs>  - Create mapping with documentation
"   Nmap 'description|category' <lhs>        - Document existing mapping only
"   
" The second form (without <rhs>) allows documenting built-in Vim mappings
" or plugin-provided mappings without overriding them.

" Initialize global dictionaries
if !exists("g:mapdocs")
    let g:mapdocs = {}
endif

if !exists("g:mapdocs_created")
    let g:mapdocs_created = {}
endif

" Clear any existing mapdocs when sourcing
let g:mapdocs = {}
let g:mapdocs_created = {}

" Parse documentation string (description|category)
function! s:ParseDocString(docstr) abort
    " Remove surrounding quotes if present
    let l:str = a:docstr
    if l:str =~ "^['\"].*['\"]$"
        let l:str = l:str[1:-2]
    endif
    
    " Split by | to get description and optional category
    let l:parts = split(l:str, '|')
    let l:desc = trim(get(l:parts, 0, ''))
    let l:category = trim(get(l:parts, 1, ''))
    return [l:desc, l:category]
endfunction

" Enhanced mapping commands with built-in documentation
" Syntax: Nmap 'description|category' <lhs> <rhs>
command! -nargs=+ Nmap call s:CreateMapping('n', <q-args>)
command! -nargs=+ Imap call s:CreateMapping('i', <q-args>)
command! -nargs=+ Vmap call s:CreateMapping('v', <q-args>)
command! -nargs=+ Xmap call s:CreateMapping('x', <q-args>)
command! -nargs=+ Omap call s:CreateMapping('o', <q-args>)
command! -nargs=+ Cmap call s:CreateMapping('c', <q-args>)

" Create mapping with documentation
function! s:CreateMapping(mode, args) abort
    " Parse the arguments - need to handle quoted strings properly
    " Expected format: 'description|category' <lhs> [<rhs>]
    " If <rhs> is omitted, only documentation is added (no mapping created)
    
    " Find the first quoted string
    let l:match = matchlist(a:args, "^\\s*\\(['\"]\\)\\(.\\{-\\}\\)\\1\\s*\\(\\S\\+\\)\\s*\\(.*\\)$")
    
    if empty(l:match)
        echoerr "Usage: " . toupper(a:mode) . "map 'description|category' <lhs> [<rhs>]"
        return
    endif
    
    let l:docstr = l:match[2]  " The content between quotes
    let l:lhs = l:match[3]      " The mapping key
    let l:rhs = l:match[4]      " The command to execute (optional)
    
    " Parse documentation
    let [l:desc, l:category] = s:ParseDocString(l:docstr)
    
    if l:desc == ''
        echoerr "Description cannot be empty"
        return
    endif
    
    " Track whether we created a mapping or just documented an existing one
    if !exists("g:mapdocs_created")
        let g:mapdocs_created = {}
    endif
    if !has_key(g:mapdocs_created, a:mode)
        let g:mapdocs_created[a:mode] = []
    endif
    
    " Only create the mapping if RHS is provided
    if l:rhs != ''
        execute a:mode . 'noremap ' . l:lhs . ' ' . l:rhs
        " Track that we created this mapping
        call add(g:mapdocs_created[a:mode], l:lhs)
    endif
    
    " Store documentation (always, whether or not we created a mapping)
    if !has_key(g:mapdocs, a:mode)
        let g:mapdocs[a:mode] = {}
    endif
    
    if l:category == ''
        " No category - store at top level
        let g:mapdocs[a:mode][l:lhs] = l:desc
    else
        " With category
        if !has_key(g:mapdocs[a:mode], l:category)
            let g:mapdocs[a:mode][l:category] = {}
        endif
        let g:mapdocs[a:mode][l:category][l:lhs] = l:desc
    endif
endfunction

" Build FZF source list from mapdocs
function! s:BuildFZFSource() abort
    let l:leader = get(g:, 'mapleader', '\')
    let l:uncategorized = []
    let l:categorized = []
    
    " Iterate through all modes
    for [l:mode, l:mode_data] in items(g:mapdocs)
        let l:mode_display = s:GetModeShort(l:mode)
        
        " Collect top-level mappings (uncategorized)
        for [l:key, l:desc] in items(l:mode_data)
            if type(l:desc) == type('')
                " Format: [mode] key : description
                let l:display_key = substitute(l:key, '<leader>', l:leader, 'g')
                let l:line = printf("[%s] %-15s : %s", l:mode_display, l:display_key, l:desc)
                " Store with description for sorting
                call add(l:uncategorized, {'line': l:line . '|' . l:mode . '|' . l:key, 'desc': l:desc})
            endif
        endfor
        
        " Collect categorized mappings
        for [l:category, l:cat_data] in items(l:mode_data)
            if type(l:cat_data) == type({})
                for [l:key, l:desc] in items(l:cat_data)
                    let l:display_key = substitute(l:key, '<leader>', l:leader, 'g')
                    " Include category in display
                    let l:line = printf("[%s] %-15s : [%s] %s", l:mode_display, l:display_key, l:category, l:desc)
                    " Store with category and description for sorting
                    call add(l:categorized, {
                        \ 'line': l:line . '|' . l:mode . '|' . l:key,
                        \ 'category': l:category,
                        \ 'desc': l:desc
                    \ })
                endfor
            endif
        endfor
    endfor
    
    " Sort uncategorized alphabetically by description
    call sort(l:uncategorized, {a, b -> a.desc < b.desc ? -1 : a.desc > b.desc ? 1 : 0})
    
    " Sort categorized first by category, then by description
    call sort(l:categorized, {a, b -> 
        \ a.category != b.category ? 
        \ (a.category < b.category ? -1 : 1) :
        \ (a.desc < b.desc ? -1 : a.desc > b.desc ? 1 : 0)
    \ })
    
    " Build final source list: uncategorized first, then categorized
    let l:source = []
    
    " Add uncategorized items
    for l:item in l:uncategorized
        call add(l:source, l:item.line)
    endfor
    
    " Add separator if we have both types
    if !empty(l:uncategorized) && !empty(l:categorized)
        " Add a visual separator (this will be filtered out in selection)
        call add(l:source, '─────────────────────────────────────────────────|separator|separator')
    endif
    
    " Add categorized items
    for l:item in l:categorized
        call add(l:source, l:item.line)
    endfor
    
    return l:source
endfunction

" Convert key notation to executable key sequence
function! s:ConvertKeyNotation(key) abort
    " For sequences with special keys, convert notation to escape sequences
    let l:key_seq = a:key
    
    " Replace special key notations with their escape sequences
    " Using double backslash to properly escape in the string
    let l:key_seq = substitute(l:key_seq, '<C-w>', '\\<C-w>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-r>', '\\<C-r>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-a>', '\\<C-a>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-b>', '\\<C-b>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-c>', '\\<C-c>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-d>', '\\<C-d>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-e>', '\\<C-e>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-f>', '\\<C-f>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-g>', '\\<C-g>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-h>', '\\<C-h>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-i>', '\\<C-i>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-j>', '\\<C-j>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-k>', '\\<C-k>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-l>', '\\<C-l>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-m>', '\\<C-m>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-n>', '\\<C-n>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-o>', '\\<C-o>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-p>', '\\<C-p>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-q>', '\\<C-q>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-s>', '\\<C-s>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-t>', '\\<C-t>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-u>', '\\<C-u>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-v>', '\\<C-v>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-x>', '\\<C-x>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-y>', '\\<C-y>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-z>', '\\<C-z>', 'g')
    let l:key_seq = substitute(l:key_seq, '<CR>', '\\<CR>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Esc>', '\\<Esc>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Tab>', '\\<Tab>', 'g')
    let l:key_seq = substitute(l:key_seq, '<BS>', '\\<BS>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Space>', '\\<Space>', 'g')
    
    return l:key_seq
endfunction

" Handler for FZF selection
function! s:HandleFZFSelection(line) abort
    " Extract the mode and key from the selected line
    " Format: display|mode|key
    let l:parts = split(a:line, '|')
    if len(l:parts) >= 3
        let l:mode = l:parts[-2]
        let l:key_orig = l:parts[-1]
        
        " Ignore separator lines
        if l:mode == 'separator'
            return
        endif
        
        " Replace <leader> with actual leader key in the key sequence
        let l:leader = get(g:, 'mapleader', '\')
        let l:key = substitute(l:key_orig, '<leader>', l:leader, 'g')
        
        " Check if this was a mapping we created or just documented
        let l:was_created = 0
        if exists('g:mapdocs_created') && has_key(g:mapdocs_created, l:mode)
            let l:was_created = index(g:mapdocs_created[l:mode], l:key_orig) >= 0
        endif
        
        " Don't try to close - FZF will handle window closing
        " Execute the mapping based on mode
        if l:mode == 'n'
            " For normal mode, make sure we're in normal mode first
            call feedkeys("\<Esc>", 'n')
            
            " Handle different types of key sequences
            if l:key =~ '<.*>'
                " Convert key notation and use eval to execute
                let l:converted = s:ConvertKeyNotation(l:key)
                call feedkeys(eval('"' . l:converted . '"'), l:was_created ? 't' : 'm')
            else
                " For simple keys, just send them directly
                call feedkeys(l:key, l:was_created ? 't' : 'm')
            endif
        elseif l:mode == 'i'
            " For insert mode, enter insert mode first
            call feedkeys('i', 'n')
            if l:key =~ '<.*>'
                let l:converted = s:ConvertKeyNotation(l:key)
                call feedkeys(eval('"' . l:converted . '"'), l:was_created ? 't' : 'm')
            else
                call feedkeys(l:key, l:was_created ? 't' : 'm')
            endif
        elseif l:mode == 'v'
            " For visual mode, enter visual mode first
            call feedkeys('v', 'n')
            if l:key =~ '<.*>'
                let l:converted = s:ConvertKeyNotation(l:key)
                call feedkeys(eval('"' . l:converted . '"'), l:was_created ? 't' : 'm')
            else
                call feedkeys(l:key, l:was_created ? 't' : 'm')
            endif
        else
            " Default to normal mode execution
            call feedkeys("\<Esc>", 'n')
            if l:key =~ '<.*>'
                let l:converted = s:ConvertKeyNotation(l:key)
                call feedkeys(eval('"' . l:converted . '"'), l:was_created ? 't' : 'm')
            else
                call feedkeys(l:key, l:was_created ? 't' : 'm')
            endif
        endif
    endif
endfunction

" ShowDocs command using FZF
command! ShowDocs call s:ShowDocsWithFZF()

function! s:ShowDocsWithFZF() abort
    " Check if FZF is available
    if !exists(':FZF')
        echoerr "FZF is not available. Please install fzf.vim"
        return
    endif
    
    " Build the source list
    let l:source = s:BuildFZFSource()
    
    if empty(l:source)
        echo "No mappings documented yet."
        return
    endif
    
    " Extract display parts (without the hidden mode|key data)
    let l:display_source = []
    for l:item in l:source
        let l:parts = split(l:item, '|')
        if len(l:parts) > 0
            call add(l:display_source, l:parts[0])
        endif
    endfor
    
    " Create FZF options
    let l:fzf_options = {
        \ 'source': l:source,
        \ 'sink': function('s:HandleFZFSelection'),
        \ 'options': [
            \ '--prompt', 'Mappings> ',
            \ '--header', 'Select mapping to execute (Enter) or ESC to cancel',
            \ '--preview-window', 'hidden',
            \ '--with-nth', '1',
            \ '--delimiter', '|',
            \ '--tiebreak', 'begin',
            \ '--ansi',
            \ '--info=inline',
            \ '--layout=reverse',
            \ '--height', '60%'
        \ ],
        \ 'window': {'width': 0.9, 'height': 0.6}
    \ }
    
    " Launch FZF
    call fzf#run(fzf#wrap('MapDocs', l:fzf_options))
endfunction

" Helper function to get short mode name
function! s:GetModeShort(mode) abort
    if a:mode == 'n'
        return 'N'
    elseif a:mode == 'i'
        return 'I'
    elseif a:mode == 'v'
        return 'V'
    elseif a:mode == 'x'
        return 'X'
    elseif a:mode == 'o'
        return 'O'
    elseif a:mode == 'c'
        return 'C'
    else
        return a:mode
    endif
endfunction

" Helper function to get full mode name
function! s:GetModeName(mode) abort
    if a:mode == 'n'
        return 'Normal Mode'
    elseif a:mode == 'i'
        return 'Insert Mode'
    elseif a:mode == 'v'
        return 'Visual Mode'
    elseif a:mode == 'x'
        return 'Visual Mode'
    elseif a:mode == 'o'
        return 'Operator-pending Mode'
    elseif a:mode == 'c'
        return 'Command Mode'
    else
        return 'Mode ' . a:mode
    endif
endfunction

" BufferDocs command - display mappings in a buffer (keeping this as alternative)
command! -nargs=? BufferDocs call s:ShowDocsBuffer(<q-args>)

function! s:ShowDocsBuffer(position) abort
    " Get the actual leader key
    let l:leader = get(g:, 'mapleader', '\')
    
    " Determine split position
    let l:pos = a:position == '' ? 'right' : a:position
    
    " Create the content
    let l:lines = []
    
    " Check if we have any docs
    if empty(g:mapdocs)
        let l:lines = ['No mappings documented yet.']
    else
        call add(l:lines, 'MAPPING DOCUMENTATION')
        call add(l:lines, '=' . repeat('=', 62))
        call add(l:lines, '')
        
        " Iterate through modes
        for [l:mode, l:mode_data] in items(g:mapdocs)
            if !empty(l:mode_data)
                let l:mode_name = s:GetModeName(l:mode)
                call add(l:lines, l:mode_name . ' Mappings')
                call add(l:lines, repeat('-', len(l:mode_name . ' Mappings')))
                call add(l:lines, '')
                
                " First show top-level mappings
                for [l:key, l:value] in items(l:mode_data)
                    if type(l:value) == type('')
                        let l:display_key = substitute(l:key, '<leader>', l:leader, 'g')
                        call add(l:lines, printf('  %-15s %s', l:display_key, l:value))
                    endif
                endfor
                
                if !empty(filter(copy(l:mode_data), 'type(v:val) == type("")'))
                    call add(l:lines, '')
                endif
                
                " Then show categorized mappings
                for [l:cat, l:cat_data] in items(l:mode_data)
                    if type(l:cat_data) == type({})
                        call add(l:lines, '  [' . l:cat . ']')
                        for [l:key, l:desc] in items(l:cat_data)
                            let l:display_key = substitute(l:key, '<leader>', l:leader, 'g')
                            call add(l:lines, printf('    %-13s %s', l:display_key, l:desc))
                        endfor
                        call add(l:lines, '')
                    endif
                endfor
                
                call add(l:lines, '')
            endif
        endfor
    endif
    
    " Create or switch to the buffer
    let l:bufname = '*Mapping Docs*'
    let l:bufnr = bufnr(l:bufname)
    
    " Create split based on position
    if l:pos == 'left'
        vnew
        wincmd H
    elseif l:pos == 'right'
        vnew
        wincmd L
    elseif l:pos == 'top'
        new
        wincmd K
    elseif l:pos == 'bottom'
        new
        wincmd J
    else
        vnew
        wincmd L
    endif
    
    " Set up the buffer
    if l:bufnr != -1
        execute 'buffer' l:bufnr
        setlocal modifiable
        normal! ggdG
    else
        file *Mapping\ Docs*
    endif
    
    " Add content
    call setline(1, l:lines)
    
    " Make it read-only and set options
    setlocal nomodifiable
    setlocal readonly
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nowrap
    setlocal number
    setlocal relativenumber
    
    " Set up key mappings for this buffer
    nnoremap <buffer> q :close<CR>
    nnoremap <buffer> <Esc> :close<CR>
    nnoremap <buffer> <CR> :close<CR>
    
    " Move cursor to top
    normal! gg
endfunction

" vim: set ft=vim: