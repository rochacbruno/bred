" ==========================
" MapDocs - classic Vimscript
" ==========================

" Store docs
if !exists("g:map_docs")
    let g:map_docs = {}
endif
if !exists("g:map_docs_default")
    let g:map_docs_default = {}
endif

" Trick Doc command: ends with <CR> automatically
" Just a no-op command that shows up in :verbose map
command! -nargs=* Doc call MapDocsStore(<q-args>) | call feedkeys("\<CR>", 'n')

" Store mapping doc
function! MapDocsStore(args) abort
    " Determine last mapping LHS by checking verbose map
    let l:maps = split(execute('verbose map'), "\n")
    let l:lhs = ''
    for l:line in reverse(l:maps)
        if l:line =~ ':Doc'
            let l:lhs = matchstr(l:line, '^\S\+')
            break
        endif
    endfor
    if l:lhs == ''
        echoerr "Could not detect mapping LHS for Doc"
        return
    endif

    " Store in grouped or ungrouped
    if len(a:args) == 1
        let g:map_docs_default[l:lhs] = a:args[0]
    elseif len(a:args) == 2
        let l:group = a:args[1]
        if !has_key(g:map_docs, l:group)
            let g:map_docs[l:group] = {}
        endif
        let g:map_docs[l:group][l:lhs] = a:args[0]
    else
        echoerr "Doc takes 1 or 2 arguments"
    endif
endfunction

" Show docs popup
function! ShowDocs() abort
    let l:lines = ['=== Mapping Documentation ===']

    " Ungrouped
    if !empty(g:map_docs_default)
        call add(l:lines, '--- Ungrouped ---')
        for [lhs, doc] in items(g:map_docs_default)
            call add(l:lines, printf('%-12s -> %s', lhs, doc))
        endfor
    endif

    " Groups
    for [group, maps] in items(g:map_docs)
        call add(l:lines, '--- ' . group . ' ---')
        for [lhs, doc] in items(maps)
            call add(l:lines, printf('%-12s -> %s', lhs, doc))
        endfor
    endfor

    " Popup in the middle
    let l:opts = {
                \ 'title': 'Mapping Docs',
                \ 'line': '50%',
                \ 'col': '50%',
                \ 'minwidth': 60,
                \ 'minheight': 15,
                \ 'maxheight': 30,
                \ 'wrap': 1,
                \ 'filter': 'DocFilter'
                \ }

    call popup_clear()
    call popup_create(l:lines, l:opts)
endfunction

" Popup filter for DocMode
function! DocFilter(id, key) abort
    if a:key ==# "\<Esc>" || a:key ==# "\<CR>"
        call popup_close(a:id)
        return 1
    endif
    try
        call popup_close(a:id)
        execute 'normal! ' . a:key
    catch
        echo "No mapping for: " . a:key
    endtry
    return 1
endfunction

