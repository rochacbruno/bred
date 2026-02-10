" ===============================================================================
" Go filetype configuration - Debugger mappings (vim-go + Delve)
" ===============================================================================

" Debugger session
Nmap 'Start debugger|Go Debug' <localleader>ds :GoDebugStart<CR>
Nmap 'Start debugger for test|Go Debug' <localleader>dt :GoDebugTestFunc<CR>
Nmap 'Stop debugger|Go Debug' <localleader>dx :GoDebugStop<CR>
Nmap 'Restart debugger|Go Debug' <localleader>dr :GoDebugRestart<CR>

" Debugger navigation
Nmap 'Continue|Go Debug' <localleader>dc :GoDebugContinue<CR>
Nmap 'Step over (next)|Go Debug' <localleader>dn :GoDebugNext<CR>
Nmap 'Step into|Go Debug' <localleader>di :GoDebugStep<CR>
Nmap 'Step out|Go Debug' <localleader>do :GoDebugStepOut<CR>

" Breakpoints
Nmap 'Toggle breakpoint|Go Debug' <localleader>db :GoDebugBreakpoint<CR>

" Inspection
Nmap 'Print variable under cursor|Go Debug' <localleader>dp :GoDebugPrint<CR>
Nmap 'Set debug variable|Go Debug' <localleader>dv :GoDebugSet<space>

" Build and test (non-debug)
Nmap 'Build|Go' <localleader>gb :GoBuild<CR>
Nmap 'Run tests|Go' <localleader>gt :GoTest<CR>
Nmap 'Run test under cursor|Go' <localleader>gT :GoTestFunc<CR>
Nmap 'Toggle coverage|Go' <localleader>gc :GoCoverageToggle<CR>
Nmap 'Add/remove tags|Go' <localleader>ga :GoAddTags<CR>
