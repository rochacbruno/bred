" =====================================
" Flag Marks Manager - Vim9script
" =====================================
" This is actually a plygin, but for now kept here for simplicity
" In the future this will move to a separate repo when complete.
" See flagmarks.md for documentation.


" Global variables
let g:flag_marks = []
let g:last_mark = ''
let g:flag_signs_visible = 1
let g:flag_go_history = []

" ---------------------------
" Initialize signs for marks
" ---------------------------
function! s:InitSigns()
    " Define signs for all uppercase letters
    for l:i in range(char2nr('A'), char2nr('Z'))
        let l:letter = nr2char(l:i)
        let l:sign_name = 'FlagMark' . l:letter
        if empty(sign_getdefined(l:sign_name))
            " Use '>' + letter for better visibility in gutter
            call sign_define(l:sign_name, {'text': '>' . l:letter, 'texthl': 'DiffAdd', 'linehl': ''})
        endif
    endfor
endfunction

" Initialize signs on startup
call s:InitSigns()

" Ensure sign column is visible
if !exists('&signcolumn') || &signcolumn == 'no'
    set signcolumn=auto
endif

" ---------------------------
" Helper function to compare files
" ---------------------------
function! s:FilesMatch(file1, file2)
    " Remove any whitespace
    let l:f1 = trim(a:file1)
    let l:f2 = trim(a:file2)
    
    " Direct comparison
    if l:f1 ==# l:f2
        return 1
    endif
    
    " Get full paths
    let l:f1_full = fnamemodify(l:f1, ':p')
    let l:f2_full = fnamemodify(l:f2, ':p')
    
    " Full path comparison
    if l:f1_full != '' && l:f2_full != '' && l:f1_full ==# l:f2_full
        return 1
    endif
    
    " Try resolving relative to current directory
    let l:f1_resolved = resolve(l:f1)
    let l:f2_resolved = resolve(l:f2)
    if l:f1_resolved ==# l:f2_resolved
        return 1
    endif
    
    " Compare just filenames as last resort
    let l:f1_tail = fnamemodify(l:f1, ':t')
    let l:f2_tail = fnamemodify(l:f2, ':t')
    if l:f1_tail != '' && l:f2_tail != '' && l:f1_tail ==# l:f2_tail
        return 1
    endif
    
    return 0
endfunction

" ---------------------------
" Update signs for all marks
" ---------------------------
function! s:UpdateSigns()
    " Ensure signs are initialized
    call s:InitSigns()
    
    " Clear all existing flag mark signs
    call sign_unplace('FlagMarks')
    
    " Only place signs if they're visible
    if !g:flag_signs_visible
        return
    endif
    
    " Place signs for current marks
    for l:m in g:flag_marks
        try
            " Get the file path - it might be relative or absolute
            let l:file_path = trim(l:m.file)
            
            " Try different ways to find the buffer
            let l:bufnr = -1
            
            " Check all buffers for a match
            for l:buf in range(1, bufnr('$'))
                if !bufexists(l:buf)
                    continue
                endif
                
                let l:bufname = bufname(l:buf)
                if l:bufname == ''
                    continue
                endif
                
                if s:FilesMatch(l:bufname, l:file_path)
                    let l:bufnr = l:buf
                    break
                endif
            endfor
            
            " If no buffer found, try to create one if file exists
            if l:bufnr == -1
                let l:full_path = fnamemodify(l:file_path, ':p')
                if filereadable(l:full_path)
                    let l:bufnr = bufnr(l:full_path, 1)
                elseif filereadable(l:file_path)
                    let l:bufnr = bufnr(l:file_path, 1)
                endif
            endif
            
            if l:bufnr != -1 && bufexists(l:bufnr)
                let l:sign_name = 'FlagMark' . l:m.mark
                let l:sign_id = char2nr(l:m.mark) * 1000 + str2nr(l:m.line)
                call sign_place(l:sign_id, 'FlagMarks', l:sign_name, l:bufnr, {'lnum': str2nr(l:m.line), 'priority': 100})
            endif
        catch
            " Debug: show errors
            echom "Sign place error for mark " . l:m.mark . ": " . v:exception
        endtry
    endfor
endfunction

" ---------------------------
" Collect all global marks (A-Z)
" ---------------------------
function! s:CollectMarks()
    try
        " Get marks info using getmarklist()
        let l:marks = getmarklist()
        
        let g:flag_marks = []
        
        " Process each mark
        for l:mark_info in l:marks
            " Only process uppercase marks A-Z
            let l:mark_char = l:mark_info.mark[1]  " Remove the leading '
            if l:mark_char =~# '^[A-Z]$'
                " Get position info
                let l:pos = l:mark_info.pos
                let l:bufnr = l:pos[0]
                let l:line_num = l:pos[1]
                let l:col = l:pos[2]
                
                " Get filename from buffer number
                let l:file = ''
                if l:bufnr > 0
                    let l:file = bufname(l:bufnr)
                    if l:file == ''
                        " Try to get file from buffer info
                        let l:file = fnamemodify(bufname(l:bufnr), ':p')
                    endif
                endif
                
                " If we still don't have a file, try getting it from mark position
                if l:file == ''
                    " Try to get file using getpos
                    let l:mark_pos = getpos("'" . l:mark_char)
                    if l:mark_pos[0] > 0
                        let l:file = bufname(l:mark_pos[0])
                    endif
                endif
                
                if l:file != ''
                    let l:markinfo = {'mark': l:mark_char, 'line': string(l:line_num), 'col': string(l:col), 'file': l:file}
                    call add(g:flag_marks, l:markinfo)
                endif
            endif
        endfor

        " sort by mark
        call sort(g:flag_marks, {a,b -> a.mark < b.mark ? -1 : a.mark > b.mark ? 1 : 0})
        
        " Update signs after collecting marks
        call s:UpdateSigns()
    catch /E283/
        " No marks set
        let g:flag_marks = []
    catch
        " Other errors - try to continue
        echom "Error collecting marks: " . v:exception
    endtry
endfunction

" ---------------------------
" Find next free mark
" ---------------------------
function! s:NextFreeMark()
    call s:CollectMarks()
    for l:c in range(char2nr('A'), char2nr('Z'))
        let l:m = nr2char(l:c)
        let l:exists = filter(copy(g:flag_marks), {_,v -> v.mark ==# l:m})
        if empty(l:exists)
            return l:m
        endif
    endfor
    return ''
endfunction

" ---------------------------
" Add new global mark
" ---------------------------
function! FlagAdd()
    " Check if there's already a mark on this line in this file
    call s:CollectMarks()
    let l:lnum = line('.')
    let l:fname = expand('%:p')
    
    for l:existing in g:flag_marks
        let l:mark_file = fnamemodify(l:existing.file, ':p')
        if l:mark_file ==# l:fname && str2nr(l:existing.line) == l:lnum
            echo "Mark " . l:existing.mark . " already exists on this line"
            return
        endif
    endfor
    
    let l:m = s:NextFreeMark()
    if l:m == ''
        echo "No free global marks!"
        return
    endif
    execute 'mark ' . l:m
    
    " Add to jump history
    if empty(g:flag_go_history)
        call add(g:flag_go_history, l:m)
    elseif len(g:flag_go_history) == 1
        if g:flag_go_history[0] != l:m
            call insert(g:flag_go_history, l:m, 0)
        endif
    else
        if g:flag_go_history[0] != l:m
            let g:flag_go_history[1] = g:flag_go_history[0]
            let g:flag_go_history[0] = l:m
        endif
    endif
    
    call s:CollectMarks()
    echo "Set global mark " . l:m
endfunction

" ---------------------------
" Delete mark on current line
" ---------------------------
function! FlagDelete()
    call s:CollectMarks()
    let l:lnum = line('.')
    let l:current_file = expand('%:p')
    let l:current_name = expand('%:t')
    
    for l:m in g:flag_marks
        " Check if line numbers match
        if str2nr(l:m.line) != l:lnum
            continue
        endif
        
        " Check if files match using helper function
        if s:FilesMatch(l:current_file, l:m.file)
            execute 'delmarks ' . l:m.mark
            echo "Deleted mark " . l:m.mark
            call s:CollectMarks()
            return
        endif
    endfor
    echo "No mark on line " . l:lnum . " (checked " . len(g:flag_marks) . " marks)"
endfunction

" ---------------------------
" Clear all marks in file
" ---------------------------
function! FlagClearFile()
    call s:CollectMarks()
    let l:current_file = expand('%:p')
    let l:marks = []
    
    for l:m in g:flag_marks
        " Check if files match using helper function
        if s:FilesMatch(l:current_file, l:m.file)
            call add(l:marks, l:m.mark)
        endif
    endfor
    
    if !empty(l:marks)
        " Ask for confirmation
        let l:file_name = fnamemodify(l:current_file, ':t')
        let l:marks_str = join(l:marks, ', ')
        echo "Clear marks [" . l:marks_str . "] in " . l:file_name . "? (y/N): "
        let l:confirm = nr2char(getchar())
        if l:confirm ==? 'y'
            execute 'delmarks ' . join(l:marks, '')
            echo "Cleared " . len(l:marks) . " marks in current file"
            call s:CollectMarks()
        else
            echo "Cancelled"
        endif
    else
        echo "No marks in this file (checked " . len(g:flag_marks) . " total marks)"
    endif
endfunction

" ---------------------------
" Clear all marks globally
" ---------------------------
function! FlagClearAll()
    call s:CollectMarks()
    
    if empty(g:flag_marks)
        echo "No global marks to clear"
        return
    endif
    
    " Ask for confirmation
    let l:count = len(g:flag_marks)
    let l:marks = map(copy(g:flag_marks), 'v:val.mark')
    let l:marks_str = join(l:marks, ', ')
    echo "Clear ALL " . l:count . " global marks [" . l:marks_str . "]? (y/N): "
    let l:confirm = nr2char(getchar())
    
    if l:confirm ==? 'y'
        execute 'delmarks A-Z'
        call s:CollectMarks()
        call s:UpdateSigns()
        echo "Cleared all global marks"
    else
        echo "Cancelled"
    endif
endfunction

" ---------------------------
" Same-window versions (force same window)
" ---------------------------
function! FlagGoSame(...)
    if a:0 == 0
        call FlagGo('', 0)
    else
        call FlagGo(a:1, 0)
    endif
endfunction

function! FlagNextSame()
    call FlagNext(0)
endfunction

function! FlagPrevSame()
    call FlagPrev(0)
endfunction

function! FlagMenuSame()
    let g:flag_menu_window_aware = 0
    call FlagMenu()
endfunction

function! FlagMenuWindow()
    let g:flag_menu_window_aware = 1
    call FlagMenu()
endfunction

" ---------------------------
" Populate quickfix with marks
" ---------------------------
function! FlagQuick()
    call s:CollectMarks()
    
    if empty(g:flag_marks)
        echo "No marks to add to quickfix"
        return
    endif
    
    let l:qf_list = []
    
    for l:m in g:flag_marks
        " Get buffer number for the file
        let l:bufnr = bufnr(l:m.file)
        if l:bufnr == -1
            " Try to create buffer if file exists
            if filereadable(fnamemodify(l:m.file, ':p'))
                let l:bufnr = bufnr(fnamemodify(l:m.file, ':p'), 1)
            elseif filereadable(l:m.file)
                let l:bufnr = bufnr(l:m.file, 1)
            endif
        endif
        
        " Get line text for preview
        let l:text = s:GetLinePreview(l:m.file, str2nr(l:m.line))
        
        " Add to quickfix list
        call add(l:qf_list, {
            \ 'bufnr': l:bufnr,
            \ 'filename': l:m.file,
            \ 'lnum': str2nr(l:m.line),
            \ 'col': str2nr(l:m.col),
            \ 'text': 'Mark ' . l:m.mark . ': ' . l:text,
            \ 'type': 'M'
            \ })
    endfor
    
    " Set quickfix list
    call setqflist(l:qf_list)
    
    " Open quickfix window
    copen
    
    echo "Added " . len(l:qf_list) . " marks to quickfix"
endfunction

" ---------------------------
" Jump next/prev mark
" ---------------------------
function! FlagNext(...)
    " Default to window-aware (1) unless explicitly passed 0
    let l:window_aware = (a:0 > 0) ? a:1 : 1
    call s:CollectMarks()
    if empty(g:flag_marks)
        echo "No marks"
        return
    endif
    let l:marks = map(copy(g:flag_marks), 'v:val.mark')
    let idx = index(l:marks, get(g:, 'last_mark', ''))
    let idx = (idx + 1) % len(l:marks)
    let g:last_mark = l:marks[idx]
    call s:JumpToMark(g:last_mark, l:window_aware)
endfunction

function! FlagPrev(...)
    " Default to window-aware (1) unless explicitly passed 0
    let l:window_aware = (a:0 > 0) ? a:1 : 1
    call s:CollectMarks()
    if empty(g:flag_marks)
        echo "No marks"
        return
    endif
    let l:marks = map(copy(g:flag_marks), 'v:val.mark')
    let idx = index(l:marks, get(g:, 'last_mark', ''))
    let idx = (idx - 1 + len(l:marks)) % len(l:marks)
    let g:last_mark = l:marks[idx]
    call s:JumpToMark(g:last_mark, l:window_aware)
endfunction

" ---------------------------
" List marks aligned
" ---------------------------
function! FlagList()
    call s:CollectMarks()
    if empty(g:flag_marks)
        echo "No marks"
        return
    endif

    let l:maxfile = max(map(copy(g:flag_marks), 'len(fnamemodify(v:val.file, ":t"))'))
    echo printf("%-4s %-*s %s", "Mark", l:maxfile, "File", "Line")
    echo repeat("-", 6 + l:maxfile + 5)

    for l:m in g:flag_marks
        let l:file_short = fnamemodify(l:m.file, ":t")
        echo printf("%-4s %-*s %s", l:m.mark, l:maxfile, l:file_short, l:m.line)
    endfor
endfunction

" ---------------------------
" Toggle sign visibility
" ---------------------------
function! FlagToggle()
    let g:flag_signs_visible = !g:flag_signs_visible
    if g:flag_signs_visible
        call s:UpdateSigns()
        echo "Flag signs enabled"
    else
        call sign_unplace('FlagMarks')
        echo "Flag signs disabled"
    endif
endfunction

" ---------------------------
" Get line content preview
" ---------------------------
function! s:GetLinePreview(file, line_num)
    " Try to get the line content
    let l:content = ''
    let l:bufnr = bufnr(a:file)
    
    if l:bufnr != -1 && bufloaded(l:bufnr)
        " Buffer is loaded, get line directly
        let l:lines = getbufline(l:bufnr, a:line_num)
        if !empty(l:lines)
            let l:content = l:lines[0]
        endif
    elseif filereadable(a:file)
        " File exists but not loaded, read it
        let l:lines = readfile(a:file, '', a:line_num)
        if len(l:lines) >= a:line_num
            let l:content = l:lines[a:line_num - 1]
        endif
    endif
    
    " Clean and truncate the content
    if l:content != ''
        " Remove leading whitespace
        let l:content = substitute(l:content, '^\s\+', '', '')
        " Truncate to first 30 chars
        if len(l:content) > 30
            let l:content = strpart(l:content, 0, 27) . '...'
        endif
    else
        let l:content = '<no preview>'
    endif
    
    return l:content
endfunction

" ---------------------------
" Find window containing file
" ---------------------------
function! s:FindWindowWithFile(file)
    " Get full path of target file
    let l:target_file = fnamemodify(a:file, ':p')
    
    " Check all windows
    for l:winnr in range(1, winnr('$'))
        let l:bufnr = winbufnr(l:winnr)
        if l:bufnr != -1
            let l:win_file = fnamemodify(bufname(l:bufnr), ':p')
            if l:win_file ==# l:target_file || bufname(l:bufnr) ==# a:file
                return l:winnr
            endif
        endif
    endfor
    
    return 0
endfunction

" ---------------------------
" Go to mark with window awareness
" ---------------------------
function! s:JumpToMark(mark, window_aware)
    " Check if mark exists
    let l:mark_info = 0
    for m in getmarklist()
        if m.mark[1] ==# a:mark
            let l:mark_info = m
            break
        endif
    endfor
    
    if type(l:mark_info) == type({})
        let l:target_bufnr = l:mark_info.pos[0]
        let l:target_file = bufname(l:target_bufnr)
        
        if a:window_aware && l:target_file != ''
            " Check if file is open in another window
            let l:target_winnr = s:FindWindowWithFile(l:target_file)
            if l:target_winnr > 0 && l:target_winnr != winnr()
                " Switch to that window
                execute l:target_winnr . 'wincmd w'
                " Go to the mark in that window
                execute "normal! '" . a:mark
                redraw | echo "Went to mark " . a:mark . " in window " . l:target_winnr
                return 1
            endif
        endif
        
        " Normal jump (same window)
        silent! execute "normal! '" . a:mark
        redraw | echo "Went to mark " . a:mark
        return 1
    endif
    
    return 0
endfunction

" ---------------------------
" Go to specific mark
" ---------------------------
function! FlagGo(...)
    " Check for window_aware flag (second argument), default to 1 (window-aware)
    let l:window_aware = (a:0 >= 2) ? a:2 : 1
    
    if a:0 == 0 || (a:0 == 1 && a:1 == '')
        " No argument - toggle between last two marks
        if len(g:flag_go_history) >= 2
            " Check if both marks still exist
            let l:mark1_exists = 0
            let l:mark2_exists = 0
            for m in getmarklist()
                if m.mark[1] ==# g:flag_go_history[0]
                    let l:mark1_exists = 1
                endif
                if m.mark[1] ==# g:flag_go_history[1]
                    let l:mark2_exists = 1
                endif
            endfor
            
            if l:mark1_exists && l:mark2_exists
                " Swap last two entries
                let l:temp = g:flag_go_history[0]
                let g:flag_go_history[0] = g:flag_go_history[1]
                let g:flag_go_history[1] = l:temp
                " Go to the new first entry
                call s:JumpToMark(g:flag_go_history[0], l:window_aware)
            else
                " Clean up non-existent marks from history
                let g:flag_go_history = []
                echo "Jump history marks no longer exist"
            endif
        elseif len(g:flag_go_history) == 1
            " Check if the single mark exists
            let l:mark_exists = 0
            for m in getmarklist()
                if m.mark[1] ==# g:flag_go_history[0]
                    let l:mark_exists = 1
                    break
                endif
            endfor
            
            if l:mark_exists
                call s:JumpToMark(g:flag_go_history[0], l:window_aware)
            else
                let g:flag_go_history = []
                echo "Mark " . g:flag_go_history[0] . " no longer exists"
            endif
        else
            " No history - try to go to any existing mark
            call s:CollectMarks()
            if !empty(g:flag_marks)
                let l:first_mark = g:flag_marks[0].mark
                call FlagGo(l:first_mark, l:window_aware)
            else
                echo "No marks set"
            endif
        endif
    else
        " Go to specific mark
        let l:mark = toupper(a:1)
        if l:mark =~# '^[A-Z]$'
            " Check if mark exists
            let l:mark_exists = 0
            for m in getmarklist()
                if m.mark[1] ==# l:mark
                    let l:mark_exists = 1
                    break
                endif
            endfor
            
            if l:mark_exists
                " Update jump history
                if empty(g:flag_go_history)
                    " First mark in history
                    call add(g:flag_go_history, l:mark)
                elseif len(g:flag_go_history) == 1
                    if g:flag_go_history[0] != l:mark
                        " Add second mark
                        call insert(g:flag_go_history, l:mark, 0)
                    endif
                else
                    " We have 2 marks in history
                    if g:flag_go_history[0] != l:mark
                        " Replace oldest with current
                        let g:flag_go_history[1] = g:flag_go_history[0]
                        let g:flag_go_history[0] = l:mark
                    endif
                endif
                
                if !s:JumpToMark(l:mark, l:window_aware)
                    echo "Failed to go to mark " . l:mark
                endif
            else
                echo "Mark " . l:mark . " not set"
            endif
        else
            echo "Invalid mark: " . a:1
        endif
    endif
endfunction

" ---------------------------
" Popup menu: type letter
" ---------------------------
function! s:PopupFilter(winid, key)
    " Convert lowercase to uppercase for marks
    let l:key = toupper(a:key)
    
    " Check if it's a valid mark letter
    if l:key =~# '^[A-Z]$'
        " Find and go to the mark
        for l:m in g:flag_marks
            if l:m.mark ==# l:key
                call popup_close(a:winid)
                " Add to jump history and jump (with window awareness if set)
                " Default is window-aware (1), unless explicitly set to 0
                let l:window_aware = get(g:, 'flag_menu_window_aware', 1)
                silent! call FlagGo(l:key, l:window_aware)
                unlet! g:flag_menu_window_aware  " Clean up
                redraw
                return 1
            endif
        endfor
        " Mark not found
        call popup_close(a:winid)
        echo "Mark " . l:key . " not found"
        return 1
    endif
    
    " Close on Escape or q
    if a:key ==# "\<Esc>" || a:key ==# 'q'
        call popup_close(a:winid)
        return 1
    endif
    
    " Ignore other keys
    return 1
endfunction

function! FlagMenu()
    call s:CollectMarks()
    if empty(g:flag_marks)
        echo "No marks"
        return
    endif

    " Build content for popup
    let l:content = []
    call add(l:content, ' Key │ File            │ Line │ Preview')
    call add(l:content, '─────┼─────────────────┼──────┼────────────────────────────────')
    
    for l:m in g:flag_marks
        " Only show uppercase marks A-Z
        if l:m.mark =~# '^[A-Z]$'
            let l:file_short = fnamemodify(l:m.file, ":t")
            " Ensure file name fits in column
            if len(l:file_short) > 16
                let l:file_short = strpart(l:file_short, 0, 13) . '...'
            endif
            " Get line preview
            let l:preview = s:GetLinePreview(l:m.file, str2nr(l:m.line))
            " Show lowercase letter for user to press
            let l:lower_key = tolower(l:m.mark)
            let l:line_text = printf("  %s  │ %-16s│ %4s │ %s", l:lower_key, l:file_short, l:m.line, l:preview)
            call add(l:content, l:line_text)
        endif
    endfor
    
    call add(l:content, '')
    call add(l:content, ' Press a-z to jump, Esc/q to close')
    
    " Create popup
    let l:opts = {
        \ 'filter': 's:PopupFilter',
        \ 'title': ' Global Marks ',
        \ 'border': [],
        \ 'padding': [0, 1, 0, 1],
        \ 'pos': 'center',
        \ 'mapping': 0,
        \ 'highlight': 'Normal'
        \ }
    
    call popup_create(l:content, l:opts)
endfunction

" ---------------------------
" Debug function
" ---------------------------
function! s:DebugMarks()
    let l:current_file = expand('%:p')
    echo "=== Current State ==="
    echo "Current file: '" . l:current_file . "'"
    echo "Current line: " . line('.')
    echo ""
    echo "=== File Matching Test ==="
    for m in g:flag_marks
        let l:result = s:FilesMatch(l:current_file, m.file)
        echo "  Mark " . m.mark . " @ line " . m.line . ": " . (l:result ? "MATCH" : "NO MATCH")
        echo "    Mark file: '" . m.file . "'"
        if !l:result
            echo "    Current:   '" . l:current_file . "'"
            echo "    Mark full: '" . fnamemodify(m.file, ':p') . "'"
        endif
    endfor
    echo ""
    echo "=== All Open Buffers ==="
    for l:buf in range(1, bufnr('$'))
        if bufexists(l:buf) && bufname(l:buf) != ''
            echo "  Buffer " . l:buf . ": '" . bufname(l:buf) . "'"
        endif
    endfor
    echo ""
    echo "=== Buffers with Signs ==="
    let l:found_signs = 0
    for l:buf in range(1, bufnr('$'))
        if bufexists(l:buf)
            let l:signs = sign_getplaced(l:buf, {'group': 'FlagMarks'})
            if !empty(l:signs) && !empty(l:signs[0].signs)
                echo "  Buffer " . l:buf . " (" . bufname(l:buf) . "): " . len(l:signs[0].signs) . " signs"
                let l:found_signs = 1
            endif
        endif
    endfor
    if !l:found_signs
        echo "  No signs found in any buffer"
    endif
endfunction

" ---------------------------
" Commands
" ---------------------------
command! FlagAdd call FlagAdd()
command! FlagDelete call FlagDelete()
command! FlagNext call FlagNext()
command! FlagPrev call FlagPrev()
command! FlagClearFile call FlagClearFile()
command! FlagClearAll call FlagClearAll()
command! FlagList call FlagList()
command! FlagMenu call FlagMenu()
command! FlagDebug call s:DebugMarks()
command! FlagToggle call FlagToggle()
command! -nargs=* FlagGo call FlagGo(<f-args>)
command! -nargs=? FlagGoSame call FlagGoSame(<f-args>)
command! FlagNextSame call FlagNextSame()
command! FlagPrevSame call FlagPrevSame()
command! FlagMenuSame call FlagMenuSame()
command! FlagMenuWindow call FlagMenuWindow()
command! FlagQuick call FlagQuick()

" ---------------------------
" Keymaps
" ---------------------------
nnoremap <silent> ma :FlagAdd<CR>
nnoremap <silent> md :FlagDelete<CR>
nnoremap <silent> mn :FlagNext<CR>
nnoremap <silent> mp :FlagPrev<CR>
nnoremap <silent> mc :FlagClearFile<CR>
nnoremap <silent> mC :FlagClearAll<CR>
nnoremap <silent> ml :FlagList<CR>
nnoremap <silent> mt :FlagToggle<CR>
nnoremap <silent> mq :FlagQuick<CR>

" Window-aware mappings (lowercase m - default behavior)
nnoremap <silent> mm :FlagGo<CR>
nnoremap <silent> mn :FlagNext<CR>
nnoremap <silent> mp :FlagPrev<CR>
nnoremap <silent> <leader>m :FlagMenuWindow<CR>

" Window-aware go to specific marks
for s:i in range(char2nr('a'), char2nr('z'))
    let s:letter = nr2char(s:i)
    execute 'nnoremap <silent> mg' . s:letter . ' :FlagGo ' . s:letter . '<CR>'
endfor

" Same-window mappings (uppercase M - force same window)
nnoremap <silent> Mm :FlagGoSame<CR>
nnoremap <silent> Mn :FlagNextSame<CR>
nnoremap <silent> Mp :FlagPrevSame<CR>
nnoremap <silent> <leader>M :FlagMenuSame<CR>

" Same-window go to specific marks
for s:i in range(char2nr('a'), char2nr('z'))
    let s:letter = nr2char(s:i)
    execute 'nnoremap <silent> Mg' . s:letter . ' :FlagGoSame ' . s:letter . '<CR>'
endfor

" ---------------------------
" Auto-update signs on buffer enter
" ---------------------------
augroup FlagMarksAutoUpdate
    autocmd!
    autocmd BufEnter,BufRead,BufWritePost * silent! call s:CollectMarks()
    autocmd VimEnter * silent! call s:InitSigns() | silent! call s:CollectMarks()
augroup END

