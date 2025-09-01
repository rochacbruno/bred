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
command! -nargs=+ Tmap call s:CreateMapping('t', <q-args>)

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

" Build FZF source list from mapdocs with optional mode filter
function! s:BuildFZFSourceFiltered(mode_filter) abort
    " mode_filter should contain modes in the desired order
    " If empty, we'll use default order nvxicot
    if empty(a:mode_filter)
        let l:ordered_modes = ['n', 'v', 'x', 'i', 'c', 'o', 't']
    else
        let l:ordered_modes = a:mode_filter
    endif
    
    let l:leader = get(g:, 'mapleader', '\\')
    " Display leader key properly (show <spc> instead of empty space)
    let l:leader_display = l:leader == ' ' ? '<spc>' : l:leader
    
    " Build the final source list respecting mode order
    let l:source = []
    let l:first_mode = 1
    
    " Process modes in the specified order
    for l:mode in l:ordered_modes
        " Skip if this mode doesn't exist in mapdocs
        if !has_key(g:mapdocs, l:mode)
            continue
        endif
        
        let l:mode_data = g:mapdocs[l:mode]
        let l:mode_display = s:GetModeShort(l:mode)
        let l:mode_uncategorized = []
        let l:mode_categorized = []
        
        " Collect uncategorized mappings for this mode
        for [l:key, l:desc] in items(l:mode_data)
            if type(l:desc) == type('')
                " Try to get the raw mapping
                let l:raw_mapping = ''
                if exists('g:mapdocs_created') && has_key(g:mapdocs_created, l:mode) && index(g:mapdocs_created[l:mode], l:key) >= 0
                    let l:mapping = maparg(l:key, l:mode, 0, 1)
                    if !empty(l:mapping) && has_key(l:mapping, 'rhs')
                        " Remove <silent> from display
                        let l:raw_mapping = substitute(l:mapping.rhs, '<silent>\s*', '', 'g')
                        let l:raw_mapping = ' | ' . l:raw_mapping
                    endif
                endif
                " Format: [mode] key : description | raw_mapping
                " Store the clean key for execution (without <silent>)
                let l:clean_key = substitute(l:key, '<silent>', '', 'gi')
                let l:display_key = substitute(l:clean_key, '<leader>', l:leader_display, 'g')
                " Replace <Space> with <spc> in display
                let l:display_key = substitute(l:display_key, '<Space>', '<spc>', 'gi')
                let l:line = printf("[%s] %-18s : %s%s", l:mode_display, l:display_key, l:desc, l:raw_mapping)
                call add(l:mode_uncategorized, {
                    \ 'line': l:line . '|' . l:mode . '|' . l:clean_key,
                    \ 'desc': l:desc
                \ })
            endif
        endfor
        
        " Collect categorized mappings for this mode
        for [l:category, l:cat_data] in items(l:mode_data)
            if type(l:cat_data) == type({})
                for [l:key, l:desc] in items(l:cat_data)
                    " Try to get the raw mapping
                    let l:raw_mapping = ''
                    if exists('g:mapdocs_created') && has_key(g:mapdocs_created, l:mode) && index(g:mapdocs_created[l:mode], l:key) >= 0
                        let l:mapping = maparg(l:key, l:mode, 0, 1)
                        if !empty(l:mapping) && has_key(l:mapping, 'rhs')
                            " Remove <silent> from display
                            let l:raw_mapping = substitute(l:mapping.rhs, '<silent>\s*', '', 'g')
                            let l:raw_mapping = ' | ' . l:raw_mapping
                        endif
                    endif
                    " Store the clean key for execution (without <silent>)
                    let l:clean_key = substitute(l:key, '<silent>', '', 'gi')
                    let l:display_key = substitute(l:clean_key, '<leader>', l:leader_display, 'g')
                    " Replace <Space> with <spc> in display
                    let l:display_key = substitute(l:display_key, '<Space>', '<spc>', 'gi')
                    " Include category in display
                    let l:line = printf("[%s] %-18s : [%s] %s%s", l:mode_display, l:display_key, l:category, l:desc, l:raw_mapping)
                    call add(l:mode_categorized, {
                        \ 'line': l:line . '|' . l:mode . '|' . l:clean_key,
                        \ 'category': l:category,
                        \ 'desc': l:desc
                    \ })
                endfor
            endif
        endfor
        
        " Sort uncategorized alphabetically by description
        call sort(l:mode_uncategorized, {a, b -> a.desc < b.desc ? -1 : a.desc > b.desc ? 1 : 0})
        
        " Sort categorized first by category, then by description
        call sort(l:mode_categorized, {a, b -> 
            \ a.category != b.category ? 
            \ (a.category < b.category ? -1 : 1) :
            \ (a.desc < b.desc ? -1 : a.desc > b.desc ? 1 : 0)
        \ })
        
        " Add mode separator if not the first mode and we have items
        if !l:first_mode && (!empty(l:mode_uncategorized) || !empty(l:mode_categorized))
            call add(l:source, '─────────────────────────────────────────────────|separator|separator')
        endif
        
        " Add uncategorized items for this mode
        for l:item in l:mode_uncategorized
            call add(l:source, l:item.line)
        endfor
        
        " Add separator between uncategorized and categorized within mode
        if !empty(l:mode_uncategorized) && !empty(l:mode_categorized)
            call add(l:source, '·····································································|separator|separator')
        endif
        
        " Add categorized items for this mode
        for l:item in l:mode_categorized
            call add(l:source, l:item.line)
        endfor
        
        if !empty(l:mode_uncategorized) || !empty(l:mode_categorized)
            let l:first_mode = 0
        endif
    endfor
    
    " Add any remaining modes that weren't in the filter (at the end)
    for [l:mode, l:mode_data] in items(g:mapdocs)
        if index(l:ordered_modes, l:mode) != -1
            " Already processed
            continue
        endif
        
        let l:mode_display = s:GetModeShort(l:mode)
        let l:mode_uncategorized = []
        let l:mode_categorized = []
        
        " Collect uncategorized mappings for this mode
        for [l:key, l:desc] in items(l:mode_data)
            if type(l:desc) == type('')
                " Try to get the raw mapping
                let l:raw_mapping = ''
                if exists('g:mapdocs_created') && has_key(g:mapdocs_created, l:mode) && index(g:mapdocs_created[l:mode], l:key) >= 0
                    let l:mapping = maparg(l:key, l:mode, 0, 1)
                    if !empty(l:mapping) && has_key(l:mapping, 'rhs')
                        " Remove <silent> from display
                        let l:raw_mapping = substitute(l:mapping.rhs, '<silent>\s*', '', 'g')
                        let l:raw_mapping = ' | ' . l:raw_mapping
                    endif
                endif
                " Store the clean key for execution (without <silent>)
                let l:clean_key = substitute(l:key, '<silent>', '', 'gi')
                let l:display_key = substitute(l:clean_key, '<leader>', l:leader_display, 'g')
                " Replace <Space> with <spc> in display
                let l:display_key = substitute(l:display_key, '<Space>', '<spc>', 'gi')
                let l:line = printf("[%s] %-18s : %s%s", l:mode_display, l:display_key, l:desc, l:raw_mapping)
                call add(l:mode_uncategorized, {
                    \ 'line': l:line . '|' . l:mode . '|' . l:clean_key,
                    \ 'desc': l:desc
                \ })
            endif
        endfor
        
        " Collect categorized mappings for this mode
        for [l:category, l:cat_data] in items(l:mode_data)
            if type(l:cat_data) == type({})
                for [l:key, l:desc] in items(l:cat_data)
                    " Try to get the raw mapping
                    let l:raw_mapping = ''
                    if exists('g:mapdocs_created') && has_key(g:mapdocs_created, l:mode) && index(g:mapdocs_created[l:mode], l:key) >= 0
                        let l:mapping = maparg(l:key, l:mode, 0, 1)
                        if !empty(l:mapping) && has_key(l:mapping, 'rhs')
                            " Remove <silent> from display
                            let l:raw_mapping = substitute(l:mapping.rhs, '<silent>\s*', '', 'g')
                            let l:raw_mapping = ' | ' . l:raw_mapping
                        endif
                    endif
                    " Store the clean key for execution (without <silent>)
                    let l:clean_key = substitute(l:key, '<silent>', '', 'gi')
                    let l:display_key = substitute(l:clean_key, '<leader>', l:leader_display, 'g')
                    " Replace <Space> with <spc> in display
                    let l:display_key = substitute(l:display_key, '<Space>', '<spc>', 'gi')
                    let l:line = printf("[%s] %-18s : [%s] %s%s", l:mode_display, l:display_key, l:category, l:desc, l:raw_mapping)
                    call add(l:mode_categorized, {
                        \ 'line': l:line . '|' . l:mode . '|' . l:clean_key,
                        \ 'category': l:category,
                        \ 'desc': l:desc
                    \ })
                endfor
            endif
        endfor
        
        " Sort and add if we have any items
        if !empty(l:mode_uncategorized) || !empty(l:mode_categorized)
            call sort(l:mode_uncategorized, {a, b -> a.desc < b.desc ? -1 : a.desc > b.desc ? 1 : 0})
            call sort(l:mode_categorized, {a, b -> 
                \ a.category != b.category ? 
                \ (a.category < b.category ? -1 : 1) :
                \ (a.desc < b.desc ? -1 : a.desc > b.desc ? 1 : 0)
            \ })
            
            if !l:first_mode
                call add(l:source, '─────────────────────────────────────────────────|separator|separator')
            endif
            
            for l:item in l:mode_uncategorized
                call add(l:source, l:item.line)
            endfor
            
            if !empty(l:mode_uncategorized) && !empty(l:mode_categorized)
                call add(l:source, '·····································································|separator|separator')
            endif
            
            for l:item in l:mode_categorized
                call add(l:source, l:item.line)
            endfor
            
            let l:first_mode = 0
        endif
    endfor
    
    return l:source
