" claude.vim - Claude AI integration for Vim
" Usage: 
"   Visual mode: Select text, then :<,>Claude or :<,>Claude "additional prompt"
"   The selected text will be sent to Claude and replaced with the response

" Check if the command already exists to avoid redefinition
if exists(":Claude")
  finish
endif

" Configuration - Set the Claude CLI path
" IMPORTANT: Shell aliases don't work in Vim! Use the full path.
" 
" The default assumes Claude is installed in the standard location.
" Override in your .vimrc if installed elsewhere:
"
" let g:claude_path = '/usr/local/bin/claude'
" let g:claude_path = '/opt/claude/bin/claude'
" let g:claude_path = 'anthropic'  " if using anthropic CLI
" let g:claude_path = 'npx claude'  " if using npm package
if !exists('g:claude_path')
  let g:claude_path = expand('$HOME') . '/.claude/local/claude'
endif

" Function to check if Claude CLI is available
function! s:CheckClaudeCLI()
  " Check if the file exists and is executable
  if filereadable(g:claude_path) && executable(g:claude_path)
    return 1
  endif
  " Fallback to which command for non-standard paths
  let l:check_cmd = 'which ' . shellescape(g:claude_path) . ' 2>/dev/null'
  let l:result = system(l:check_cmd)
  if v:shell_error != 0
    return 0
  endif
  return 1
endfunction

" Function to process selected text with Claude
function! s:ProcessWithClaude(start_line, end_line, ...) range
  " Check if Claude CLI is available
  if !s:CheckClaudeCLI()
    echoerr "Claude CLI not found at: " . g:claude_path
    echoerr "Please install Claude or set g:claude_path in your .vimrc"
    echoerr "Example: let g:claude_path = '/path/to/claude'"
    return
  endif
  
  " Get the selected text
  let l:selected_lines = getline(a:start_line, a:end_line)
  let l:selected_text = join(l:selected_lines, "\n")
  
  " Build the base prompt
  let l:base_prompt = '. OUTPUT ONLY THE MODIFIED CODE. NO EXPLANATIONS, NO MARKDOWN, NO CODE BLOCKS, NO BACKTICKS, NO COMMENTS ABOUT WHAT YOU DID, JUST THE RAW CODE ITSELF: '
  
  " Add any additional prompt if provided
  let l:additional_prompt = a:0 > 0 ? join(a:000, ' ') . ' ' : ''
  let l:full_prompt = l:additional_prompt . l:base_prompt . l:selected_text
  
  " Escape the prompt for shell - remove any null characters
  let l:full_prompt = substitute(l:full_prompt, '\%x00', '', 'g')
  let l:escaped_prompt = shellescape(l:full_prompt)
  
  " Call Claude CLI
  let l:cmd = g:claude_path . ' -p ' . l:escaped_prompt
  
  " Show status
  echo "AI is thinking"
  
  let l:result = system(l:cmd)
  
  " Check for errors
  if v:shell_error != 0
    echoerr "Claude command failed with exit code " . v:shell_error
    echoerr "Error output: " . l:result
    echoerr "Command was: " . l:cmd
    return
  endif
  
  " Remove any trailing newline from the result
  let l:result = substitute(l:result, '\n$', '', '')
  
  " Split result into lines
  let l:result_lines = split(l:result, '\n', 1)
  
  " Replace the selected lines with the result
  if len(l:result_lines) > 0
    " Delete the original lines
    execute a:start_line . ',' . a:end_line . 'delete _'
    
    " Insert the new lines
    " Move to the line before where we want to insert (or line 0 if at start)
    let l:insert_line = a:start_line - 1
    
    " Insert each line
    for l:line in l:result_lines
      call append(l:insert_line, l:line)
      let l:insert_line += 1
    endfor
    
    " Move cursor to the beginning of the replaced text
    call cursor(a:start_line, 1)
    
    " Show success message
    echon "DONE!"
  else
    echohl WarningMsg | echo "Claude returned empty response" | echohl None
  endif
endfunction

" Create the command that works with visual selection
command! -range -nargs=* Claude call s:ProcessWithClaude(<line1>, <line2>, <f-args>)

" Command to check Claude CLI availability
command! ClaudeCheck echo s:CheckClaudeCLI() ? "Claude CLI found at: " . g:claude_path : "Claude CLI not found at: " . g:claude_path

" Optional: Add a visual mode mapping for convenience (uncomment if desired)
" vnoremap <leader>c :Claude<CR>
" vnoremap <leader>C :Claude 

" Display load confirmation (optional, comment out if not wanted)
" if !exists('g:claude_vim_silent')
"   if s:CheckClaudeCLI()
"     echo "claude.vim loaded - Using: " . g:claude_path
"   else
"     echohl WarningMsg | echo "claude.vim loaded but Claude CLI not found at: " . g:claude_path | echohl None
"     echohl WarningMsg | echo "Set g:claude_path in .vimrc or install Claude to ~/.claude/local/claude" | echohl None
"   endif
" endif
