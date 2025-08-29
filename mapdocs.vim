" ==========================
" MapDocs - classic Vimscript  
" ==========================

" Initialize global dictionaries
if !exists("g:mapdocs")
    let g:mapdocs = {}
endif

" Clear any existing mapdocs when sourcing
let g:mapdocs = {}

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
    " Expected format: 'description|category' <lhs> <rhs>
    
    " Find the first quoted string
    let l:match = matchlist(a:args, "^\\s*\\(['\"]\\)\\(.\\{-\\}\\)\\1\\s*\\(\\S\\+\\)\\s*\\(.*\\)$")
    
    if empty(l:match)
        echoerr "Usage: " . toupper(a:mode) . "map 'description|category' <lhs> <rhs>"
        return
    endif
    
    let l:docstr = l:match[2]  " The content between quotes
    let l:lhs = l:match[3]      " The mapping key
    let l:rhs = l:match[4]      " The command to execute
    
    " Parse documentation
    let [l:desc, l:category] = s:ParseDocString(l:docstr)
    
    if l:desc == ''
        echoerr "Description cannot be empty"
        return
    endif
    
    " Create the mapping
    execute a:mode . 'noremap ' . l:lhs . ' ' . l:rhs
    
    " Store documentation
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

" ShowDocs command - display mappings in a popup
command! ShowDocs call s:ShowDocsPopup()

" Popup filter function - handle key events
function! s:PopupFilter(winid, key) abort
    " Close on q, Esc, or Enter
    if a:key == 'q' || a:key == "\<Esc>" || a:key == "\<CR>"
        call popup_close(a:winid)
        return 1
    endif
    
    " Allow scrolling with j/k
    if a:key == 'j' || a:key == "\<Down>"
        let l:firstline = get(popup_getoptions(a:winid), 'firstline', 1)
        call popup_setoptions(a:winid, {'firstline': l:firstline + 1})
        return 1
    elseif a:key == 'k' || a:key == "\<Up>"
        let l:firstline = get(popup_getoptions(a:winid), 'firstline', 1)
        if l:firstline > 1
            call popup_setoptions(a:winid, {'firstline': l:firstline - 1})
        endif
        return 1
    endif
    
    " Page down/up
    if a:key == "\<PageDown>" || a:key == "\<C-f>"
        let l:firstline = get(popup_getoptions(a:winid), 'firstline', 1)
        call popup_setoptions(a:winid, {'firstline': l:firstline + 10})
        return 1
    elseif a:key == "\<PageUp>" || a:key == "\<C-b>"
        let l:firstline = get(popup_getoptions(a:winid), 'firstline', 1)
        call popup_setoptions(a:winid, {'firstline': max([1, l:firstline - 10])})
        return 1
    endif
    
    " Try to execute as a mapping
    " Check if this key corresponds to any documented mapping
    for [l:mode, l:mode_data] in items(g:mapdocs)
        " Check top-level mappings
        for [l:lhs, l:desc] in items(l:mode_data)
            if type(l:desc) == type('') && l:lhs == a:key
                call popup_close(a:winid)
                call feedkeys(a:key, 'n')
                return 1
            endif
        endfor
        " Check categorized mappings
        for [l:cat, l:cat_data] in items(l:mode_data)
            if type(l:cat_data) == type({})
                for [l:lhs, l:desc] in items(l:cat_data)
                    if l:lhs == a:key
                        call popup_close(a:winid)
                        call feedkeys(a:key, 'n')
                        return 1
                    endif
                endfor
            endif
        endfor
    endfor
    
    " Consume all other keys (don't pass through)
    return 1
endfunction

