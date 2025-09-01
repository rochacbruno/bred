" Direct test of the BufferDocs functionality
source mapdocs.vim
source mappings.vim

" Manually test the function
let g:test_output = []

function! TestBufferDocs()
    " Get the actual leader key
    let l:leader = get(g:, 'mapleader', '\')
    " Display leader key properly (show <spc> instead of empty space)
    let l:leader_display = l:leader == ' ' ? '<spc>' : l:leader
    
    " Create the content in markdown format
    let l:lines = []
    
    " Check if we have any docs
    if empty(g:mapdocs)
        let l:lines = ['No mappings documented yet.']
    else
        call add(l:lines, '# Vim Keybinding Documentation')
        call add(l:lines, '')
        call add(l:lines, 'Leader key: `' . l:leader_display . '`')
        call add(l:lines, '')
        
        " Define mode order and friendly names
        let l:mode_order = ['n', 'v', 'x', 'i', 'c', 'o', 't']
        let l:mode_names = {
            \ 'n': 'Normal Mode',
            \ 'v': 'Visual Mode', 
            \ 'x': 'Visual Mode (Line)',
            \ 'i': 'Insert Mode',
            \ 'c': 'Command Mode',
            \ 'o': 'Operator-pending Mode',
            \ 't': 'Terminal Mode'
        \ }
        
        " Process only first mode for testing
        for l:mode in ['n']
            if !has_key(g:mapdocs, l:mode)
                continue
            endif
            
            let l:mode_data = g:mapdocs[l:mode]
            if empty(l:mode_data)
                continue
            endif
            
            let l:mode_name = get(l:mode_names, l:mode, 'Mode ' . l:mode)
            call add(l:lines, '## ' . l:mode_name)
            call add(l:lines, '')
            
            " Just show first 5 entries to keep output short
            let l:count = 0
            call add(l:lines, '| Key | Description |')
            call add(l:lines, '|-----|-------------|')
            
            for [l:key, l:value] in items(l:mode_data)
                if l:count >= 5
                    break
                endif
                
                " Extract description based on value type
                let l:desc = ''
                
                if type(l:value) == type('')
                    " Old format: just a string description
                    let l:desc = l:value
                elseif type(l:value) == type({})
                    if has_key(l:value, 'desc')
                        " New format: dict with 'desc' and 'order'
                        let l:desc = l:value.desc
                    else
                        " This is a category - skip for now
                        continue
                    endif
                endif
                
                if l:desc != ''
                    let l:display_key = substitute(l:key, '<leader>', l:leader_display, 'g')
                    let l:display_key = substitute(l:display_key, '<Space>', '<spc>', 'gi')
                    call add(l:lines, '| `' . l:display_key . '` | ' . l:desc . ' |')
                    let l:count += 1
                endif
            endfor
            
            call add(l:lines, '')
            call add(l:lines, '... (showing first 5 entries only)')
        endfor
    endif
    
    " Write to file
    call writefile(l:lines, '/tmp/test_output.md')
    echo "Test complete. Written " . len(l:lines) . " lines."
endfunction

call TestBufferDocs()
qa!