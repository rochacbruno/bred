# Desired functionality

By sourcing `mapdocs.vim` it adds the following commands:

## `Doc`

This can be used to add annotation to mappings. For example:

Syntax: `Doc 'Description' 'Category'`

```vim
nnoremap <leader>ff :Telescope find_files<CR>:Doc 'Find files using Telescope' 'files'
nnoremap <leader>fg :Telescope live_grep<CR>:Doc 'Live grep using Telescope' 'files'
nnoremap <leader>fb :Telescope buffers<CR>:Doc 'List open buffers using Telescope' 'files'

nnoremap <leader>gc :Git commit<CR>:Doc 'Commit changes using Git'
" a description and an optional category to the last defined mapping. For example, in the above code snippet, the mapping `<leader>ff` will have the description "Find files using Telescope" and belong to the category "files". The mapping `<leader>gc` will have the description "Commit changes using Git" and no category, so gc is a top level mapping.
```

The `Doc` will take the description and category and store in a global table `g:mapdocs` in the following format:

```vim
mapdocs = {}
mapdocs.n = {}
mapdocs.n['gc'] = "Commit changes using Git"
mapdocs.n['files'] = {}
mapdocs.n['files']['ff'] = "Find files using Telescope"
mapdocs.n['files']['fg'] = "Live grep using Telescope"
mapdocs.n['files']['fb'] = "List open buffers using Telescope"
```

The `Doc` command should have no effect on the actual mapping, it should just store the documentation, it must not interfere with the mapping itself, so if the mapping ends in <CR> Doc must also expand CR, 
but id mapping is simply a `nnoremap <C-z> u:Doc 'Undo last change'` it should not interfere with the mapping.

## `ShowDocs`

This command will open a popup window that will take the whole space of the current window and display all the mappings with their descriptions in a nice format, grouped by category if category is provided.
For example, the above mappings will be displayed as:

```
Normal Mode Mappings:
=============================================
gc: Commit changes using Git

files:
=============================================
ff: Find files using Telescope
fg: Live grep using Telescope
fb: List open buffers using Telescope
=============================================
Press enter to close this window.
```

Id the list is too long it should be scrollable using the normal j/k keys, arrows, PageUp/PageDown keys or mouse wheel if mouse is enabled.


If during the display of the mappings the user presses `q` or `Esc` the window should close.
However if user types any of the mappings displayed in the window, the windows should close and the mapping should be executed.
The window should also close if user presses `Enter` key.

## `BufferDocs`

This command will do the same as `ShowDocs` but instead of popping a windows it will open a new buffer in a vertical split on the right side of the current window.
The buffer will be read-only and will display the mappings in the same format as `ShowDocs`.
The buffer should be named `*Mapping Docs*` and should be listed in the buffer list.
The buffer should be closed when user presses `q` or `Esc` or `Enter` key.

This command accepts a single optional argument which can be either `left`, `right`, `top` or `bottom` which will open the buffer in a vertical split on the left or right side of the current window or in a horizontal split on the top or bottom of the current window.
If no argument is provided it will default to `right`.
