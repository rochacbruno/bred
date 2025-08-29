" Test file for mapdocs.vim
" Source the mapdocs plugin
source mapdocs.vim

" Clean syntax: Nmap 'description|category' <lhs> <rhs>
" The | separator is optional - if not present, no category

" File operations category
Nmap 'Find files using Telescope|files' <leader>ff :Telescope find_files<CR>
Nmap 'Live grep using Telescope|files' <leader>fg :Telescope live_grep<CR>
Nmap 'List open buffers|files' <leader>fb :Telescope buffers<CR>
Nmap 'File explorer|files' <leader>e :NERDTreeToggle<CR>

" Git operations (no category)  
Nmap 'Commit changes using Git' <leader>gc :Git commit<CR>
Nmap 'Push changes to remote' <leader>gp :Git push<CR>
Nmap 'Show git status' <leader>gs :Git status<CR>

" Window management category
Nmap 'Split window horizontally|windows' <leader>ws :split<CR>
Nmap 'Split window vertically|windows' <leader>wv :vsplit<CR>
Nmap 'Close window|windows' <leader>wc :close<CR>

" Navigation
Nmap 'Go to definition' gd :lua vim.lsp.buf.definition()<CR>
Nmap 'Show hover documentation' K :lua vim.lsp.buf.hover()<CR>

" Test commands
echo "Test mappings defined. You can now test:"
echo "1. :ShowDocs - Popup window (stays open until q/Esc/Enter)"
echo "2. :BufferDocs - Buffer in right split (default)"
echo "3. :BufferDocs left/right/top/bottom - Different positions"
echo ""
echo "In the popup:"
echo "  - Press j/k to scroll"
echo "  - Press q/Esc/Enter to close"
echo "  - Type any mapping key to execute it"
echo ""
echo "Check g:mapdocs variable:"
echo g:mapdocs