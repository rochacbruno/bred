# MapDocs - Vim Mapping Documentation System

MapDocs is a Vimscript plugin that provides an integrated documentation and execution system for Vim key mappings. It allows you to document your mappings and access them through an interactive FZF menu.

## Features

- **Inline Documentation**: Document mappings as you create them
- **Document Existing Mappings**: Add documentation for built-in Vim commands and plugin mappings without overriding them
- **Interactive FZF Menu**: Browse and execute mappings through a searchable interface
- **Category Organization**: Group related mappings into categories
- **Smart Sorting**: Uncategorized mappings appear first, followed by categorized ones, all sorted alphabetically by description
- **Multiple Display Modes**: View mappings in FZF or in a buffer

## Installation

Source the `mapdocs.vim` file in your vimrc:

```vim
source ~/.vim/mapdocs.vim
```

**Requirements**: 
- Vim 8.0+ or Neovim
- FZF and fzf.vim plugin installed (for ShowDocs command)

## Commands

### Mapping Commands

MapDocs provides enhanced mapping commands that combine mapping creation with documentation:

- `Nmap` - Normal mode mappings
- `Imap` - Insert mode mappings  
- `Vmap` - Visual and Select mode mappings
- `Xmap` - Visual mode only mappings
- `Omap` - Operator-pending mappings
- `Cmap` - Command-line mode mappings
- `Tmap` - Terminal mode mappings

### Syntax

```vim
" Create a new mapping with documentation
Nmap 'description|category' <lhs> <rhs>

" Document an existing mapping (no <rhs>)
Nmap 'description|category' <lhs>
```

### Examples

```vim
" Create new mappings with documentation
Nmap 'Find files using Telescope|files' <leader>ff :Telescope find_files<CR>
Nmap 'Live grep using Telescope|files' <leader>fg :Telescope live_grep<CR>
Nmap 'List open buffers|files' <leader>fb :Telescope buffers<CR>

" Document existing Vim built-in mappings (without creating new ones)
Nmap 'Split window vertically|windows' <C-w>v
Nmap 'Split window horizontally|windows' <C-w>s
Nmap 'Navigate to window below|windows' <C-w>j

" Mappings without categories (top-level)
Nmap 'Undo last change' u
Nmap 'Search forward' /
Nmap 'Search backward' ?
```

## Data Structure

MapDocs stores documentation in a global dictionary `g:mapdocs` with the following structure:

```vim
g:mapdocs = {
  'n': {
    'u': 'Undo last change',              " Top-level mapping
    '/': 'Search forward',                " Top-level mapping
    'files': {                            " Category
      '<leader>ff': 'Find files using Telescope',
      '<leader>fg': 'Live grep using Telescope'
    },
    'windows': {                          " Category
      '<C-w>v': 'Split window vertically',
      '<C-w>s': 'Split window horizontally'
    }
  }
}
```

Additionally, `g:mapdocs_created` tracks which mappings were created by MapDocs (vs. just documented):

```vim
g:mapdocs_created = {
  'n': ['<leader>ff', '<leader>fg']  " Keys of mappings created by MapDocs
}
```

## Display Commands

### `ShowDocs [modes]`

Opens an interactive FZF menu displaying documented mappings. 

**Usage:**
```vim
:ShowDocs         " Show all mappings in default order (nvxicot)
:ShowDocs n       " Show only normal mode mappings
:ShowDocs ni      " Show normal and insert mode mappings (in that order)
:ShowDocs vx      " Show visual mode mappings (v first, then x)
:ShowDocs nvxicot " Explicit default order
```

**Mode Order:**
- Default order when no modes specified: `nvxicot` (Normal, Visual, V-Line, Insert, Command, Operator, Terminal)
- When modes are specified, they appear in the exact order given
- Modes not included in the default order appear at the end
- Within each mode, mappings are sorted alphabetically by category and description

