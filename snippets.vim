" Abbreviation completion
" TIP: Use <C-x><C-u> in insert mode to trigger the completion
" Example: Type 'teh' and press <C-x><C-u> to get 'the'
" To cancel abbreviation press C-v before typing the space
" e.g: teh<C-v><Space> will result in 'teh ' instead of 'the '

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


" Global abbreviations
iab teh the
iab adress address
iab recieve receive
iab definately definitely
iab occured occurred
iab seperately separately
iab lenght length
iab Lenght Length
iab widht width
iab Widht Width
iab heigth height
iab Heigth Height
iab enviroment environment
iab Enviroment Environment
iab dont don't
iab Dont Don't
iab doesnt doesn't
iab Doesnt Doesn't
iab isnt isn't
iab Isnt Isn't
iab wasnt wasn't
iab Wasnt Wasn't
iab couldnt couldn't
iab Couldnt Couldn't
iab shouldnt shouldn't
iab Shouldnt Shouldn't
iab wouldnt wouldn't
iab Wouldnt Wouldn't
iab wont won't
iab Wont Won't
iab cant can't
iab Cant Can't
iab sicne since
iab descriptoin description
iab rochabruno rochacbruno

" pt 
iab neh né
iab soh só
iab ja já

" " load custom abbreviations if the file exists
if filereadable(expand("~/.vim/custom.snippets.vim"))
    execute 'source' expand("~/.vim/custom.snippets.vim")
endif
