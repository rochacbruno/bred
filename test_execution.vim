" Test both types of mappings
source mapdocs.vim

" Create a new mapping with RHS
Nmap 'Echo hello|test' <leader>h :echo 'Hello from created mapping!'<CR>

" Document existing Vim built-in (no RHS)
Nmap 'Undo last change' u
Nmap 'Join lines' J

" Show what we have
echo "Mappings in g:mapdocs:"
echo g:mapdocs
echo ""
echo "Created mappings tracked in g:mapdocs_created:"
echo g:mapdocs_created