function! s:ShowDocsPopup() abort
    " Get the actual leader key
    let l:leader = get(g:, 'mapleader', '\')
    
    " Collect all mappings first to determine layout
    let l:all_mappings = []
    for [l:mode, l:mode_data] in items(g:mapdocs)
        if !empty(l:mode_data)
            for [l:key, l:value] in items(l:mode_data)
                if type(l:value) == type('')
                    " Format key for display
                    let l:display_key = substitute(l:key, '<leader>', l:leader, 'g')
                    let l:display_key = substitute(l:display_key, '<', '<', 'g')
                    let l:display_key = substitute(l:display_key, '>', '>', 'g')
                    call add(l:all_mappings, {'mode': l:mode, 'key': l:display_key, 'desc': l:value, 'category': ''})
                endif
            endfor
            " Categorized mappings
            for [l:cat, l:cat_data] in items(l:mode_data)
                if type(l:cat_data) == type({})
                    for [l:key, l:desc] in items(l:cat_data)
                        let l:display_key = substitute(l:key, '<leader>', l:leader, 'g')
                        let l:display_key = substitute(l:display_key, '<', '<', 'g')
                        let l:display_key = substitute(l:display_key, '>', '>', 'g')
                        call add(l:all_mappings, {'mode': l:mode, 'key': l:display_key, 'desc': l:desc, 'category': l:cat})
                    endfor
                endif
            endfor
        endif
    endfor
    
    " Build display lines
    let l:lines = []
    
    if empty(l:all_mappings)
        let l:lines = ['No mappings documented yet.', '', 'Press Enter, q, or Esc to close.']
    else
        " Determine if we should use columns
        let l:total_width = &columns - 6
        let l:use_columns = l:total_width >= 120  " Use columns if screen is wide enough
        
        if l:use_columns
            " Two column layout
            let l:col_width = (l:total_width - 3) / 2  " -3 for the middle separator
            let l:key_width = 12
            let l:desc_width = l:col_width - l:key_width - 4  " -4 for borders and padding
            
            " Header with proper alignment
            let l:header_left = printf(' %-' . l:key_width . 's │ Description', 'Key')
            let l:header_right = printf(' %-' . l:key_width . 's │ Description', 'Key')
            let l:header_left_padded = l:header_left . repeat(' ', l:col_width - len(l:header_left))
            call add(l:lines, l:header_left_padded . ' ║ ' . l:header_right)
            
            " Separator line
            call add(l:lines, repeat('─', l:key_width + 2) . '┼' . repeat('─', l:desc_width + 1) . '═╬═' . repeat('─', l:key_width + 2) . '┼' . repeat('─', l:desc_width + 1))
            
            " Group mappings by mode
            let l:modes_data = {}
            for l:m in l:all_mappings
                let l:mode_name = s:GetModeName(l:m.mode)
                if !has_key(l:modes_data, l:mode_name)
                    let l:modes_data[l:mode_name] = []
                endif
                call add(l:modes_data[l:mode_name], l:m)
            endfor
            
            " Display each mode
            for [l:mode_name, l:mappings] in items(l:modes_data)
                call add(l:lines, '')
                call add(l:lines, '═══ ' . l:mode_name . ' ' . repeat('═', l:total_width - len(l:mode_name) - 5))
                
                " Group by category
                let l:uncategorized = []
                let l:categorized = {}
                for l:m in l:mappings
                    if l:m.category == ''
                        call add(l:uncategorized, l:m)
                    else
                        if !has_key(l:categorized, l:m.category)
                            let l:categorized[l:m.category] = []
                        endif
                        call add(l:categorized[l:m.category], l:m)
                    endif
                endfor
                
                " Display uncategorized in two columns
                let l:idx = 0
                while l:idx < len(l:uncategorized)
                    let l:left = l:uncategorized[l:idx]
                    let l:left_key = printf(' %-' . l:key_width . 's', l:left.key)
                    let l:left_desc = printf('│ %-' . l:desc_width . 's', l:left.desc)
                    let l:left_full = l:left_key . l:left_desc
                    
                    if l:idx + 1 < len(l:uncategorized)
                        let l:right = l:uncategorized[l:idx + 1]
                        let l:right_key = printf(' %-' . l:key_width . 's', l:right.key)
                        let l:right_desc = printf('│ %-' . l:desc_width . 's', l:right.desc)
                        let l:right_full = l:right_key . l:right_desc
                    else
                        let l:right_full = repeat(' ', l:col_width)
                    endif
                    
                    call add(l:lines, l:left_full . ' ║ ' . l:right_full)
                    let l:idx += 2
                endwhile
                
                " Display categorized mappings
                for [l:cat, l:cat_mappings] in items(l:categorized)
                    " Category header spans both columns
                    call add(l:lines, '')
                    let l:cat_line = '  ▶ ' . l:cat
                    call add(l:lines, l:cat_line . repeat(' ', l:col_width - len(l:cat_line)) . ' ║ ' . repeat(' ', l:col_width))
                    call add(l:lines, '  ' . repeat('─', len(l:cat) + 2) . repeat(' ', l:col_width - len(l:cat) - 4) . ' ║ ' . repeat(' ', l:col_width))
                    
                    let l:idx = 0
                    while l:idx < len(l:cat_mappings)
                        let l:left = l:cat_mappings[l:idx]
                        let l:left_key = printf('  %-' . (l:key_width - 1) . 's', l:left.key)
                        let l:left_desc = printf('│ %-' . l:desc_width . 's', l:left.desc)
                        let l:left_full = l:left_key . l:left_desc
                        
                        if l:idx + 1 < len(l:cat_mappings)
                            let l:right = l:cat_mappings[l:idx + 1]
                            let l:right_key = printf(' %-' . l:key_width . 's', l:right.key)
                            let l:right_desc = printf('│ %-' . l:desc_width . 's', l:right.desc)
                            let l:right_full = l:right_key . l:right_desc
                        else
                            let l:right_full = repeat(' ', l:col_width)
                        endif
                        
                        call add(l:lines, l:left_full . ' ║ ' . l:right_full)
                        let l:idx += 2
                    endwhile
                endfor
            endfor
        else
            " Single column layout for narrow screens
            call add(l:lines, ' Key        │ Description')
            call add(l:lines, '────────────┼' . repeat('─', 50))
            
            for [l:mode, l:mode_data] in items(g:mapdocs)
                if !empty(l:mode_data)
                    let l:mode_name = s:GetModeName(l:mode)
                    call add(l:lines, '')
                    call add(l:lines, '═══ ' . l:mode_name . ' ' . repeat('═', 58 - len(l:mode_name)))
                    
                    " First show top-level mappings
                    for [l:key, l:value] in items(l:mode_data)
                        if type(l:value) == type('')
                            let l:display_key = substitute(l:key, '<leader>', l:leader, 'g')
                            let l:display_key = substitute(l:display_key, '<', '<', 'g')
                            let l:display_key = substitute(l:display_key, '>', '>', 'g')
                            let l:key_col = printf('%-11s', l:display_key)
                            call add(l:lines, ' ' . l:key_col . '│ ' . l:value)
                        endif
                    endfor
                    
                    " Then show categorized mappings
                    for [l:cat, l:cat_data] in items(l:mode_data)
                        if type(l:cat_data) == type({})
                            call add(l:lines, '')
                            call add(l:lines, '  ▶ ' . l:cat)
                            call add(l:lines, '  ' . repeat('─', len(l:cat) + 2))
                            
                            for [l:key, l:desc] in items(l:cat_data)
                                let l:display_key = substitute(l:key, '<leader>', l:leader, 'g')
                                let l:display_key = substitute(l:display_key, '<', '<', 'g')
                                let l:display_key = substitute(l:display_key, '>', '>', 'g')
                                let l:key_col = printf('%-9s', l:display_key)
                                call add(l:lines, '   ' . l:key_col . '│ ' . l:desc)
                            endfor
                        endif
                    endfor
                endif
            endfor
        endif
        
        call add(l:lines, '')
        call add(l:lines, repeat('═', min([l:total_width, 120])))
        call add(l:lines, ' Navigation: j/k (scroll), PgUp/PgDn, q/Esc/Enter (close)')
        call add(l:lines, ' Type a mapping key to execute it')
    endif
    
    " Create popup window
    if has('popupwin')
        " Calculate dimensions - use more horizontal space
        let l:height = min([len(l:lines), &lines - 4])
        let l:width = min([max([80, &columns - 20]), 140])  " Wider popup, max 140 chars
        
        " Create the popup with better styling
        let l:winid = popup_create(l:lines, {
            \ 'title': '╔═ Mapping Documentation ═╗',
            \ 'pos': 'center',
            \ 'minwidth': l:width,
            \ 'maxwidth': l:width,
            \ 'minheight': l:height,
            \ 'maxheight': l:height,
            \ 'border': [1, 1, 1, 1],
            \ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
            \ 'padding': [0, 1, 0, 1],
            \ 'scrollbar': 1,
            \ 'wrap': 0,
            \ 'mapping': 0,
            \ 'filter': function('s:PopupFilter'),
            \ 'filtermode': 'n',
            \ 'highlight': 'Normal',
            \ 'scrollbarhighlight': 'PmenuSbar',
            \ 'thumbhighlight': 'PmenuThumb',
            \ })
        
        " Set initial focus to the popup
        call win_execute(l:winid, 'normal! gg')
    else
        " Fallback for older Vim versions
        echo join(l:lines, "\n")
        call input('Press Enter to continue...')
    endif
endfunction

" BufferDocs command - display mappings in a buffer
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

" Helper function to get mode name
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

" vim: set ft=vim: