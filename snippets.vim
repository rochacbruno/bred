function! GetAbbrevList()
    let l:abbrev_list = []
    redir => l:iab_output
    silent iab
    redir END
    " Parse each line of iab output - format: "i  abbreviation  expansion"
    for line in split(l:iab_output, '\n')
        " Match lines that start with i followed by abbreviation name
        let match = matchstr(line, '^\s*i\s\+\zs\k\+')
        if !empty(match)
            call add(l:abbrev_list, match)
        endif
    endfor
    return l:abbrev_list
endfunction

set completefunc=CompleteAbbrev
function! CompleteAbbrev(findstart, base)
    if a:findstart
        return searchpos('\<\k', 'bcnW', line('.'))[1] - 1
    else
        let s:abbrev_list = GetAbbrevList()
        return filter(copy(s:abbrev_list), 'v:val =~ "^" . a:base')
    endif
endfunction

