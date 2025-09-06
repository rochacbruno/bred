" Abbreviation completion
" TIP: Use <C-x><C-u> in insert mode to trigger the completion
" Example: Type 'teh' and press <C-x><C-u> to get 'the'
" To cancel abbreviation press C-v before typing the space
" e.g: teh<C-v><Space> will result in 'teh ' instead of 'the '

function! GetAbbrevDict()
    let l:abbrev_dict = {}
    redir => l:iab_output
    silent iab
    redir END
    " Parse each line of iab output - format: "i  abbreviation  expansion"
    for line in split(l:iab_output, '\n')
        " Match lines that contain abbreviation and expansion
        let parts = matchlist(line, '^\s*i\s\+\(\k\+\)\s\+\(.\+\)')
        if len(parts) >= 3
            let l:abbrev_dict[parts[1]] = parts[2]
        endif
    endfor
    return l:abbrev_dict
endfunction

set completefunc=CompleteAbbrev
set completeopt=menu,menuone,noinsert,noselect
function! CompleteAbbrev(findstart, base)
    if a:findstart
        " Find the start of the word to complete
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\k'
            let start -= 1
        endwhile
        return start
    else
        let l:abbrev_dict = GetAbbrevDict()
        let l:completions = []
        for [abbrev, expansion] in items(l:abbrev_dict)
            if abbrev =~ '^' . a:base
                call add(l:completions, {
                    \ 'word': abbrev,
                    \ 'menu': '→ ' . expansion
                    \ })
            endif
        endfor
        " Sort completions alphabetically by abbreviation
        return sort(l:completions, {a, b -> a.word == b.word ? 0 : a.word > b.word ? 1 : -1})
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

" tech
iab pyhton python
iab phyton python
iab postgressql postgresql
iab PostgresSQL PostgreSQL 

" pt 
iab neh né
iab soh só
iab ja já

" specific
iab rochabruno rochacbruno


" Lorem ipsum examples
iab lorem1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

iab lorem2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

iab lorem3 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

" python
iab ifn if __name__ == "__main__":
iab ipd __import__('pdb').set_trace()
iab shp #!/usr/bin/env python3

" rust
iab fnn fn () {<CR>}<Up><Right><Right>
iab fnm fn main() {<CR>}<Esc>O
iab prl println!("");<Left><Left><Left>

" load custom abbreviations if the file exists
if filereadable(expand("~/.vim/custom.abbrs.vim"))
    execute 'source' expand("~/.vim/custom.abbrs.vim")
endif
