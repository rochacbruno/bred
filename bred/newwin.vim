vim9script

# Create a new window in the largest window area
# and open it vertically if the current window is wider than it is tall.

def Vertical(): string
    if winwidth(winnr()) * 0.3 > winheight(winnr())
        return "vertical"
    else
        return ""
    endif
enddef

# Find the window with largest size
def FindLargestWindow(): number
    var max_size = 0
    var cur_winnr = winnr()
    var max_winnr = winnr()
    for w in range(1, winnr("$"))
        var size = winheight(w) + winwidth(w)
        if size > max_size
            max_size = size
            max_winnr = w
        elseif size == max_size && w == cur_winnr
            max_winnr = cur_winnr
        endif
    endfor
    return max_winnr
enddef

def New()
    exe $":{FindLargestWindow()} wincmd w"
    exe $"{Vertical()} new"
enddef

nnoremap <C-w>n <scriptcmd>New()<CR>
Nmap 'new empty|Windows' <C-w>n
