# RochaCBruno's Vim 9 Configuration

A modern, modular Vim 9.1 configuration with LSP support, intelligent plugins, and a custom global marks management system.

> [!WARNING]
> This configuration is for Vim 9+ only, NOT for Neovim or older versions of Vim.

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
- **Custom Marks System**: Enhanced global marks with visual indicators
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
| `custom_colors.vim` | Color scheme adjustments |

## Key Mappings

### Leader Key
The leader key is set to `,` (comma).

### 📁 File Navigation

| Key | Action | Description |
|-----|--------|-------------|
| `,f` | `:Files` | Fuzzy find files |
| `,F` | `:Rg` | Search text with ripgrep |
| `,b` | `:Buffers` | List buffers |
| `,l` | `:Lines` | Search lines in current buffer |
| `,g` | `:GFiles` | Git files |
| `,e` | `:Lexplore` | File explorer (left) |
| `,E` | `:Vexplore` | File explorer (vertical) |

### 💾 Essential Operations

| Key | Action | Description |
|-----|--------|-------------|
| `,w` | `:write` | Save file |
| `,q` | `:quit` | Quit |
| `,x` | `:xit` | Save and quit |
| `,h` | `:nohlsearch` | Clear search highlighting |
| `,,so` | `:source ~/.vim/vimrc` | Reload configuration |
| `Ctrl+S` | `:update` | Save (all modes) |
| `Ctrl+Z` | Undo | Undo (all modes) |

### 📑 Buffer Management

| Key | Action | Description |
|-----|--------|-------------|
| `,bl` | List buffers | List and select buffer |
| `[q` | Previous buffer | Navigate backward |
| `]q` | Next buffer | Navigate forward |
| `,1-9` | Jump to buffer | Quick buffer access |
| `,<Tab>` | Toggle buffers | Switch between two buffers |
| `bda` | Delete hidden | Clean up buffer list |

### 🪟 Window Management

| Key | Action | Description |
|-----|--------|-------------|
| `,=` | Increase height | Make window taller |
| `,-` | Decrease height | Make window shorter |
| `,>` | Increase width | Make window wider |
| `,<` | Decrease width | Make window narrower |
| `,rs` | Resize mode | Interactive resizing |
| `-` | Window chooser | Navigate/swap windows |
| `Ctrl+W g` | Goyo mode | Distraction-free writing |

### 🧠 LSP Operations

| Key | Action | Description |
|-----|--------|-------------|
| `,a` | Code actions | Show available actions |
| `,d` | Go to definition | Jump to declaration |
| `,k` | Hover info | Show documentation |

### 🔀 Git Integration

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl+G m` | Git messenger | Show commit under cursor |
| `:Gstatus` | Git status | Fugitive status window |
| `:Gblame` | Git blame | Show line authors |
| `:Gdiff` | Git diff | Compare changes |

### ✏️ Multi-Cursor Editing

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl+D` | Select word | Add cursor at word |
| `n/N` | Next/Previous | Navigate occurrences |
| `[/]` | Cursor navigation | Move between cursors |
| `q` | Skip occurrence | Skip and continue |
| `Q` | Remove cursor | Delete current cursor |
| `\\A` | Select all | Select all occurrences |

### 📝 Text Manipulation

| Key | Action | Description |
|-----|--------|-------------|
| `gcc` | Comment line | Toggle line comment |
| `gc{motion}` | Comment motion | Comment selection |
| `s{motion}` | Substitute | Replace with yanked |
| `ss` | Substitute line | Replace entire line |
| `,re` | Replace word | Replace current word |
| `cs'"` | Change surround | Change ' to " |
| `ds"` | Delete surround | Remove quotes |
| `ysiw'` | Add surround | Wrap word in quotes |

### 🔄 Line Movement

| Key | Action | Description |
|-----|--------|-------------|
| `Alt+j` | Move down | Move line/selection down |
| `Alt+k` | Move up | Move line/selection up |
| `Alt+↓` | Move down | Alternative with arrow |
| `Alt+↑` | Move up | Alternative with arrow |

### 🖥️ Terminal

| Key | Action | Description |
|-----|--------|-------------|
| `,c` | Open terminal | Bottom terminal |
| `Ctrl+V Esc` | Exit terminal | Return to normal mode |

### 🏷️ Tab Management

| Key | Action | Description |
|-----|--------|-------------|
| `,tn` | New tab | Create new tab |
| `,tc` | Close tab | Close current tab |
| `,to` | Tab only | Close other tabs |
| `,tl` | Next tab | Go to next tab |
| `,th` | Previous tab | Go to previous tab |

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