endfunction
" Build FZF source list from mapdocs (backwards compatibility)
function! s:BuildFZFSource() abort
    " Use default order: nvxicot
    return s:BuildFZFSourceFiltered(['n', 'v', 'x', 'i', 'c', 'o', 't'])
endfunction

" Convert key notation to executable key sequence
function! s:ConvertKeyNotation(key) abort
    " For sequences with special keys, convert notation to escape sequences
    let l:key_seq = a:key
    
    " Replace special key notations with their escape sequences
    " Using double backslash to properly escape in the string
    
    " Handle Meta (Alt) key combinations first (more specific patterns first)
    let l:key_seq = substitute(l:key_seq, '<M-Backspace>', '\\<M-BS>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-BS>', '\\<M-BS>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-Up>', '\\<M-Up>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-Down>', '\\<M-Down>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-Left>', '\\<M-Left>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-Right>', '\\<M-Right>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-Tab>', '\\<M-Tab>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-CR>', '\\<M-CR>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-Enter>', '\\<M-Enter>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-C-Right>', '\\<M-C-Right>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-C-RightMouse>', '\\<M-C-RightMouse>', 'g')
    
    " Handle single Meta keys (M-a through M-z, etc)
    let l:key_seq = substitute(l:key_seq, '<M-\([a-zA-Z0-9]\)>', '\\<M-\1>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-\[>', '\\<M-[>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-\]>', '\\<M-]>', 'g')
    let l:key_seq = substitute(l:key_seq, '<M-\\>', '\\<M-\\>', 'g')
    
    " Handle Control key combinations
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
    
    " Handle mouse events
    let l:key_seq = substitute(l:key_seq, '<C-LeftMouse>', '\\<C-LeftMouse>', 'g')
    let l:key_seq = substitute(l:key_seq, '<C-RightMouse>', '\\<C-RightMouse>', 'g')
    let l:key_seq = substitute(l:key_seq, '<LeftMouse>', '\\<LeftMouse>', 'g')
    let l:key_seq = substitute(l:key_seq, '<RightMouse>', '\\<RightMouse>', 'g')
    
    " Handle other special keys
    let l:key_seq = substitute(l:key_seq, '<CR>', '\\<CR>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Esc>', '\\<Esc>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Tab>', '\\<Tab>', 'g')
    let l:key_seq = substitute(l:key_seq, '<BS>', '\\<BS>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Backspace>', '\\<BS>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Space>', '\\<Space>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Del>', '\\<Del>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Home>', '\\<Home>', 'g')
    let l:key_seq = substitute(l:key_seq, '<End>', '\\<End>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Left>', '\\<Left>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Right>', '\\<Right>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Up>', '\\<Up>', 'g')
    let l:key_seq = substitute(l:key_seq, '<Down>', '\\<Down>', 'g')
    let l:key_seq = substitute(l:key_seq, '<PageUp>', '\\<PageUp>', 'g')
    let l:key_seq = substitute(l:key_seq, '<PageDown>', '\\<PageDown>', 'g')
    
    return l:key_seq
