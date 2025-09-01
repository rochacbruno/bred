" Debug test to understand the data structure
source mapdocs.vim
source mappings.vim

function! DebugMapdocs()
    let l:lines = []
    
    " Show what's in g:mapdocs
    call add(l:lines, "=== DEBUG g:mapdocs structure ===")
    call add(l:lines, "")
    
    " Check normal mode specifically
    if has_key(g:mapdocs, 'n')
        call add(l:lines, "Normal mode data exists")
        let l:count = 0
        for [l:key, l:value] in items(g:mapdocs['n'])
            if l:count >= 10
                call add(l:lines, "... (showing first 10 entries)")
                break
            endif
            
            call add(l:lines, "Key: " . l:key)
            call add(l:lines, "Type: " . type(l:value))
            
            if type(l:value) == type({})
                call add(l:lines, "  Dict keys: " . join(keys(l:value), ', '))
                if has_key(l:value, 'desc')
                    call add(l:lines, "  Has 'desc': " . l:value.desc)
                endif
                if has_key(l:value, 'order')
                    call add(l:lines, "  Has 'order': " . l:value.order)
                endif
                " Check if it's a category (has other keys that are mappings)
                let l:first_key = get(keys(l:value), 0, '')
                if l:first_key != '' && l:first_key != 'desc' && l:first_key != 'order'
                    call add(l:lines, "  This is a CATEGORY")
                    " Show first mapping in category
                    let l:first_val = l:value[l:first_key]
                    if type(l:first_val) == type({})
                        call add(l:lines, "    First mapping: " . l:first_key . " -> " . get(l:first_val, 'desc', 'no desc'))
                    endif
                endif
            elseif type(l:value) == type('')
                call add(l:lines, "  String value: " . l:value)
            endif
            
            call add(l:lines, "")
            let l:count += 1
        endfor
    else
        call add(l:lines, "No normal mode data found!")
    endif
    
    " Write to file
    call writefile(l:lines, '/tmp/debug_output.txt')
    echo "Debug complete. Written " . len(l:lines) . " lines."
endfunction

call DebugMapdocs()
qa!