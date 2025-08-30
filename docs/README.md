# RochaCBruno's Vim 9 Configuration

A modern, modular Vim 9.1 configuration with LSP support, intelligent plugins, and a custom global marks management system.

> [!WARNING]
> This configuration is for Vim 9+ only, NOT for Neovim or older versions of Vim.

> [!INFO]
> This configuration does not affect neovim as it is located in `~/.vim` and not in `~/.config/nvim`, as long as you don't symlink it and don have a ~/.vimrc it must allow you to use both Vim and Neovim with different configurations.


**If you are wondering why Vim 9 and not Neovim, check my blog post: [Why I am using Vim 9](https://rochacbruno.com/why-i-use-vim9.html)**

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Architecture](#architecture)
- [Key Mappings](#key-mappings)
- [Plugins](#plugins)
- [Custom Functions](#custom-functions)
- [Language Server Protocol](#language-server-protocol)
- [FlagMarks System](#flagmarks-system)
- [Configuration Files](#configuration-files)
- [Customization](#customization)

## Features

- **Modular Configuration**: Clean separation of concerns across multiple files
- **Language Server Protocol**: Full LSP support for multiple languages
- **Smart Plugin Management**: Auto-installation of vim-plug and plugins
- **Interactive Mapping Documentation**: MapDocs system with searchable FZF interface (press `<Space>` alone for menu or `<Space>h` for buffer docs)
- **Custom Marks System**: Enhanced global marks (FlagMarks) with visual indicators and window-aware navigation
- **Welcome Splash Screen**: Customizable startup screen with quick access to key functions
- **GitHub Copilot**: AI-powered code completion
- **Fuzzy Finding**: Fast file and text search with FZF
- **Git Integration**: Comprehensive Git support with Fugitive
- **Multi-Cursor Editing**: Visual Multi for simultaneous edits
- **Auto-Session**: Automatic session save/restore
- **Distraction-Free Mode**: Goyo for focused writing
- **Smart Indentation**: Auto-detect and adapt to file's indentation

## Requirements

- Vim 9 or higher
- Git
- curl (for plugin installation)
- A terminal that supports 256 colors
- ripgrep (for text searching)
- fzf (for fuzzy finding)
- Node.js and npm (for some LSP servers)
- A Nerd Font (for icons)
- Rust (for some plugins)

## Installation

<details>
<summary>Ensure you have all dependencies installed.</summary>


- **Install dependencies:**
   ```bash
   # macOS (using Homebrew)
   brew install fzf ripgrep node rustup git curl
   rustup install stable

   # Ubuntu/Debian
   sudo apt install fzf ripgrep nodejs npm rustup git curl
   rustup install stable
   
   # Arch Linux
   sudo pacman -S fzf ripgrep nodejs npm rustup git curl
   rustup install stable
   ```

- **Install language servers (optional):**
   ```bash
   # Python
   npm install -g pyright
   
   # Bash
   npm install -g bash-language-server
   
   # YAML
   npm install -g yaml-language-server
   
   # Rust
   rustup component add rust-analyzer
   ```

</details>



1. **Backup your existing Vim configuration:**
   ```bash
   mv ~/.vim ~/.vim_backup
   mv ~/.vimrc ~/.vimrc_backup
   ```

2. **Clone this repository:**
   ```bash
   git clone https://github.com/rochacbruno/vim9 ~/.vim
   ```

3. **Install plugins:**
   ```bash
   vim +PlugInstall +qall
   ```


## Architecture

The configuration is split into logical modules for maintainability:

| File | Purpose |
|------|---------|
| `vimrc` | Main entry point, loads all modules |
| `options.vim` | Core Vim settings and options |
| `plugins.vim` | Plugin declarations and configuration |
| `mappings.vim` | Custom key mappings |
| `functions.vim` | Utility functions |
| `commands.vim` | Custom commands and autocommands |
| `lsp.vim` | Language Server Protocol configuration |
| `flagmarks.vim` | Custom global marks system |
| `mapdocs.vim` | Interactive mapping documentation system |
| `splash.vim` | Welcome screen configuration |
| `custom_colors.vim` | Color scheme adjustments |

## New Features

### 📚 MapDocs - Interactive Mapping Documentation

The MapDocs system provides an interactive, searchable interface for all key mappings:

- **Interactive Menu**: Press `<Space>` alone to open FZF-powered mapping search
- **Buffer Documentation**: Use `<Space>h` or `:BufferDocs` to view all mappings in a buffer
- **Categorized Mappings**: All mappings are organized by category and mode
- **Execute from Menu**: Select any mapping in the menu to execute it immediately
- **Mode Filtering**: View mappings for specific modes with `:ShowDocs [modes]`
- **Self-Documenting**: Mappings defined with `Nmap`, `Imap`, etc. automatically appear in docs

### 🎨 Splash Screen

A customizable welcome screen that appears when starting Vim without arguments:

- **Quick Start Guide**: Shows essential commands and tips
- **Configuration Info**: Displays Vim version and configuration path
- **Foldable Sections**: Organized content with fold markers (`>>>` and `<<<`)
- **Auto-Dismiss**: Disappears when you start editing or open a file
- **Customizable**: Edit `~/.vim/splash_message.vim` to personalize

### 🚩 FlagMarks - Enhanced Global Marks

A powerful replacement for Vim's built-in marks with visual indicators and smart navigation:

- **Visual Indicators**: Shows marks in the sign column as `>A`, `>B`, etc.
- **Window-Aware**: Automatically switches windows when jumping to marks
- **Interactive Menu**: `<Space>m` opens a searchable menu of all marks
- **Quick Toggle**: `mm` jumps between the last two marks
- **Persistent**: Marks are saved across Vim sessions

## Quick Reference Cheatsheet

> **Leader Key**: `<Space>` (spacebar)  
> **Interactive Help**: Press `<Space>` alone to open the mapping documentation menu  
> **Buffer Docs**: `<Space>h` to view all mappings in a buffer  
> **Commands**: `:ShowDocs` or `:BufferDocs` for mapping documentation

### 🎯 Most Used Commands

| Key | Action | Key | Action |
|-----|--------|-----|--------|
| `<Space>` | Open mapping menu | `<Space>w` | Save file |
| `<Space>ff` | Find files (FZF) | `<Space>fr` | Search text (ripgrep) |
| `<Space>fb` | List buffers | `<Space>e` | File explorer |
| `<Space>a` | LSP code actions | `<Space>d` | Go to definition |
| `<C-d>` | Multi-cursor select | `gcc` | Toggle comment |
| `ma` | Add flagmark | `mm` | Jump to last mark |
| `<Space>m` | Flagmarks menu | `<Tab>` | Accept Copilot |

## Complete Key Mappings Reference

### 📁 File Navigation & Search

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>ff` | `:Files` | Fuzzy find files |
| `<Space>fr` | `:Rg` | Search text with ripgrep |
| `<Space>fb` | `:Buffers` | List buffers |
| `<Space>fl` | `:Lines` | Search lines in current buffer |
| `<Space>fg` | `:GFiles` | Git files |
| `<Space>e` | `:Lexplore` | File explorer (left) |
| `<Space>E` | `:Vexplore` | File explorer (vertical) |
| `gf` | Go to file | Open file under cursor |
| `<C-w>f` | Split & open | Split window and open file under cursor |

### 💾 File Operations

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>w` | `:write` | Save file |
| `<Space>q` | `:quit` | Quit |
| `<Space>x` | `:xit` | Save and quit |
| `<CR>` | `:nohlsearch` | Clear search highlighting (Enter key) |
| `<Space><Space>so` | `:source ~/.vim/vimrc` | Reload configuration |
| `<Space><Space>x` | `:!chmod +x %` | Make file executable |
| `<C-s>` | `:update` | Save (all modes) |
| `<C-z>` | Undo | Undo (all modes) |
| `<Space>tw` | Remove trailing | Remove trailing whitespace |

### 📑 Buffer Management

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>bl` | List buffers | List and select buffer |
| `<Space>fb` | FZF buffers | Fuzzy search buffers |
| `[q` | Previous buffer | Navigate backward |
| `]q` | Next buffer | Navigate forward |
| `<Space>1-9` | Jump to buffer | Quick buffer access (1-9) |
| `<Space><Tab>` | Toggle buffers | Switch between two buffers |
| `bh` | Delete hidden | Clean up hidden buffers |
| `<Space>bd` | Delete buffer | Delete current buffer (save first) |
| `<Space>bx` | Force delete | Delete buffer without saving |

### 🪟 Window & Split Management

| Key | Action | Description |
|-----|--------|-------------|
| `<C-w>h/j/k/l` | Navigate | Move between windows |
| `<C-w>s` | Split horizontal | Create horizontal split |
| `<C-w>v` | Split vertical | Create vertical split |
| `<C-w>c` | Close window | Close current window |
| `<C-w>o` | Only window | Close all other windows |
| `<C-w>=` | Equalize | Make all windows equal size |
| `<Space>=` | Increase height | Make window taller |
| `<Space>-` | Decrease height | Make window shorter |
| `<Space>>` | Increase width | Make window wider |
| `<Space><` | Decrease width | Make window narrower |
| `<Space>rs` | Resize mode | Interactive resizing (arrows to resize) |
| `-` | Window chooser | Interactive window selection |
| `<C-w>m` | Zoom toggle | Maximize/restore window |
| `<C-w>g` | Goyo mode | Distraction-free writing |
| `<C-w>gr` | Visual resize | Resize to selection |
| `<C-w>gss` | Visual split | Split with selection |

### 🧠 Language Server (LSP)

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>a` | Code actions | Show available actions |
| `<Space>d` | Go to definition | Jump to declaration |
| `<Space>k` | Hover info | Show documentation |
| `:LspDiagNext` | Next diagnostic | Jump to next error/warning |
| `:LspDiagPrev` | Previous diagnostic | Jump to previous error/warning |
| `:LspServers` | Show servers | List configured LSP servers |

### 🔀 Git Integration

| Key | Action | Description |
|-----|--------|-------------|
| `<C-g>m` | Git messenger | Show commit under cursor |
| `:Gstatus` | Git status | Fugitive status window |
| `:Gblame` | Git blame | Show line authors |
| `:Gdiff` | Git diff | Compare changes |
| `:GBrowse` | Open in GitHub | View file on GitHub |

### ✏️ Multi-Cursor Editing (Visual-Multi)

| Key | Action | Description |
|-----|--------|-------------|
| `<C-d>` | Select word | Add cursor at word under cursor |
| `n/N` | Next/Previous | Navigate occurrences |
| `[/]` | Cursor navigation | Move between cursors |
| `q` | Skip occurrence | Skip and continue |
| `Q` | Remove cursor | Delete current cursor |
| `\\A` | Select all | Select all occurrences |
| `<C-LeftMouse>` | Add cursor | Add cursor with mouse |
| `<C-RightMouse>` | Select word | Select word with mouse |
| `<M-C-RightMouse>` | Column select | Column selection with mouse |

### ✂️ Text Editing & Manipulation

| Key | Action | Description |
|-----|--------|-------------|
| `gcc` | Comment line | Toggle line comment |
| `gc{motion}` | Comment motion | Comment selection |
| `<C-/>` or `<C-_>` | Comment toggle | Toggle comment (all modes) |
| `gcu` | Uncomment | Uncomment adjacent lines |
| `<Space>re` | Replace word | Replace word under cursor globally |
| `x` | Cut | Delete to register (vim-cutlass) |
| `xx` | Cut line | Delete entire line to register |
| `X` | Cut to EOL | Delete to end of line |
| `<` / `>` | Indent | Indent left/right (stays in visual) |
| `p` | Smart paste | Paste without yanking replaced text (visual) |

### 🔄 Surround Operations

| Key | Action | Description |
|-----|--------|-------------|
| `ysiw` + delimiter | Surround word | Add surround to inner word |
| `yss` + delimiter | Surround line | Add surround to entire line |
| `ds` + delimiter | Delete surround | Remove surrounding delimiters |
| `cs` + old + new | Change surround | Change surrounding delimiters |
| `S` + delimiter | Visual surround | Surround selection (visual mode) |

### 🔁 Substitution (Subversive)

| Key | Action | Description |
|-----|--------|-------------|
| `s{motion}` | Substitute | Replace motion with yanked text |
| `ss` | Substitute line | Replace line with yanked text |
| `S` | Substitute to EOL | Replace to end of line |
| `<Space>s` | Prompted substitute | Replace with prompted text |
| `<Space>ss` | Word substitute | Replace word across buffer |
| `<Space><Space>s` | Smart case substitute | Smart case replacement |

### ↕️ Line Movement

| Key | Action | Description |
|-----|--------|-------------|
| `<M-j>` / `<M-Down>` | Move down | Move line/selection down |
| `<M-k>` / `<M-Up>` | Move up | Move line/selection up |

### 🖥️ Terminal & External Tools

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>c` | Open terminal | Bottom terminal |
| `<C-v><Esc>` | Exit terminal | Return to normal mode |
| `got` | Terminal here | Open terminal in file's directory |
| `gof` | File manager | Open file manager in file's directory |

### 🏷️ Tab Management

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>tn` | New tab | Create new tab |
| `<Space>tc` | Close tab | Close current tab |
| `<Space>to` | Tab only | Close other tabs |
| `<Space>tl` | Next tab | Go to next tab |
| `<Space>th` | Previous tab | Go to previous tab |
| `<C-w>T` | Window to tab | Move current window to new tab |

### 📋 Yank History (Yoink)

| Key | Action | Description |
|-----|--------|-------------|
| `p` / `P` | Smart paste | Paste with yank history |
| `<C-n>` | Previous yank | Cycle to previous yank after paste |
| `<C-p>` | Next yank | Cycle to next yank after paste |
| `[y` / `]y` | Browse yanks | Navigate yank history |
| `y` | Yank preserve | Yank without moving cursor |

### 🎨 Visual Enhancements

| Key | Action | Description |
|-----|--------|-------------|
| `gs` | Scratch buffer | Open scratch buffer |
| `<M-w>` | Color picker | Open color picker (normal) |
| `<M-c>` | Color picker | Open color picker (insert) |
| `<Space>tm` | Table mode | Toggle table formatting mode |

### 🤖 GitHub Copilot

| Key | Action | Description |
|-----|--------|-------------|
| `<Tab>` | Accept | Accept suggestion |
| `<M-]>` | Next suggestion | Cycle to next suggestion |
| `<M-[>` | Previous suggestion | Cycle to previous suggestion |
| `<M-\>` | Request | Request suggestion |
| `<M-Right>` | Accept word | Accept next word |
| `<M-C-Right>` | Accept line | Accept next line |

### 🎯 EasyMotion

| Key | Action | Description |
|-----|--------|-------------|
| `<Space><Space>` + motion | Trigger | Activate EasyMotion for any motion |
| `<Space><Space>w` | Word forward | Jump to word forward |
| `<Space><Space>b` | Word backward | Jump to word backward |
| `<Space><Space>f` + char | Find char | Jump to character |

### 🔧 Auto Pairs

| Key | Action | Description |
|-----|--------|-------------|
| `<M-b>` | Back insert | Back insert pair |
| `<M-n>` | Jump next | Jump to next closed pair |
| `<M-p>` | Toggle | Toggle auto pairs on/off |

## Plugins

### 🎯 Core Enhancements

| Plugin | Description | Key Features |
|--------|-------------|--------------|
| **vim-sensible** | Better defaults | Universal settings |
| **matchit** | Enhanced % matching | Jump pairs, HTML tags |
| **vim-sleuth** | Auto indentation | Detect file style |
| **vim-repeat** | Repeat plugin maps | Dot repeat for plugins |

### 🔍 File Navigation & Search

| Plugin | Description | Key Features |
|--------|-------------|--------------|
| **fzf.vim** | Fuzzy finder | Fast file/text search |
| **vim-clap** | Modern finder | Alternative to FZF |
| **mru** | Recent files | Most recently used |

### 💡 Code Intelligence

| Plugin | Description | Key Features |
|--------|-------------|--------------|
| **LSP** | Language servers | Completion, diagnostics |
| **ALE** | Linting engine | Real-time checks |
| **GitHub Copilot** | AI completion | Context-aware code |

### 🔀 Version Control

| Plugin | Description | Key Features |
|--------|-------------|--------------|
| **vim-fugitive** | Git wrapper | Complete Git integration |
| **vim-rhubarb** | GitHub support | Browse on GitHub |
| **vim-gitgutter** | Diff indicators | Show changes in gutter |
| **git-messenger** | Commit viewer | Popup commit info |

### ✏️ Editing Power

| Plugin | Description | Key Features |
|--------|-------------|--------------|
| **vim-visual-multi** | Multiple cursors | Simultaneous edits |
| **vim-surround** | Surround text | Quotes, brackets |
| **vim-commentary** | Comments | Quick commenting |
| **auto-pairs** | Auto-close | Smart pairing |
| **vim-subversive** | Substitution | Advanced replace |
| **vim-abolish** | Case coercion | Smart case handling |
| **vim-cutlass** | Better delete | Separate cut/delete |
| **vim-yoink** | Yank history | Cycle through yanks |

### 🎨 Visual & UI

| Plugin | Description | Key Features |
|--------|-------------|--------------|
| **vim-mistfly-statusline** | Status line | Beautiful, informative |
| **vim-devicons** | File icons | Nerd Font icons |
| **indentLine** | Indent guides | Visual levels |
| **vim-highlightedyank** | Highlight yanks | Visual feedback |
| **vim-illuminate** | Highlight word | Better visibility |
| **vim-diminactive** | Dim inactive | Focus indicator |
| **Colorizer** | Color preview | Show hex colors |

### 🪟 Window & Buffer Management

| Plugin | Description | Key Features |
|--------|-------------|--------------|
| **vim-choosewin** | Window chooser | Interactive nav |
| **vim-zoom** | Window zoom | Toggle maximize |
| **goyo.vim** | Distraction-free | Centered writing |
| **vim-bbye** | Buffer delete | Preserve layout |
| **vim-visual-split** | Smart splits | Selection-based |

### 🎯 Text Objects & Motion

| Plugin | Description | Key Features |
|--------|-------------|--------------|
| **targets.vim** | Extra text objects | More targets |
| **vim-indent-object** | Indent object | `cii`, `dai` |
| **vim-easymotion** | Fast navigation | Jump with hints |

### 🛠️ Development Tools

| Plugin | Description | Key Features |
|--------|-------------|--------------|
| **vim-rest-console** | HTTP client | API testing |
| **vim-table-mode** | Table formatting | Markdown tables |
| **vim-markdown-composer** | Markdown preview | Live preview |
| **vCoolor** | Color picker | Visual selection |
| **vim-gtfo** | Open externally | Terminal/file manager |
| **bufferize.vim** | Command output | Interact with output |

### 📚 Documentation & Help

| Plugin | Description | Key Features |
|--------|-------------|--------------|
| **vim-which-key** | Key binding help | Show mappings |
| **undotree** | Undo history | Visual tree |
| **scratch.vim** | Scratch buffer | Persistent notes |
| **vim-over** | Preview substitution | See changes live |
| **far.vim** | Find and replace | Multi-file ops |

## Custom Functions

### 📑 BufferTabLine()
Creates a tab-like display of open buffers in the tabline with:
- Buffer numbers for quick access
- Filename display
- Modified indicator (`*`)
- Current buffer highlighting

### 🧹 DeleteHiddenBuffers()
Cleans up the buffer list by removing all hidden buffers while preserving:
- Visible buffers in current tab
- Buffers visible in other tabs
- Modified buffers (with confirmation)

### 🔧 ResizeMode()
Interactive window resizing mode:
- Arrow keys or `hjkl` to resize
- Adjusts by 2 lines/columns per press
- `Esc` to exit mode
- Visual feedback

### 🔔 Alert(msg)
Display system alerts:
- Shows message on VimEnter
- Used by LSP for server status
- Non-blocking notifications

### 📐 Automatic Layout
Smart file arrangement when opening multiple files:
- **2 files**: Side-by-side vertical split
- **3 files**: 2 on top, 1 full-width bottom
- **4 files**: 2x2 grid layout
- Preserves current buffer position

## Language Server Protocol

### 🖥️ Configured Language Servers

| Language | Server | Installation | Features |
|----------|--------|-------------|----------|
| **Rust** | rust-analyzer | `rustup component add rust-analyzer` | Full Rust support |
| **Python** | Pyright | `npm install -g pyright` | Type checking |
| **Python** | Doc-LSP | Custom installation | Documentation |
| **Bash** | bash-language-server | `npm install -g bash-language-server` | Shell scripts |
| **YAML** | yaml-language-server | `npm install -g yaml-language-server` | Schema validation |
| **TOML** | Tombi | `cargo install tombi` | TOML support |

### ⚡ LSP Features

- **Auto-completion**: Context-aware suggestions with documentation
- **Diagnostics**: Real-time error and warning detection
- **Go to Definition**: Jump to symbol declarations
- **Hover Information**: Type information and documentation
- **Code Actions**: Quick fixes, refactoring, imports
- **Semantic Highlighting**: Language-aware syntax coloring
- **Signature Help**: Function parameter hints
- **References**: Find all usages of symbols

### 🔧 LSP Configuration Options

| Option | Setting | Description |
|--------|---------|-------------|
| `autoComplete` | `true` | Enable auto-completion |
| `autoHighlight` | `false` | Highlight symbol under cursor |
| `autoHighlightDiags` | `true` | Highlight diagnostic regions |
| `semanticHighlight` | `true` | Enhanced syntax highlighting |
| `showDiagInBalloon` | `true` | Show diagnostics in popup |
| `showSignature` | `true` | Show function signatures |

## FlagMarks System

A powerful custom global marks manager with enhanced features beyond Vim's built-in marks.

### ✨ Features

- **Visual Indicators**: Shows marks in the sign column with `>X` format
- **Window-Aware Navigation**: Intelligently switches windows when jumping
- **Interactive Menu**: Popup selector with file previews
- **Jump History**: Toggle between last two marks with `mm`
- **Quickfix Integration**: View all marks in quickfix list
- **Persistent Across Sessions**: Global marks saved in viminfo

### 🎯 Mark Operations

| Key | Action | Window Behavior |
|-----|--------|-----------------|
| `ma` | Add mark | Creates at cursor |
| `md` | Delete mark | Removes from line |
| `mc` | Clear file marks | Remove all in file |
| `mC` | Clear all marks | Global cleanup |
| `ml` | List marks | Show all marks |
| `mt` | Toggle signs | Show/hide indicators |
| `mq` | Quickfix list | Populate quickfix |

### 🚀 Navigation (Window-Aware)

| Key | Action | Description |
|-----|--------|-------------|
| `mm` | Toggle marks | Jump between last two |
| `mn` | Next mark | Cycle forward |
| `mp` | Previous mark | Cycle backward |
| `,m` | Mark menu | Interactive selector |
| `mga-z` | Go to mark A-Z | Direct jump |

### 📌 Navigation (Same-Window)

| Key | Action | Description |
|-----|--------|-------------|
| `Mm` | Toggle marks | Stay in window |
| `Mn` | Next mark | Same window |
| `Mp` | Previous mark | Same window |
| `,M` | Mark menu | Same window menu |
| `Mga-z` | Go to mark A-Z | Same window jump |

### 📋 Commands

| Command | Description |
|---------|-------------|
| `:FlagAdd` | Add mark at cursor position |
| `:FlagDelete` | Delete mark on current line |
| `:FlagList` | Display all marks in list |
| `:FlagMenu` | Open interactive menu |
| `:FlagMenuWindow` | Menu with window awareness |
| `:FlagMenuSame` | Menu in same window |
| `:FlagQuick` | Populate quickfix list |
| `:FlagToggle` | Toggle sign visibility |
| `:FlagClearFile` | Clear marks in current file |
| `:FlagClearAll` | Clear all global marks |
| `:FlagGo [mark]` | Jump to specific mark |

## Configuration Files

### 📄 options.vim
Core Vim settings:
- **Display**: Line numbers (relative/absolute), colors
- **Editing**: Tab settings (4 spaces), indentation
- **Search**: Incremental search, highlighting, smart case
- **Behavior**: Hidden buffers, undo persistence
- **Interface**: Status line, tab line, wildmenu

### 🔌 plugins.vim
Plugin management:
- Auto-installation of vim-plug
- Plugin declarations with lazy loading
- Plugin-specific configurations
- Conditional loading based on dependencies
- Key mapping definitions for plugins

### ⌨️ mappings.vim
Key mappings organized by category:
- Leader key configuration
- Normal, Insert, Visual, Command mode maps
- Buffer and window navigation
- Text manipulation shortcuts
- Emacs-style bindings in insert mode

### 📜 commands.vim
Custom commands and autocommands:
- **EHere**: Open file relative to current directory
- **Line number toggle**: Relative in normal, absolute in insert
- **Auto-reload**: Detect external file changes
- **Auto-session**: Save/restore session automatically

### 🔧 lsp.vim
Language server configurations:
- Global LSP options and behaviors
- Server-specific settings and initialization
- Path configurations for each server
- Workspace configurations
- Error handling and alerts

### 🎨 custom_colors.vim
Color scheme adjustments:
- Mistfly status line mode colors
- Event-based color reapplication
- Plugin compatibility fixes
- Window focus indicators

## Customization

### 🔧 Extension Points

The configuration supports custom extensions without modifying core files:

| File | Purpose |
|------|---------|
| `custom.options.vim` | Personal Vim settings |
| `custom.plugins.vim` | Additional plugins |
| `custom.lsp.vim` | Extra language servers |
| `custom.mappings.vim` | Personal key bindings |

### 📝 Creating Custom Extensions

1. **Custom Options Example:**
   ```vim
   " ~/.vim/custom.options.vim
   set scrolloff=10
   set colorcolumn=80
   ```

2. **Custom Plugin Example:**
   ```vim
   " ~/.vim/custom.plugins.vim
   Plug 'preservim/nerdtree'
   let g:NERDTreeShowHidden = 1
   ```

3. **Custom LSP Example:**
   ```vim
   " ~/.vim/custom.lsp.vim
   if executable('typescript-language-server')
       call LspAddServer([#{
           \ name: 'typescript',
           \ filetype: ['javascript', 'typescript'],
           \ path: 'typescript-language-server',
           \ args: ['--stdio']
       \ }])
   endif
   ```

## Tips and Tricks

### 🚀 Productivity Boosters

1. **Quick File Switch**: Use `,<Tab>` to toggle between two files
2. **Multi-Cursor Replace**: `Ctrl+D` then `c` to change all occurrences
3. **Smart Substitution**: Visual select, then `s` to replace with yanked text
4. **Quick Save All**: `:wa` to write all modified buffers
5. **Jump History**: `Ctrl+O` and `Ctrl+I` to navigate jumps

### 🔍 Search Techniques

1. **Project Search**: `,F` then type to search entire project
2. **Buffer Search**: `,l` to search lines in current file
3. **Word Boundary**: Use `\<word\>` in search for exact matches
4. **Search History**: `/` then `↑` to access search history

### 💡 LSP Best Practices

1. **Quick Documentation**: Hover with `,k` instead of looking up docs
2. **Smart Imports**: Use `,a` to auto-import missing modules
3. **Refactoring**: Use `,a` for rename and extract functions
4. **Error Navigation**: `:LspDiagNext` and `:LspDiagPrev`

### 🎯 FlagMarks Strategies

1. **Project Bookmarks**: Mark important files with A-E
2. **Task Tracking**: Mark TODOs with sequential letters
3. **Debug Points**: Mark debugging locations temporarily
4. **Quick Toggle**: Use `mm` to jump between two work areas

## Troubleshooting

### 🔧 Common Issues and Solutions

#### Plugins Not Loading
```vim
:PlugInstall    " Install missing plugins
:PlugUpdate     " Update all plugins
:PlugClean      " Remove unused plugins
```

#### LSP Not Working
1. Check server installation:
   ```vim
   :LspServers
   ```
2. Verify server paths in `lsp.vim`
3. Check for error messages:
   ```vim
   :messages
   ```

#### FZF Not Finding Files
1. Install fzf binary:
   ```bash
   brew install fzf    # macOS
   apt install fzf     # Ubuntu
   ```
2. Install ripgrep for text search:
   ```bash
   brew install ripgrep
   ```

#### Colors Look Wrong
1. Ensure terminal supports true colors
2. Check termguicolors:
   ```vim
   :set termguicolors?
   ```
3. Try a different terminal emulator

#### Slow Startup
1. Profile startup:
   ```bash
   vim --startuptime startup.log
   ```
2. Disable unused plugins in `plugins.vim`
3. Use lazy loading for heavy plugins

#### Icons Not Showing
1. Install a Nerd Font:
   ```bash
   brew tap homebrew/cask-fonts
   brew install --cask font-hack-nerd-font
   ```
2. Configure terminal to use the font

## Contributing

Contributions are welcome! When contributing:

1. **Follow Structure**: Maintain the modular organization
2. **Document Changes**: Update relevant documentation
3. **Test Thoroughly**: Ensure changes work on Vim 9+
4. **Code Style**: Match existing formatting and conventions
5. **Commit Messages**: Use clear, descriptive messages

## License

This configuration is provided as-is for personal and commercial use. Feel free to adapt it to your needs.

## Acknowledgments

Special thanks to:
- All plugin authors for their amazing work
- The Vim community for continuous innovation
- Contributors and users of this configuration

## Support

For issues, questions, or suggestions:
- Open an issue on [GitHub](https://github.com/rochacbruno/.vim)
- Check existing issues for solutions
- Provide Vim version and error messages when reporting bugs

---

*Happy Vimming! 🚀*