endfunction

" Original handler for FZF selection
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
        
        " For insert mode, just show info and let window close
        if l:mode == 'i'
            " Get the mapping info for display
            let l:mapping = maparg(l:key_orig, 'i', 0, 1)
            
            " Build informative message
            let l:msg = "[Insert Mode] " . l:key_orig
            if !empty(l:mapping) && has_key(l:mapping, 'rhs')
                let l:msg .= " → " . l:mapping.rhs
            endif
            
            " Show message in status line
            echo l:msg . " | Press key manually in insert mode"
            
            " Let FZF close naturally
            return
        endif
        
        " For non-insert modes, proceed with execution
        " Replace <leader> with actual leader key in the key sequence
        let l:leader = get(g:, 'mapleader', '\')
        let l:key = substitute(l:key_orig, '<leader>', l:leader, 'g')
        
        " Check if this was a mapping we created or just documented
        let l:was_created = 0
        if exists('g:mapdocs_created') && has_key(g:mapdocs_created, l:mode)
            let l:was_created = index(g:mapdocs_created[l:mode], l:key_orig) >= 0
        endif
        
        " Don't try to close - FZF will handle window closing
        " Get current mode to determine if we need to switch
        let l:current_mode = mode()
        
        " Execute the mapping based on mode
        if l:mode == 'n'
            " For normal mode, make sure we're in normal mode first
            if l:current_mode != 'n'
                call feedkeys("\<Esc>", 'n')
            endif
            
            " Handle different types of key sequences
            if l:key =~ '<.*>'
                " Convert key notation and use eval to execute
                let l:converted = s:ConvertKeyNotation(l:key)
                call feedkeys(eval('"' . l:converted . '"'), l:was_created ? 't' : 'm')
            else
                " For simple keys, just send them directly
                call feedkeys(l:key, l:was_created ? 't' : 'm')
            endif
        elseif l:mode == 'v' || l:mode == 'x'
            " For visual mode, we need to handle selection restoration carefully
            if exists('s:has_saved_visual') && s:has_saved_visual
                " First restore the selection
                let l:restore_seq = "\<Esc>"
                
                " Go to start position
                let l:restore_seq .= s:saved_visual_start_line . "G" . s:saved_visual_start_col . "|"
                
                " Enter the appropriate visual mode
                if s:saved_visual_mode == 'V'
                    let l:restore_seq .= "V"
                elseif s:saved_visual_mode == "\<C-v>"
                    let l:restore_seq .= "\<C-v>"
                else
                    let l:restore_seq .= "v"
                endif
                
                " Go to end position
                let l:restore_seq .= s:saved_visual_end_line . "G" . s:saved_visual_end_col . "|"
                
                " Send the restore sequence first
                call feedkeys(l:restore_seq, 'n')
                
                " Then send the actual command separately
                if l:key =~ '<.*>'
                    let l:converted = s:ConvertKeyNotation(l:key)
                    " Use 'mt' flag to allow mappings to be triggered
                    call feedkeys(eval('"' . l:converted . '"'), 'mt')
                else
                    call feedkeys(l:key, 'mt')
                endif
            else
                " No saved selection, just enter visual mode and execute
                call feedkeys("\<Esc>v", 'n')
                if l:key =~ '<.*>'
                    let l:converted = s:ConvertKeyNotation(l:key)
                    call feedkeys(eval('"' . l:converted . '"'), 'mt')
                else
                    call feedkeys(l:key, 'mt')
                endif
            endif
        elseif l:mode == 'o'
            " For operator-pending mode, we need to start with an operator
            " This is tricky - we'll default to normal mode
            call feedkeys("\<Esc>", 'n')
            if l:key =~ '<.*>'
                let l:converted = s:ConvertKeyNotation(l:key)
                call feedkeys(eval('"' . l:converted . '"'), l:was_created ? 't' : 'm')
            else
                call feedkeys(l:key, l:was_created ? 't' : 'm')
            endif
        elseif l:mode == 'c'
            " For command mode, enter command mode first
            call feedkeys(":", 'n')
            if l:key =~ '<.*>'
                let l:converted = s:ConvertKeyNotation(l:key)
                call feedkeys(eval('"' . l:converted . '"'), l:was_created ? 't' : 'm')
            else
                call feedkeys(l:key, l:was_created ? 't' : 'm')
            endif
        elseif l:mode == 't'
            " For terminal mode, we need to be in a terminal window
            " This is tricky - terminal mappings only work in terminal buffers
            echo "[Terminal Mode] " . l:key_orig . " | Use in terminal buffer"
            return
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
" Usage: :ShowDocs [modes] - where modes is a string like 'n', 'ni', 'nix', etc.
" Can be used with a range to preserve visual selection: :'<,'>ShowDocs vx
command! -nargs=? -range ShowDocs call s:ShowDocsWithFZF(<q-args>)

function! s:ShowDocsWithFZF(modes) abort
    " Check if FZF is available
    if !exists(':FZF')
        echoerr "FZF is not available. Please install fzf.vim"
        return
    endif
    
    " Save visual selection if we're in visual mode or have a range
    if mode() =~# '[vV\<C-v>]' || line("'<") > 0
        " Save the actual positions, not just the marks
        let s:saved_visual_start_line = line("'<")
        let s:saved_visual_start_col = col("'<")
        let s:saved_visual_end_line = line("'>")
        let s:saved_visual_end_col = col("'>")
        let s:saved_visual_mode = visualmode()
        let s:has_saved_visual = 1
        " Also save the actual selected text to verify restoration
        let s:saved_register = getreg('"')
        normal! gvy
        let s:saved_selection = getreg('"')
        call setreg('"', s:saved_register)
    else
        let s:has_saved_visual = 0
    endif
    
    " Parse mode filter - if empty, use default order
    if a:modes == ''
        " Default order: nvxicot (Normal, Visual, V-Line, Insert, Command, Operator, Terminal)
        let l:mode_filter = ['n', 'v', 'x', 'i', 'c', 'o', 't']
    else
        let l:mode_filter = split(a:modes, '\zs')
    endif
    
    " Build the source list
    let l:source = s:BuildFZFSourceFiltered(l:mode_filter)
    
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
    
    " Build header text based on mode filter
    let l:header_text = 'Select mapping to execute (Enter) or ESC to cancel'
    " if !empty(l:mode_filter)
    "     let l:mode_names = []
    "     for l:m in l:mode_filter
    "         call add(l:mode_names, s:GetModeName(l:m))
    "     endfor
    "     let l:header_text = 'Showing: ' . join(l:mode_names, ', ') . ' | ' . l:header_text
    " endif
    
    " Create FZF options
    let l:fzf_options = {
        \ 'source': l:source,
        \ 'sink': function('s:HandleFZFSelection'),
        \ 'options': [
            \ '--prompt', 'Mappings> ',
            \ '--header', l:header_text,
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
    elseif a:mode == 't'
        return 'T'
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
    elseif a:mode == 't'
        return 'Terminal Mode'
    else
        return 'Mode ' . a:mode
    endif
endfunction

" BufferDocs command - display mappings in a buffer (keeping this as alternative)
command! -nargs=? BufferDocs call s:ShowDocsBuffer(<q-args>)

function! s:ShowDocsBuffer(position) abort
    " Get the actual leader key
    let l:leader = get(g:, 'mapleader', '\')
    " Display leader key properly (show <spc> instead of empty space)
    let l:leader_display = l:leader == ' ' ? '<spc>' : l:leader
    
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
                        let l:display_key = substitute(l:key, '<leader>', l:leader_display, 'g')
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
                            let l:display_key = substitute(l:key, '<leader>', l:leader_display, 'g')
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
