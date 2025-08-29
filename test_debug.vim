" Debug test for <C-w>v
source mapdocs.vim

" Document the built-in mapping
Nmap 'Split window vertically|windows' <C-w>v

" Show what's stored
echo "Stored in g:mapdocs:"
echo g:mapdocs

" Test if the actual key sequence works
echo ""
echo "Testing if <C-w>v works directly (should split):"
" This should work if typed manually