**Features:**
- Filter by mode(s) using single-letter mode identifiers (n, i, v, x, o, c, t)
- Search through mappings with fuzzy finding
- See mode, key combination, category, and description
- Press Enter to execute the selected mapping (except for insert and terminal modes)
- Press ESC to close without executing
- Automatically substitutes `<leader>` with your actual leader key in display
- Shows `<Space>` when leader key is set to a literal space
- Respects the order of modes as specified in the command

**Visual Mode with Range:**
```vim
" Select text in visual mode, then:
:'<,'>ShowDocs vx   " Shows visual mappings and preserves your selection
```

**Example display:**
```
[N] <Space>ff       : [files] Find files using Telescope
[N] <Space>fg       : [files] Live grep using Telescope  
[N] u               : Undo last change
[N] /               : Search forward
─────────────────────────────────────────
[N] <C-w>v          : [windows] Split window vertically
[N] <C-w>s          : [windows] Split window horizontally
```

### `BufferDocs [position]`

Opens a read-only buffer displaying all documented mappings in a structured format.

**Arguments:**
- `left` - Opens buffer in left vertical split
- `right` - Opens buffer in right vertical split (default)
- `top` - Opens buffer in top horizontal split
- `bottom` - Opens buffer in bottom horizontal split

**Example:**
```vim
:BufferDocs          " Opens in right split (default)
:BufferDocs left     " Opens in left split
:BufferDocs top      " Opens in top split
```

**Buffer features:**
- Read-only buffer named `*Mapping Docs*`
- Close with `q`, `Esc`, or `Enter`
- Shows mappings organized by mode and category
- Displays actual leader key instead of `<leader>`

## Technical Details

### Key Sequence Handling

MapDocs handles special key sequences properly:
- Simple keys (like `/`, `u`) are sent directly
- Special keys (like `<C-w>v`, `<CR>`) are converted to actual control sequences
- Leader key substitution happens at display and execution time

### Execution Modes

When executing mappings from the FZF menu:
- **Created mappings**: Use 't' flag (execute as typed, honor remappings)
- **Documented mappings**: Use 'm' flag (execute with mapping resolution)

This ensures that both newly created mappings and documented existing mappings execute correctly.

## Limitations

- FZF and fzf.vim are required for the `ShowDocs` command
- Some complex key sequences may not execute properly from the FZF menu
- The plugin clears existing documentation when re-sourced

## Caveats

### Mode-Specific Execution Behavior

**Normal Mode (N):** 
- ✅ Full execution support
- All mappings execute as expected when selected from ShowDocs

**Visual Mode (V/X):**
- ✅ Selection restoration works
- ✅ Simple visual mappings work (commenting, indenting, yanking, etc.)
- ⚠️ Complex window operations (like `<C-w>gsa` visual splits) may not execute properly
- When using with a range (`:'<,'>ShowDocs`), your selection is preserved and restored before executing the mapping

**Insert Mode (I):**
- ℹ️ Shows mapping information only (no execution)
- Displays what the mapping does in the status line
- Window closes after selection, allowing you to manually press the key in insert mode
- This is due to the complexity of programmatically triggering insert mode mappings

**Command Mode (C):**
- ✅ Basic command mode mappings work
- Commands are executed after entering command mode with `:`

**Operator-pending Mode (O):**
- ⚠️ Limited support (falls back to normal mode execution)

**Terminal Mode (T):**
- ℹ️ Shows mapping information only (no execution)
- Displays notification that the mapping should be used in a terminal buffer
- Terminal mappings only work within actual terminal windows

### Leader Key Display

When your leader key is set to a space (`let mapleader = " "`), ShowDocs will display it as `<Space>` for clarity instead of showing an empty space.

### Visual Selection Preservation

The visual selection preservation feature saves:
- The exact start and end positions (line and column)
- The visual mode type (character-wise `v`, line-wise `V`, or block-wise `<C-v>`)
- Restores the selection before executing visual mode mappings

## Tips

1. **Document as you map**: Add documentation inline when creating new mappings
2. **Document existing mappings**: Use the no-RHS syntax to document Vim built-ins
3. **Use categories**: Group related mappings for better organization
4. **Leader key**: The display automatically shows your actual leader key
