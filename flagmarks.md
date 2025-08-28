# Flag Marks Manager for Vim

A powerful global marks manager for Vim that provides visual indicators, quick navigation, and enhanced mark management capabilities.

## Features

- **Visual Signs**: Shows marks in the gutter with green `>A`, `>B`, etc. indicators
- **Interactive Popup Menu**: Navigate marks with a visual popup showing file, line, and content preview
- **Smart Window Navigation**: Automatically switches to existing split windows when going to marks
- **Smart File Matching**: Robust file path comparison for accurate mark management
- **Go History**: Toggle between recently visited marks
- **Quickfix Integration**: View all marks in quickfix window for easy navigation
- **Batch Operations**: Clear marks by file or globally

## Installation

Add the following to your `.vimrc`:

```vim
source ~/.vim/flagmarks.vim
```

## Commands

| Command | Description |
|---------|-------------|
| `:FlagAdd` | Add a new global mark at current position (uses next free A-Z) |
| `:FlagDelete` | Delete mark on current line |
| `:FlagNext` | Go to next mark in sequence |
| `:FlagPrev` | Go to previous mark in sequence |
| `:FlagList` | List all marks in a formatted table |
| `:FlagMenu` | Open interactive popup menu to go to marks |
| `:FlagClearFile` | Clear all marks in current file |
| `:FlagClearAll` | Clear all global marks (A-Z) |
| `:FlagToggle` | Toggle visibility of mark signs in gutter |
| `:FlagGo [letter]` | Go to specific mark (window-aware) or toggle between last two |
| `:FlagGoSame [letter]` | Go to specific mark (force same window) |
| `:FlagQuick` | Populate quickfix with all marks |
| `:FlagDebug` | Show debug information about marks and file matching |

## Key Mappings

### Basic Operations (Window-Aware by Default)
| Mapping | Action |
|---------|--------|
| `ma` | Add mark at cursor position |
| `md` | Delete mark on current line |
| `mn` | Go to next mark (switches to existing window if open) |
| `mp` | Go to previous mark (switches to existing window if open) |
| `ml` | List all marks |
| `mc` | Clear marks in current file |
| `mC` | Clear all marks globally |
| `mt` | Toggle sign visibility |
| `mm` | Toggle between last two marks (switches to existing window if open) |
| `mq` | Populate quickfix with all marks |
| `<leader>m` | Open interactive popup menu (window-aware) |

### Direct Go Mappings (Window-Aware)
| Mapping | Action |
|---------|--------|
| `mga` | Go to mark A (switches to existing window if open) |
| `mgb` | Go to mark B (switches to existing window if open) |
| `mgc` | Go to mark C (switches to existing window if open) |
| ... | ... |
| `mgz` | Go to mark Z (switches to existing window if open) |

### Force Same-Window Navigation (Uppercase M)
| Mapping | Action |
|---------|--------|
| `Mm` | Toggle between last two marks (same window) |
| `Mn` | Go to next mark (same window) |
| `Mp` | Go to previous mark (same window) |
| `<leader>M` | Open interactive popup menu (same window) |
| `Mga` - `Mgz` | Go to specific mark A-Z (same window) |

## Popup Menu

The popup menu (triggered by `<leader>m`) shows:
- **Key**: Lowercase letter to press for going
- **File**: Name of the file containing the mark
- **Line**: Line number of the mark
- **Preview**: First 30 characters of the marked line content

### Popup Navigation
- Press `a-z` to go to corresponding mark (A-Z)
- Press `Esc` or `q` to close without going

## Go History

The plugin maintains a history of your last two mark destinations:
- Use `mm` (or `:FlagGo` without arguments) to toggle between them
- History is automatically updated when you go to marks
- Useful for quickly switching between two working locations
- Window-aware by default (use `Mm` to force same window)

## Window-Aware Navigation

By default, all navigation commands are window-aware:
- If the target file is already open in another split window, the cursor moves to that window
- If not, the file opens in the current window
- Use uppercase `M` commands to force navigation in the same window

## Quickfix Integration

Use `mq` to populate the quickfix window with all marks:
- Shows all marks with their locations and line previews
- Navigate using standard quickfix commands (`:cn`, `:cp`)
- Click entries to go directly to marks

## Sign Management

Visual indicators in the gutter can be toggled on/off:
- Signs appear as green `>A`, `>B`, etc. in the sign column
- Use `mt` to toggle visibility
- Signs automatically update when marks change
- Sign column is automatically enabled when plugin loads

## Advanced Usage

### Batch Mark Management
```vim
" Clear all marks in current project file
:FlagClearFile

" Reset all global marks across all files
:FlagClearAll
```

### Quick Navigation Pattern
```vim
" Set marks at important locations
ma  " Mark current position as A
" ... navigate elsewhere ...
mb  " Mark another position as B

" Now toggle between them
mm  " Go to A (switches window if open)
mm  " Go back to B (switches window if open)

" Force same window navigation
Mm  " Go to A (same window)
Mm  " Go back to B (same window)
```

### Direct Go Without Menu
```vim
" Go directly to mark E (window-aware)
mge

" Force same window
Mge

" Or use command form
:FlagGo e       " Window-aware
:FlagGoSame e   " Same window
```

### Using Quickfix
```vim
" View all marks in quickfix
mq

" Navigate quickfix entries
:cn  " Next mark
:cp  " Previous mark
```

## Troubleshooting

If marks aren't working as expected:
1. Run `:FlagDebug` to see parsing and file matching details
2. Check that your Vim version supports `getmarklist()` function
3. Ensure sign column is visible: `:set signcolumn=auto`

## Requirements

- Vim 8.0+ (for sign and popup features)
- Support for `getmarklist()` function

## Configuration

The plugin uses these global variables (set before sourcing):
```vim
" Example: Start with signs hidden
let g:flag_signs_visible = 0
source ~/.vim/flagmarks.vim
```

## Notes

- Only manages global marks (A-Z), not local marks (a-z)
- Marks persist across Vim sessions (standard Vim behavior)
- File path matching handles relative and absolute paths automatically
- Preview shows first 30 non-whitespace characters of marked lines