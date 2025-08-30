╔══════════════════════════════════════╗
║              Vim $VIMVERSION                 ║
║                                      ║
║  'spacebar'     to see key mappings  ║
║  'i'            to start editing     ║
║  ':e filename'  to open a file       ║
║  ':q'           to exit Vim          ║
╚══════════════════════════════════════╝
Quick Reference:
────────────────────────────────────────────
• spc            Open command menu
• spc + h        Mappings documentation
• spc + e        Open file explorer
• spc + ff       Find files
• spc + fr       Search text in files
• spc + fg       Find in git files
• spc + fb       List open buffers
• spc + fl       Search text in buffer
• spc + fh       Recent files
• [q or ]q       Next/Previous buffer
• Ctrl + /       Comment line
• Ctrl + s       Save file
• Ctrl + z       Undo
────────────────────────────────────────────
This is a VIM 9 config by:
Bruno Cesar Rocha | https://rochacbruno.com
Docs: https://github.com/rochacbruno/vim9
Config: $MYVIMRC
Date: $DATE
────────────────────────────────────────────
Press enter for more info >>>

    Plugins: >>>
    ────────────────────────────────────────

    defined on `~/.vim/plugins.vim` file.
    Plugins are managed by vim-plug

    Enabled plugins:

    - lsp.vim " LSP configuration
    - indentLine " Show indentation line 
    - vim-devicons " Cool icons on status bar
    - vim-mistfly-statusline " Status line
    - matchit " Improved % motions
    - vim-diminactive " Set unfocused buffers to dim
    - vim-gtfo " Open files in external apps
    - vim-zoom " Zoom current window
    - mru " List recent files
    - targets.vim " More text objects 
    - vim-rhubarb "  GitHub support for fugitive.vim
    - undotree "  Visualize undo history
    - vim-indent-object "  Text objects for indentations
    - vim-eunuch "  Helper commands for UNIX files
    - vim-table-mode "  Create tables and align tables
    - vim-clap "  Fuzzy finder alternative to fzf
    - copilot.vim "  GitHub Copilot integration
    - vim-repeat " Repeat plugin commands with .
    - vim-commentary "  Comment stuff out
    - goyo.vim "  Distraction-free writing
    - visual-split.vim "  Easily resize windows based on visual selection
    - vim-easymotion "  Jump to any word in the visible buffer
    - vim-sleuth "  Detect tabstop and shiftwidth automatically
    - Colorizer "  Color highlighter
    - vCoolor.vim "  Color picker
    - git-messenger.vim "  Show git commit messages under the cursor
    - vim-rest-console "  REST client
    - vim-sensible "  Basic default settings for Vim
    - vim-gitgutter "  Show git diff in the gutter
    - vim-choosewin "  Easily switch between windows
    - context.vim "  Show code context at the top of the window
    - vim-markdown-composer "  Markdown live preview
    - far.vim "  Find and replace across multiple files
    - vim-mkdir "  Create missing directories automatically
    - vim-subversive "  Enhanced substitute command
    - vim-yoink "  Clipboard history
    - vim-fugitive "  Git integration
    - scratch.vim "  Easily create and manage scratch buffers
    - vim-speeddating "  Increment/decrement dates, times, and more
    - vim-highlightedyank "  Highlight yanked text
    - ale "  Asynchronous linting and fixing
    - vim-cutlass "  Make x, X, d, D, c, C, s and S behave more like normal text editors
    - fzf.vim "  Fuzzy finder
    - vim-visual-multi "  Multiple cursors
    - vim-over "  Find Replace with preview
    - vim-abolish "  Smart case manipulation
    - vim-illuminate "  Highlight other uses of the word under the cursor
    - vim-surround "  Surround text with parentheses, brackets, quotes, etc.
    - auto-pairs "  Automatically insert matching parentheses, brackets, quotes, etc.
    - vim-bbye "  Better buffer closing
    - bufferize.vim "  Put command output on a buffer

    <<< add your plugins on `~/.vim/custom.plugins.vim`

Built-in functionalities >>>
────────────────────────────────────────

    Flag Marker System >>>
    ────────────────────────────────────────

        FlagMarks allow to add global marks on files
        and navigate between them easily.

        - ma " Add mark on current line
        - md " Delete mark on current line
        - mc " Clear all marks on current file
        - mC " Clear all marks on all files
        - mn " Go to next mark
        - mp " Go to previous mark
        - ml " List all marks in quickfix window
        - spc + m "Open marks window and navigate to them
        - mm " Go to previous visited mark
        - mga " Go to mark A
        - mgb " Go to mark B
        ... up to z

       <<<


    MapDocs for mapping auto documentation >>>
    ────────────────────────────────────────

        Using the Nmap, Imap, Vmap, Xmap, Cmap, Tmap etc
        will add the mappings to the documentation then
        to see the docs just press:

        - spc + h " Open mappings documentation on the right side
        - spc     " Open mappings menu

        It is possible to document existing mappings by omiting the RHS

        Usage: [M]map 'Description|Category' lhs [rhs]

        Example:
        ---------------------------------------------───
        " Document existing mapping
        Nmap 'Do Something|Category' <leader>x
        " Add a new maooping with documentation
        Nmap 'Do Something|Category' <leader>y :echo "Hello"<CR>

        Commands:
        -------------------------------------------
        - :ShowDocs     " Open mappings menu
        - :BufferDocs   " Open mappings on a buffer 

        <<<
    
    <<< add your functionalities on `~/.vim/custom.functions.vim`

Customizations >>>
────────────────────────────────────────


   - When git editor is vim then it will start in insert mode,
     then typing esc+q will save and close the editor,
     typing esc+a will abort the commit.
   
   - Ctrl+S and Ctrl+z are mapped to save and undo respectively
     in normal and insert modes to make it consistent with other apps.

   - 'spacebar' is the leader key and opens the command menu.

   - Emacs style navigation are mapped on insert and command mode.

   - Q is disabled to avoid entering ex mode by mistake.

   - Numbers are relative in normal mode but absolute in insert mode.

   - Sessions are saved on the Session.vim when exiting vim
     and loaded automatically when vim is started without files.

   - When opening multiple files (up to 4) they are arranged
     automatically in an optimal grid layout. 

   - When opening vim without files the splash screen is shown
      with quick reference and useful info.

   - There is a resize mode that allows resizing windows
     using hjkl or arrow keys. Entering resize mode is done
     by pressing <leader>rs and exiting it by pressing Esc.

   - .viminfo file is searched upwards for a project-specific
     .viminfo file or defaults to ~/.vim/viminfo (this file is used
        to store command history, search history, marks, registers etc).

   <<< add your customizations on `~/.vim/custom.options.vim`

<<< Enjoy!
