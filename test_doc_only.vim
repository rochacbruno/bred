" Test documentation-only feature
source mapdocs.vim

" Document some built-in Vim commands without overriding them
Nmap 'Undo' u
Nmap 'Redo' <C-r>
Nmap 'Next word' w
Nmap 'Previous word' b

" Create a new mapping with RHS
Nmap 'Test mapping' <leader>test :echo 'This is a test'<CR>

" Now check what's in g:mapdocs
echo "Contents of g:mapdocs:"
echo g:mapdocs

" Check if 'u' still works as undo (not overridden)
echo ""
echo "Testing if 'u' still works as undo (should show nothing if not overridden):"
verbose nmap u